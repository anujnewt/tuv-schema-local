create or replace procedure usrsiho."sp_hpgpocan"  (pn_nomrep varchar,pn_idepcc varchar,pn_keyusu numeric,pn_keypro numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
ln_keyrec holoreci.rec_keyrec%type;
ln_keyemp holoreci.rec_keyemp%type;
ln_keyper nmloperi.per_keyper%type;
ln_numemi holoreci.rec_numemi%type;
ln_keyplz holocont.con_keyplz%type;
ln_keydep holocont.con_keydep%type;
ln_stspag holocont.con_stspag%type;
ln_capini holohgdp.hgd_capini%type;
ln_capfin holohgdp.hgd_capfin%type;
ln_keytva holocont.con_keytva%type;
ln_keyrph holofrph.frp_keyrph%type;
---aedo
ws_feccob varchar(10);
ws_keyrec holoreci.rec_keyrec%type;
ws_keynom holoreci.rec_keyrec%type;
ws_numemi holoreci.rec_numemi%type;
ws_ejerci holoreci.rec_ejerci%type;
ws_keycat glwkrang.ran_keycat%type;
ws_keypue glwkrang.ran_keypue%type;
ws_keydep glwkrang.ran_keydep%type;
ln_num numeric(10);
ln_keycon nmlohism.his_keycon%type;
ln_keycap holococa.coc_keycap%type;
ln_ejerci holoreci.rec_ejerci%type;
--nvas variables para prestamos
ln_keycop nmlohism.his_keycon%type;
ln_keypre nmlopres.pre_keypre%type;
ln_impre  nmlohism.his_import%type;
--fin nvas variables prestamos
ln_acum nmlohism.his_import%type;
ln_nummes nmloperi.per_nummes%type;
rec record;
rec2 record;
rec3 record;
rec4 record;
rec5 record;
rec6 record;
rec7 record;
begin
---aedo 14/feb/05
--- se agrego el siguiente update e insert, asi como el lock, estos venian en el proyecto y se pidio quitarlos de ahi.
begin
select distinct ran_keycen
into strict ws_feccob
from usrsiho.glwkrang
where ran_nomrep = pn_nomrep
and ran_idepcc = pn_idepcc
and ran_keyusu = pn_keyusu
and nullif(ran_keycen::text, '') is not null;
exception when no_data_found then ws_feccob:= null;
end;
begin
select distinct ran_keynom
into strict ws_keynom
from usrsiho.glwkrang
where ran_nomrep = pn_nomrep
and ran_idepcc = pn_idepcc
and ran_keyusu = pn_keyusu
and nullif(ran_keynom::text, '') is not null;
exception when no_data_found then ws_keynom := 0;
end;
begin
select distinct ran_keycat
into strict ws_keycat
from usrsiho.glwkrang
where ran_nomrep = pn_nomrep
and ran_idepcc = pn_idepcc
and ran_keyusu = pn_keyusu
and nullif(ran_keycat::text, '') is not null;
exception when no_data_found then ws_keycat := 0;
end;
begin
select distinct ran_keypue
into strict ws_keypue
from usrsiho.glwkrang
where ran_nomrep = pn_nomrep
and ran_idepcc = pn_idepcc
and ran_keyusu = pn_keyusu
and nullif(ran_keypue::text, '') is not null;
exception when no_data_found then ws_keypue := 0;
end;
for rec  in (select distinct ran_keydep
from usrsiho.glwkrang
where ran_nomrep = pn_nomrep
and ran_idepcc = pn_idepcc
and ran_keyusu = pn_keyusu
and nullif(ran_keydep::text, '') is not null) loop
ws_keydep := rec.ran_keydep;
update usrsiho.holoreci
set rec_stsrec = 2,
rec_feccob = ws_feccob
where rec_keypro = pn_keypro
and rec_keynom = ws_keynom
and rec_numemi = ws_keycat
and rec_ejerci = ws_keypue
and rec_keyrec = ws_keydep;
end loop;
---                    delete from glwkrang
---             where ran_nomrep = pn_nomrep
---               and ran_idepcc = pn_idepcc
---               and ran_keyusu = pn_keyusu;
---  foreach   select distinct pn_nomrep,pn_idepcc, pn_keyusu, pn_keypro,
for rec2   in (select rec_keyrec,rec_keynom,rec_numemi,rec_ejerci
from usrsiho.holoreci
where rec_keypro = pn_keypro
and rec_keynom = ws_keynom
and rec_numemi = ws_keycat
and rec_stsrec = 2
and rec_feccob = ws_feccob
and rec_ejerci = ws_keypue
and rec_keyrec in (select distinct ran_keydep from usrsiho.glwkrang
where ran_nomrep = 'Extras1'
and ran_idepcc = pn_idepcc
and ran_keyusu = pn_keyusu)) loop
ws_keyrec := rec2.rec_keyrec;
ws_keynom := rec2.rec_keynom;
ws_numemi := rec2.rec_numemi;
ws_ejerci := rec2.rec_ejerci;
insert into usrsiho.glwkrang(ran_nomrep, ran_idepcc, ran_keyusu, ran_keypro, ran_keyemp,
ran_keynom, ran_keycen,ran_keycat)
values (pn_nomrep, pn_idepcc, pn_keyusu, pn_keypro, ws_keyrec,
ws_keynom, ws_numemi,ws_ejerci);
end loop;
---        delete from glwkrang
---        where ran_nomrep ='Extras1'
---        and ran_idepcc = pn_idepcc
---        and ran_keyusu = pn_keyusu;
---            delete from glwkrang
---            where ran_nomrep = pn_nomrep
---            and ran_idepcc = pn_idepcc
---            and ran_keyusu = pn_keyusu;
-----aedo termina cambio
-- busqueda de periodos de los recibos
for rec3 in (select distinct rec_keyrec,rec_keyemp,per_keyper,rec_numemi,per_nummes,rec_ejerci
from usrsiho.holoreci,
usrsiho.nmloperi,
usrsiho.glwkrang
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
-- nuevo 23/01/2004
ln_keyrec := rec3.rec_keyrec;
ln_keyemp := rec3.rec_keyemp;
ln_keyper := rec3.per_keyper;
ln_numemi := rec3.rec_numemi;
ln_nummes := rec3.per_nummes;
ln_ejerci := rec3.rec_ejerci;
update usrsiho.holoreci set rec_stsrec=2
where rec_ejerci = ln_ejerci
and rec_keypro = pn_keypro
and rec_keyrec = ln_keyrec;/* dmap converted statement start */
-- nuevo 20/10/2003
update usrsiho.nmlohism set his_ca1aux = oracle. concat(substr(his_ca1aux,1,3), '2', oracle.substr(his_ca1aux,5,10) ) -- his_ca1aux[4]='2'
where his_keypro = pn_keypro
and his_keyper = ln_keyper
and his_keyemp = ln_keyemp;/* dmap converted statement end */
-- busqueda de los contratos
for rec4 in (select con_keyplz,con_keydep,con_stspag, hgd_capini,
hgd_capfin,con_keytva,frp_keyrph
from usrsiho.holohgdp,
usrsiho.holocont,
usrsiho.holofrph
where frp_keypro=pn_keypro
and frp_keyper=ln_keyper
and frp_keyrph=hgd_keyrph
and hgd_keyemp=ln_keyemp
and hgd_keytco=con_keytco
and hgd_keyfol=con_keyfol) loop
--        select max(coc_numsec)
--         into ln_num
--         from holococa
--         where coc_keyplz = ln_keyplz
--         and coc_keycap between ln_capini and ln_capfin;
ln_keyplz := rec4.con_keyplz;
ln_keydep := rec4.con_keydep;
ln_stspag := rec4.con_stspag;
ln_capini := rec4.hgd_capini;
ln_capfin := rec4.hgd_capfin;
ln_keytva := rec4.con_keytva;
ln_keyrph := rec4.frp_keyrph;
update usrsiho.holocont
set con_numcdi = con_numcdi + (ln_capfin - ln_capini + 1),con_stspag='V'
where con_keyplz = ln_keyplz;
update usrsiho.holococa
set coc_stspag = 'C'
where coc_keyplz = ln_keyplz
and coc_keycap between ln_capini and ln_capfin
and coc_keyrph=ln_keyrph;
--se cancela la hoja de trabajo jcro 20 noviembre 2009
-- -----------------------------------------------------
update usrsiho.holodettra
set det_stsreg = 'C'
where det_serial in (
select coc_reghja
from usrsiho.holococa
where coc_keyplz = ln_keyplz
and coc_keycap between ln_capini and ln_capfin
and coc_keyrph=ln_keyrph
);
-- -----------------------------------------------------
-- -------------------- nuevo 20 mzo de 2003
if ln_keytva = 1 then
--          insert into holocanc
--          select *
--            from usrsiho.holococa
--           where 1 = 0
--           ;
for rec5 in (select coc_keycap,max(coc_numsec) maximo
from usrsiho.holococa
where coc_keyplz = ln_keyplz
and coc_keycap between ln_capini and ln_capfin
group by coc_keycap) loop
ln_keycap := rec5.coc_keycap;
ln_num := rec5.maximo;
insert into usrsiho.holocanc
select *
from usrsiho.holococa
where coc_keyplz = ln_keyplz
and coc_keycap =ln_keycap
and coc_numsec =ln_num;
end loop;
-- --------------------------------------
update usrsiho.holocanc
set coc_hjatra = null,coc_reghja = null,coc_keyrph = null, coc_keygdp = null, coc_stspag='V', coc_numsec=coc_numsec + 1;
insert into usrsiho.holococa
select * from usrsiho.holocanc;
end if;
end loop;
-- eliminacion de ispt
for rec6 in (select his_keycon,his_import
from usrsiho.nmlohism
where his_keypro = pn_keypro
and his_keyper = ln_keyper
and his_keyemp = ln_keyemp
and his_keycon in (
select upper(pam_folini) pam_folini
from usrsiho.glcopams
where pam_keypar = 'PACA'
)) loop
--     'HPG','H53','H76','28D')
ln_keycon := rec6.his_keycon;
ln_acum := rec6.his_import;
if ln_nummes = 1 then
update usrsiho.nmloacum set acu_impuno = acu_impuno - ln_acum
where acu_keyemp = ln_keyemp
and acu_keycon = ln_keycon;
end if;
if ln_nummes = 2 then
update usrsiho.nmloacum set acu_impdos = acu_impdos - ln_acum
where acu_keyemp = ln_keyemp
and acu_keycon = ln_keycon;
end if;
if ln_nummes = 3 then
update usrsiho.nmloacum set acu_imptre = acu_imptre - ln_acum
where acu_keyemp = ln_keyemp
and acu_keycon = ln_keycon;
end if;
if ln_nummes = 4 then
update usrsiho.nmloacum set acu_impcua = acu_impcua- ln_acum
where acu_keyemp = ln_keyemp
and acu_keycon = ln_keycon;
end if;
if ln_nummes = 5 then
update usrsiho.nmloacum set acu_impcin = acu_impcin - ln_acum
where acu_keyemp = ln_keyemp
and acu_keycon = ln_keycon;
end if;
if ln_nummes = 6 then
update usrsiho.nmloacum set acu_impsei = acu_impsei - ln_acum
where acu_keyemp = ln_keyemp
and acu_keycon = ln_keycon;
end if;
if ln_nummes = 7 then
update usrsiho.nmloacum set acu_impsie = acu_impsie - ln_acum
where acu_keyemp = ln_keyemp
and acu_keycon = ln_keycon;
end if;
if ln_nummes = 8 then
update usrsiho.nmloacum set acu_impoch = acu_impoch - ln_acum
where acu_keyemp = ln_keyemp
and acu_keycon = ln_keycon;
end if;
if ln_nummes = 9 then
update usrsiho.nmloacum set acu_impnue = acu_impnue - ln_acum
where acu_keyemp = ln_keyemp
and acu_keycon = ln_keycon;
end if;
if ln_nummes = 10 then
update usrsiho.nmloacum set acu_impdie = acu_impdie - ln_acum
where acu_keyemp = ln_keyemp
and acu_keycon = ln_keycon;
end if;
if ln_nummes = 11 then
update usrsiho.nmloacum set acu_imponc = acu_imponc - ln_acum
where acu_keyemp = ln_keyemp
and acu_keycon = ln_keycon;
end if;
if ln_nummes = 12 then
update usrsiho.nmloacum set acu_impdoc = acu_impdoc - ln_acum
where acu_keyemp = ln_keyemp
and acu_keycon = ln_keycon;
end if;
end loop;
--busqueda de prestamos a actualizar
for rec7 in (select his_keycon,his_import,his_rowide
from usrsiho.nmlohism
where his_keyemp = ln_keyemp
and his_keyper = ln_keyper
and his_keycon in (select distinct pre_keycon
from usrsiho.nmlopres
where pre_keycon <> 'HPA')) loop
ln_keycop := rec7.his_keycon;
ln_impre := rec7.his_import;
ln_keypre := rec7.his_rowide;
update usrsiho.nmlopres
set pre_impsal = pre_impsal + ln_impre,
pre_impamo = pre_impamo - ln_impre
where pre_keyemp = ln_keyemp
and pre_keycon = ln_keycop
and pre_keypre = ln_keypre;
insert into usrsiho.precan
select *
from usrsiho.nmloamor
where amo_keyemp = ln_keyemp
and amo_keycon = ln_keycop
and amo_keypre = ln_keypre
and amo_keyper = ln_keyper
;
insert into usrsiho.nmloamor(amo_keyemp,amo_keycon,amo_keypre,amo_refere,amo_keypro,
amo_keydep,amo_keypue,amo_keycat,amo_keyubi,amo_keyper,
amo_keynom,amo_numpag,amo_tiptra,amo_refpag,
amo_fecpag,amo_imppag, amo_unipag,amo_intpag,
amo_porint,amo_uniope)
select amo_keyemp,amo_keycon,amo_keypre,amo_refere,amo_keypro,
amo_keydep,amo_keypue,amo_keycat,amo_keyubi,amo_keyper,
amo_keynom,amo_numpag,'E','CANCELACIO',
amo_fecpag,(amo_imppag *(-1)),amo_unipag,amo_intpag,
amo_porint,amo_uniope
from usrsiho.precan
where amo_keyemp = ln_keyemp
and amo_keycon = ln_keycop
and amo_keypre = ln_keypre
and amo_keyper = ln_keyper;
end loop;
end loop;end;
$body$
language plpgsql
;
