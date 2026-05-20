create or replace procedure usrsiho."sp_hrpcanda_rev"  (pn_nomrep varchar,pn_idepcc varchar,pn_keyusu numeric,pn_keypro numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
ln_keyrec holoreci_ter.rec_keyrec%type;
ln_keyemp holoreci_ter.rec_keyemp%type;
ln_keyper nmloperi.per_keyper%type;
ln_numemi holoreci_ter.rec_numemi%type;
ln_keyplz holocont.con_keyplz%type;
ln_keydep holocont.con_keydep%type;
ln_stspag holocont.con_stspag%type;
ln_capini holohgdp.hgd_capini%type;
ln_capfin holohgdp.hgd_capfin%type;
ln_keytva holocont.con_keytva%type;
ln_keyrph holofrph.frp_keyrph%type;
---aedo
ws_feccob varchar(10);
ws_keyrec holoreci_ter.rec_keyrec%type;
ws_keynom holoreci_ter.rec_keyrec%type;
ws_numemi holoreci_ter.rec_numemi%type;
ws_ejerci holoreci_ter.rec_ejerci%type;
ws_keycat glwkrang.ran_keycat%type;
ws_keypue glwkrang.ran_keypue%type;
ws_keydep glwkrang.ran_keydep%type;
ln_num numeric(10);
ln_keycon nmlohism.his_keycon%type;
ln_keycap holococa.coc_keycap%type;
ln_ejerci holoreci_ter.rec_ejerci%type;
--nvas variables para prestamos
ln_keycop nmlohism.his_keycon%type;
ln_keypre nmlopres.pre_keypre%type;
ln_impre  nmlohism.his_import%type;
--fin nvas variables prestamos
ln_acum nmlohism.his_import%type;
ln_nummes nmloperi.per_nummes%type;
rec record;
rec2 record;
begin
---aedo 14/feb/05
--- se agrego el siguiente update e insert, asi como el lock, estos venian en el proyecto y se pidio quitarlos de ahi.
--set lock mode to wait;
-- busqueda de periodos de los recibos
for rec in (select distinct rec_keyrec, rec_keyemp, per_keyper, rec_numemi, per_nummes, rec_ejerci
from usrsiho.holoreci, usrsiho.nmloperi, usrsiho.glwkrang
where ran_nomrep = pn_nomrep
and ran_idepcc = pn_idepcc
and ran_keyusu = pn_keyusu
and ran_keypro = pn_keypro
and trim(both ran_keycat) = rec_ejerci
and ran_keypro = rec_keypro
and ran_keyemp = rec_keyrec
and rec_keypro = per_keypro
and rec_keyapr = per_nu3aux
and rec_keynom = per_keynom
and rec_numemi = per_nu4aux) loop
--si es p, es el registro activo que va a procesar
-- nuevo 20/10/2003
ln_keyrec := rec.rec_keyrec;
ln_keyemp := rec.rec_keyemp;
ln_keyper := rec.per_keyper;
ln_numemi := rec.rec_numemi;
ln_nummes := rec.per_nummes;
ln_ejerci := rec.rec_ejerci;/* dmap converted statement start */
update usrsiho.nmlohism set his_ca1aux = trim(both oracle. concat(substr(his_ca1aux, 1, 3), '4' , coalesce(oracle.substr(his_ca1aux, 5, 12), ' '))
) where his_keypro = pn_keypro
and his_keyper = ln_keyper
and his_keyemp = ln_keyemp;/* dmap converted statement end */
--busqueda de prestamos a actualizar
for rec2 in (select his_keycon, his_import, his_rowide
from usrsiho.nmlohism
where his_keyemp = ln_keyemp
and his_keyper = ln_keyper
and his_keypro = pn_keypro
and his_keycon in (select distinct pre_keycon
from usrsiho.nmlopres
where pre_keycon <> 'HPA')) loop
ln_keycop := rec2.his_keycon;
ln_impre := rec2.his_import;
ln_keypre := rec2.his_rowide;
update usrsiho.nmlopres
set pre_impsal = pre_impsal + ln_impre,
pre_impamo = pre_impamo - ln_impre
where pre_keyemp = ln_keyemp
and pre_keycon = ln_keycop
and pre_keypro = pn_keypro
and pre_keypre = ln_keypre;
insert into usrsiho.nmloamor_tmp
select *
from nmloamor
where amo_keyemp = ln_keyemp
and amo_keycon = ln_keycop
and amo_keypre = ln_keypre
and amo_keyper = ln_keyper
;
insert into usrsiho.nmloamor(amo_keyemp, amo_keycon, amo_keypre, amo_refere, amo_keypro,
amo_keydep, amo_keypue, amo_keycat, amo_keyubi, amo_keyper,
amo_keynom, amo_numpag, amo_tiptra, amo_refpag,
amo_fecpag, amo_imppag, amo_unipag, amo_intpag,
amo_porint, amo_uniope)
select amo_keyemp, amo_keycon, amo_keypre, amo_refere, amo_keypro,
amo_keydep, amo_keypue, amo_keycat, amo_keyubi, amo_keyper,
amo_keynom, amo_numpag, 'E', 'CANCEL',
amo_fecpag, (amo_imppag *(-1)), amo_unipag, amo_intpag,
amo_porint, amo_uniope
from usrsiho.nmloamor_tmp
where amo_keyemp = ln_keyemp
and amo_keycon = ln_keycop
and amo_keypre = ln_keypre
and amo_keyper = ln_keyper;
end loop;
end loop;end;
$body$
language plpgsql
;
