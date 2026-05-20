create or replace procedure usrsiho."sp_hpgimprenew_3"  (ws_nomrep varchar, ws_idepcc varchar, wn_keyusu numeric, wn_lenpro numeric, wn_lennom numeric, wn_lstemp numeric, wn_lenemi numeric, ws_tporec varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
wn_numsec  numeric(10);  -- cry_numsec
wn_perini  numeric(10);  -- cry_dec008
wn_perfin  numeric(10);  -- cry_dec009
wn_numrec  numeric(10);  -- cry_dec010
wn_keyemp  numeric(10);  -- cry_dec011
wn_numcap  numeric(10);  -- cry_dec012
wn_keyrph  numeric(10);  -- cry_dec013
wn_capini  numeric(10);  -- cry_dec014
wn_capfin  numeric(10);  -- cry_dec015
wn_cosuni  numeric;    -- cry_dec018
wn_costot  numeric;    -- cry_dec019
wn_rowide  numeric;    -- campo agregado para la desagrupacion de descuentos sitatyr - marzo 2010
wn_costot1 numeric;
wn_tipcam  numeric;    -- cry_dec022
wn_keynom  numeric(5); --
ws_condic  varchar(10); --
ws_nomi    numeric(5); --
ws_nomexc  varchar(10); --
wn_numemi  numeric(10);  --
ws_keyapr  varchar(6);  --
wn_keypro  numeric(5); --
ws_nomemp  varchar(150); -- cry_chr001
ws_desapr  varchar(40); -- cry_chr003
ws_destip  varchar(40); -- cry_chr004
ws_desdep  varchar(40); -- cry_chr005
ws_descon  varchar(40); -- cry_chr006
ws_keydep  varchar(16); -- cry_chr012
ws_regrfc  varchar(13); -- cry_chr013
ws_keycon  varchar(3);  -- cry_chr017
ws_keyconcep varchar(3);
ws_codimp  varchar(2);  -- cry_chr018
wd_fecpag  timestamp(0);     -- cry_dat001
wd_fectrab timestamp(0);     -- cry_dat002
wd_fecini  timestamp(0);     -- cry_dat003
wd_fecfin  timestamp(0);     -- cry_dat004
ws_sitfis  varchar(8);  -- cry_chr019
ws_estcta  varchar(8);  -- cry_chr020
ws_stscon  varchar(3);  -- cry_chr021
wn_keyagr  numeric(10);  -- numero de agrupacion
wn_regded  numeric(10);  -- numero del secuencial para deduccion
wn_defrec  numeric(5); -- cry_dec023 define si es recibo o liquidacion para derechos de autor
wn_tip112  numeric(5); --            define si es recibo o liquidacisn para derechos de autor
lsdescon   varchar(40);  -- descripcion de concepto para validar por opcis
vs_fecpag  varchar(10);     -- variable que contiene la fecha de pago tecleada por el usuario
wn_keysec  numeric(10);  -- cry_dec025
wn_emision numeric(10);
wi_bandera numeric(5); -- bandera para saber si se encontro concepto de netos en la tabla glcopams.pam_keypar = 'NET'
numreci_e  numeric(10);
vd_fecpago timestamp(0);
vn_ejerci  numeric(5);
wn_keycon  varchar(3);
wn_keypue numeric(10);
ws_keyper varchar(7);
wi_primeravez numeric(5);
we_ant_keyper varchar(7);
we_ant_keyemp numeric(10);
we_ant_keypue numeric(10);
we_ant_keycon varchar(3);
rec record;
rec2 record;
rec3 record;
rec4 record;
begin
-- -> limpia la tabla glwkcrys para este reporte
delete from usrsiho.glwkcrys
where cry_nomrep = ws_nomrep
and cry_idepcc = ws_idepcc
and cry_keyusu = wn_keyusu;
-- -> obtenemos la fecha de pago tecleada por el usuario
begin
select ran_keycen
into strict vs_fecpag
from usrsiho.glwkrang
where ran_nomrep = ws_nomrep
and ran_idepcc = ws_idepcc
and ran_keyusu = wn_keyusu
and ran_keycon = 'FEC';
exception when no_data_found then vs_fecpag:= null;
end;
wn_numsec := 0;
vd_fecpago := to_timestamp(vs_fecpag,'MM/DD/YYYY');
vn_ejerci := extract(year from vd_fecpago);
------------------jdcm modificacion para disminuir tiempo de respuesta 12/ago/2008------------------------
--inserta en tablas temporales
insert into usrsiho.paso values ('sp_hpgimprenew_3',ws_nomrep,ws_idepcc,wn_keyusu,'--','Insertando en Temporal periodos');
--busca periodos
insert into usrsiho.periodos
select distinct per_keyper
from usrsiho.nmloperi
where per_keypro in (select ran_keycen
from usrsiho.glwkrang
where ran_nomrep = ws_nomrep
and ran_idepcc = ws_idepcc
and ran_keyusu = wn_keyusu
and ran_keycon = 'PRO')
and per_nu3aux in (select ran_keycen
from usrsiho.glwkrang
where ran_nomrep = ws_nomrep
and ran_idepcc = ws_idepcc
and ran_keyusu = wn_keyusu
and ran_keycon = 'ARE')
and per_keynom in (select ran_keycen
from usrsiho.glwkrang
where ran_nomrep = ws_nomrep
and ran_idepcc = ws_idepcc
and ran_keyusu = wn_keyusu
and ran_keycon = 'NOM')
and per_fecpag = vd_fecpago
--      and per_fecpag = (select to_timestamp(ran_keycen,'MM/DD/YYYY')
--                         from glwkrang
--                       where ran_nomrep = ws_nomrep
--                          and ran_idepcc = ws_idepcc
--                          and ran_keyusu = wn_keyusu
--                          and ran_keycon = 'FEC')
;
--busca emisiones
insert into usrsiho.paso values ('sp_hpgimprenew_3',ws_nomrep,ws_idepcc,wn_keyusu,'--','Insertando en Temporal emisiones');
insert into usrsiho.emisiones
select distinct per_nu4aux
from usrsiho.nmloperi
where per_keypro in (select ran_keycen
from glwkrang
where ran_nomrep = ws_nomrep
and ran_idepcc = ws_idepcc
and ran_keyusu = wn_keyusu
and ran_keycon = 'PRO')
and per_nu3aux in (select ran_keycen
from glwkrang
where ran_nomrep = ws_nomrep
and ran_idepcc = ws_idepcc
and ran_keyusu = wn_keyusu
and ran_keycon = 'ARE')
and per_keynom in (select ran_keycen
from glwkrang
where ran_nomrep = ws_nomrep
and ran_idepcc = ws_idepcc
and ran_keyusu = wn_keyusu
and ran_keycon = 'NOM')
and per_fecpag = (select to_timestamp(ran_keycen,'MM/DD/YYYY')
from glwkrang
where ran_nomrep = ws_nomrep
and ran_idepcc = ws_idepcc
and ran_keyusu = wn_keyusu
and ran_keycon = 'FEC')
;
-- busca historicos
insert into usrsiho.paso values ('sp_hpgimprenew_3',ws_nomrep,ws_idepcc,wn_keyusu,'--','Insertando en Temporal nmlohism_tmp');
insert into usrsiho.nmlohism_tmp
select *
from usrsiho.nmlohism
where his_keypro in (select ran_keycen
from usrsiho.glwkrang
where ran_nomrep = ws_nomrep
and ran_idepcc = ws_idepcc
and ran_keyusu = wn_keyusu
and ran_keycon = 'PRO')
and his_keynom in (select ran_keycen
from usrsiho.glwkrang
where ran_nomrep = ws_nomrep
and ran_idepcc = ws_idepcc
and ran_keyusu = wn_keyusu
and ran_keycon = 'NOM')
and his_keyper in (select per_keyper from periodos);
/* update statistics medium for table nmlohism_tmp; */
--busca recibos
insert into usrsiho.paso values ('sp_hpgimprenew_3',ws_nomrep,ws_idepcc,wn_keyusu,'--','Insertando en Temporal holoreci_tmp');
insert into usrsiho.holoreci_tmp
select *
from usrsiho.holoreci
where rec_ejerci = vn_ejerci
and rec_keypro in (select ran_keycen
from usrsiho.glwkrang
where ran_nomrep = ws_nomrep
and ran_idepcc = ws_idepcc
and ran_keyusu = wn_keyusu
and ran_keycon = 'PRO')
and rec_keyapr in (select ran_keycen
from usrsiho.glwkrang
where ran_nomrep = ws_nomrep
and ran_idepcc = ws_idepcc
and ran_keyusu = wn_keyusu
and ran_keycon = 'ARE')
and rec_keynom in (select ran_keycen
from usrsiho.glwkrang
where ran_nomrep = ws_nomrep
and ran_idepcc = ws_idepcc
and ran_keyusu = wn_keyusu
and ran_keycon = 'NOM')
and rec_numemi in (select per_nu4aux from usrsiho.emisiones)
and rec_fecpag = vd_fecpago;
--      and rec_fecpag = (select ran_keycen
--                         from glwkrang
--                        where ran_nomrep = ws_nomrep
--                          and ran_idepcc = ws_idepcc
--                          and ran_keyusu = wn_keyusu
--                          and ran_keycon = 'FEC');
/* update statistics medium for table holoreci_tmp; */
--busca rphs
insert into usrsiho.paso values ('sp_hpgimprenew_3',ws_nomrep,ws_idepcc,wn_keyusu,'--','Insertando en Temporal holofrph_tmp');
insert into usrsiho.holofrph_tmp
select *
from usrsiho.holofrph
where frp_keypro in (select ran_keycen
from usrsiho.glwkrang
where ran_nomrep = ws_nomrep
and ran_idepcc = ws_idepcc
and ran_keyusu = wn_keyusu
and ran_keycon = 'PRO')
and frp_keyper in (select per_keyper from usrsiho.periodos)
and frp_keynom in (select ran_keycen
from usrsiho.glwkrang
where ran_nomrep = ws_nomrep
and ran_idepcc = ws_idepcc
and ran_keyusu = wn_keyusu
and ran_keycon = 'NOM');
/* update statistics medium for table holofrph_tmp; */
--busca historico de rphs
insert into usrsiho.paso values ('sp_hpgimprenew_3',ws_nomrep,ws_idepcc,wn_keyusu,'--','Insertando en Temporal holohgdp_tmp');
insert into usrsiho.holohgdp_tmp
select *
from usrsiho.holohgdp
where hgd_keyrph in (select frp_keyrph
from usrsiho.holofrph
where frp_keypro in (select ran_keycen
from usrsiho.glwkrang
where ran_nomrep = ws_nomrep
and ran_idepcc = ws_idepcc
and ran_keyusu = wn_keyusu
and ran_keycon = 'PRO')
and frp_keyper in (select per_keyper from usrsiho.periodos)
and frp_keynom in (select ran_keycen
from usrsiho.glwkrang
where ran_nomrep = ws_nomrep
and ran_idepcc = ws_idepcc
and ran_keyusu = wn_keyusu
and ran_keycon = 'NOM'));
/* update statistics medium for table holohgdp_tmp; */
/* update statistics medium for table glwkrang; */
insert into paso values ('sp_hpgimprenew_3',ws_nomrep,ws_idepcc,wn_keyusu,'--','Insertando en Tabla glwkcrys');
---------------************************************-------------------------
-- -> lectura de todos los procesos y areas (1er foreach)
for rec in (select distinct per_keypro,per_nu3aux,per_nu4aux
from usrsiho.nmloperi, usrsiho.glwkrang
where per_fecpag = vd_fecpago
and ( (wn_lenpro > 0 and per_keypro  in (select ran_keycen
from usrsiho.glwkrang
where ran_nomrep = ws_nomrep
and ran_idepcc = ws_idepcc
and ran_keyusu = wn_keyusu
and ran_keycon = 'PRO') ) or
wn_lenpro = 0 )
and per_nu3aux = ran_keycen
and ran_nomrep = ws_nomrep
and ran_idepcc = ws_idepcc
and ran_keyusu = wn_keyusu
and ran_keycon = 'ARE'
and ( (wn_lenemi > 0 and per_nu4aux  in (select ran_keycen
from usrsiho.glwkrang
where ran_nomrep = ws_nomrep
and ran_idepcc = ws_idepcc
and ran_keyusu = wn_keyusu
and ran_keycon = 'EMI') ) or
wn_lenemi = 0 )) loop
-- -> lectura de todos los recibos de ese procesos, area y emision (2o. foreach)
wn_keypro := rec.per_keypro;
ws_keyapr := trim(both rec.per_nu3aux);
wn_emision := trim(both rec.per_nu4aux);
for rec2 in (select distinct rec_keyrec
from usrsiho.holoreci_tmp
left join usrsiho.glwkrang a on rec_keynom = a.ran_keycen and a.ran_nomrep = ws_nomrep and a.ran_idepcc = ws_idepcc
and a.ran_keyusu = wn_keyusu and a.ran_keycon = 'NOM'
left join usrsiho.glwkrang b on rec_keyemp = b.ran_keycen and b.ran_nomrep = ws_nomrep and b.ran_idepcc = ws_idepcc
and b.ran_keyusu = wn_keyusu and b.ran_keycon = 'EMP'
where rec_ejerci = vn_ejerci
and rec_keypro = wn_keypro
and rec_keyapr = ws_keyapr
and rec_numemi = wn_emision
and rec_fecpag = vd_fecpago
--and rec_ejerci = extract(year from rec_fecpag)
) loop
--                and ( (wn_lennom > 0 and rec_keynom in (select ran_keycen
--                                                          from glwkrang
--                                                         where ran_nomrep = ws_nomrep
--                                                           and ran_idepcc = ws_idepcc
--                                                          and ran_keyusu = wn_keyusu
--                                                           and ran_keycon = 'NOM') ) or
--                       wn_lennom = 0 )
--                and ( (wn_lstemp > 0 and rec_keyemp in (select ran_keycen
--                                                          from glwkrang
--                                                         where ran_nomrep = ws_nomrep
--                                                           and ran_idepcc = ws_idepcc
--                                                           and ran_keyusu = wn_keyusu
--                                                           and ran_keycon = 'EMP') ) or
--                       wn_lstemp = 0 )) loop
-- -> lectura de los datos del header (3er. foreach)
-- se modifica agrupacion para desglosar los descuentos de sitatyr.
-- se agrega el campo his_rowide en el select y el group by
-- marzo 2010
numreci_e := rec2.rec_keyrec;
for rec3 in (select
rec_keyrec,emp_keyemp,emp_nomemp,emp_regrfc,pam_nompar,nom_destip,
min(per_keyper) perini,max(per_keyper) perfin,
min(per_fecini) fecini,max(per_fecfin) fecfin,per_fecpag,
his_codimp,con_keycon,con_descon,sum(his_import) tot_importe,agc_keyagr,per_nu1aux,emp_ca2aux,
emp_cveban,case when rec_stscon=1 then ' '  else '*' end  stscon,rec_keynom,rec_numemi,his_rowide
from usrsiho.holoreci_tmp
join usrsiho.nmcoempl on rec_keyemp = emp_keyemp
join usrsiho.nmlonomi on rec_keynom = nom_keynom
join usrsiho.nmloperi on rec_keypro = per_keypro and rec_keyapr = per_nu3aux and rec_keynom = per_keynom and rec_numemi = per_nu4aux
join usrsiho.glcopams on pam_keypar = 'H2'
and pam_cvesec = rec_keyapr
join usrsiho.nmloconc on con_keycon not in ('H08','H09','28D')
join usrsiho.nmlohism_tmp on his_keypro = per_keypro and his_keyper = per_keyper and his_keycon = con_keycon
and his_keyemp = rec_keyemp and his_codimp in ('01','02')
left join usrsiho.holoagcp on agc_keyagr = 18 and agc_keycon = con_keycon
where rec_ejerci = vn_ejerci
and rec_keypro = wn_keypro
and rec_keyrec = numreci_e
and rec_keyapr = ws_keyapr
and rec_numemi = wn_emision
and rec_fecpag = vd_fecpago
and rec_ejerci = extract(year from rec_fecpag)
-- (5/5) empleado(s)
and ( (wn_lstemp > 0 and his_keyemp in (select ran_keycen
from usrsiho.glwkrang
where ran_nomrep = ws_nomrep
and ran_idepcc = ws_idepcc
and ran_keyusu = wn_keyusu
and ran_keycon = 'EMP') ) or
wn_lstemp = 0 )
-- (4/5) nomina(s)
and ( (wn_lennom > 0 and rec_keynom in (select ran_keycen
from usrsiho.glwkrang
where ran_nomrep = ws_nomrep
and ran_idepcc = ws_idepcc
and ran_keyusu = wn_keyusu
and ran_keycon = 'NOM') ) or
wn_lennom = 0 )
group by rec_keyrec,emp_keyemp,emp_nomemp,emp_regrfc,pam_nompar,nom_keynom,
nom_destip,rec_numemi,per_fecpag,his_codimp,con_keycon,con_descon,
agc_keyagr,per_nu1aux,emp_ca2aux,emp_cveban,rec_import,rec_stscon,
rec_keynom,rec_numemi,his_rowide
-- se agrega his_rowide en el group para los conceptos de sitatyr
-- marzo 2010
union
select
rec_keyrec,emp_keyemp,emp_nomemp,emp_regrfc,pam_nompar,nom_destip,
min(per_keyper) perini,max(per_keyper) perfin,
min(per_fecini) fecini,max(per_fecfin) fecfin,per_fecpag,
his_codimp,'H08','VIATICOS' con_keycon,sum(his_import) tot_importe,agc_keyagr,per_nu1aux,
emp_ca2aux,emp_cveban,case when rec_stscon=1 then ' '  else '*' end  stscon,rec_keynom,rec_numemi,his_rowide
from usrsiho.holoreci_tmp
join usrsiho.nmcoempl on rec_keyemp = emp_keyemp
join usrsiho.nmlonomi on rec_keynom = nom_keynom
join usrsiho.nmloperi on rec_keypro = per_keypro and rec_keyapr = per_nu3aux and rec_keynom = per_keynom
and rec_numemi = per_nu4aux
join usrsiho.glcopams on pam_keypar = 'H2'
and pam_cvesec = rec_keyapr
join usrsiho.nmloconc on  con_keycon in ('H08','H09')
join usrsiho.nmlohism_tmp on his_keypro = per_keypro and his_keyper = per_keyper and his_keycon = con_keycon
and his_keyemp = rec_keyemp and his_codimp in ('01','02')
left join usrsiho.holoagcp on agc_keycon = con_keycon and agc_keyagr = 18
where rec_ejerci = vn_ejerci
and rec_keypro = wn_keypro
and rec_keyrec = numreci_e
and rec_keyapr = ws_keyapr
and rec_numemi = wn_emision
and rec_fecpag = vd_fecpago
and rec_ejerci = extract(year from rec_fecpag)
-- (5/5) empleado(s)
and ( (wn_lstemp > 0 and his_keyemp in (select ran_keycen
from usrsiho.glwkrang
where ran_nomrep = ws_nomrep
and ran_idepcc = ws_idepcc
and ran_keyusu = wn_keyusu
and ran_keycon = 'EMP') ) or
wn_lstemp = 0 )
-- (4/5) nomina(s)
and ( (wn_lennom > 0 and rec_keynom in (select ran_keycen
from usrsiho.glwkrang
where ran_nomrep = ws_nomrep
and ran_idepcc = ws_idepcc
and ran_keyusu = wn_keyusu
and ran_keycon = 'NOM') ) or
wn_lennom = 0 )
group by rec_keyrec,emp_keyemp,emp_nomemp,emp_regrfc,pam_nompar,nom_keynom,
nom_destip,rec_numemi,per_fecpag,his_codimp,agc_keyagr,per_nu1aux,
emp_ca2aux,emp_cveban,rec_import,rec_stscon,rec_keynom,rec_numemi,his_rowide
order by  12,16) loop -- ordenado: his_codimp,agc_keyagr
-- se agrega his_rowide en el group para los conceptos de sitatyr
-- marzo 2010
-- -> verifico que no exista descripcion opcional por opcis
wn_numrec := rec3.rec_keyrec;
wn_keyemp := rec3.emp_keyemp;
ws_nomemp := rec3.emp_nomemp;
ws_regrfc := rec3.emp_regrfc;
ws_desapr := rec3.pam_nompar;
ws_destip := rec3.nom_destip;
wn_perini := rec3.perini;
wn_perfin := rec3.perfin;
wd_fecini := rec3.fecini;
wd_fecfin := rec3.fecfin;
wd_fecpag := rec3.per_fecpag;
ws_codimp := rec3.his_codimp;
ws_keycon := rec3.con_keycon;
ws_descon := rec3.con_descon;
wn_costot := rec3.tot_importe;
wn_keyagr := rec3.agc_keyagr;
wn_tipcam := rec3.per_nu1aux;
ws_sitfis := rec3.emp_ca2aux;
ws_estcta := rec3.emp_cveban;
ws_stscon := rec3.stscon;
wn_keynom := rec3.rec_keynom;
wn_numemi := rec3.rec_numemi;
wn_rowide := rec3.his_rowide;
begin
select pam_nompar
into strict lsdescon
from usrsiho.glcopams
where pam_keypar=(select t1.pam_folini
from usrsiho.glcopams t1
where t1.pam_cvesec='gimpre')
and pam_folini = ws_keycon
and pam_folfin = wn_keypro;
exception
when no_data_found then
lsdescon := null;
end;
if nullif(lsdescon::text, '') is not null then
ws_descon:=trim(both lsdescon);
end if;
-- -> por cada recibo hacer el desglose
if wn_keyagr = 18 then   -- -> desglose para la agrupacion 18
wn_defrec := 0;
-- -> checamos en la tabla 'NET' si existe el concepto original para saber si se procesan conceptos netos ( futbol)
ws_keyconcep:= null;
wi_bandera := 0;
begin
select pam_nompar
into strict ws_keyconcep
from usrsiho.glcopams
where pam_keypar = 'NET'
and pam_cvesec = ws_keycon;
exception
when no_data_found then
ws_keyconcep:= null;
end;
if nullif(ws_keyconcep::text, '') is not null then
wn_costot1 := wn_costot;
ws_keycon := trim(both ws_keyconcep);
wi_bandera := 1;
end if;
if wi_bandera = 1 then    -- se procesan conceptos netos ( futbol)
wi_primeravez := 1;
we_ant_keyper:= null;
we_ant_keyemp := 0;
we_ant_keypue := 0;
we_ant_keycon:= null;
end if;
for rec4 in (select hgd_numcap,trim(both frp_keydep)||' '||case when coalesce(con_stsfir,' ')='N' then '*'  else ' ' end  valor2,
dep_desdep,frp_keyrph,hgd_keysec,frp_fectrab,
hgd_costog,hgd_capini,hgd_capfin,hgd_numcap*hgd_costog costot,
con_descon,hgd_keypue,frp_keyper
from usrsiho.holohgdp_tmp
join usrsiho.holofrph_tmp on frp_keyrph = hgd_keyrph and frp_keypro = wn_keypro and frp_keynom = wn_keynom
and frp_keyper between wn_perini and wn_perfin
join usrsiho.nmcodeps on frp_keydep = dep_keydep
join usrsiho.nmloconc on hgd_keycon = con_keycon
left join usrsiho.holocont on  hgd_keytco = con_keytco and hgd_keyfol = con_keyfol
where hgd_keyemp = wn_keyemp
and hgd_keycon = ws_keycon
) loop
-- -----------------------------------
wn_numcap := rec4.hgd_numcap;
ws_keydep := rec4.valor2;
ws_desdep := rec4.dep_desdep;
wn_keyrph := rec4.frp_keyrph;
wn_keysec := rec4.hgd_keysec;
wd_fectrab := rec4.frp_fectrab;
wn_cosuni := rec4.hgd_costog;
wn_capini := rec4.hgd_capini;
wn_capfin := rec4.hgd_capfin;
wn_costot := rec4.costot;
ws_descon := rec4.con_descon;
wn_keypue := rec4.hgd_keypue;
ws_keyper := rec4.frp_keyper;
if wi_bandera = 1 then    -- se procesan conceptos netos ( futbol)
if wi_primeravez = 1 then
we_ant_keyper := ws_keyper;
we_ant_keyemp := wn_keyemp;
we_ant_keypue := wn_keypue;
we_ant_keycon := ws_keycon;
end if;
if wi_primeravez > 1 then
if we_ant_keyper = ws_keyper and we_ant_keyemp = wn_keyemp and we_ant_keypue = wn_keypue and we_ant_keycon = ws_keycon then
wn_costot := 0;
wn_costot1 := 0;
end if;
we_ant_keyper := ws_keyper;
we_ant_keyemp := wn_keyemp;
we_ant_keypue := wn_keypue;
we_ant_keycon := ws_keycon;
end if;
end if;
-- ----------------------------------------------------------
-- -> verifico que no exista descripcion opcional por opcis
begin
select pam_nompar
into strict lsdescon
from usrsiho.glcopams
where pam_keypar=(select t1.pam_folini
from usrsiho.glcopams t1
where t1.pam_cvesec='gimpre')
and pam_folini = ws_keycon
and pam_folfin = wn_keypro;
exception
when no_data_found then
lsdescon := null;
end;
if nullif(lsdescon::text, '') is not null then
ws_descon:=trim(both lsdescon);
end if;
-----------------------------------------------------------------------------
if wi_bandera = 1 then
wn_costot := wn_costot1;
end if;
-- -> inserccion de registros
wn_numsec := wn_numsec + 1;
insert into usrsiho.glwkcrys(cry_nomrep,cry_idepcc,cry_keyusu,
cry_numsec,cry_dec007,cry_dec008,cry_dec009,cry_dat003,cry_dat004,cry_dec010,
cry_dec011,cry_dec012,cry_dec013,cry_dec014,cry_dec015,cry_dec016,cry_dec017,
cry_dec018,cry_dec019,cry_chr001,cry_chr003,cry_chr004,cry_chr005,cry_chr012,
cry_chr013,cry_chr017,cry_chr018,cry_dat001,cry_dat002,cry_chr006,cry_dec021,
cry_dec022,cry_dec020,cry_chr007,cry_chr019,cry_dec023,cry_chr020,cry_chr021,cry_dec025)
values (ws_nomrep,ws_idepcc,wn_keyusu,
wn_numsec,wn_numemi,wn_perini,wn_perfin,wd_fecini,wd_fecfin,wn_numrec,
wn_keyemp,wn_numcap,wn_keyrph,wn_capini,wn_capfin,wn_keynom,wn_keypro,
wn_cosuni,wn_costot,ws_nomemp,ws_desapr,ws_destip,ws_desdep,ws_keydep,
ws_regrfc,ws_keycon,ws_codimp,wd_fecpag,wd_fectrab,ws_descon,1        ,
wn_tipcam,null     ,null     ,ws_sitfis,wn_defrec ,ws_estcta,ws_stscon,wn_keysec);
if wi_bandera = 1 then    -- se procesan conceptos netos ( futbol)
wi_primeravez := wi_primeravez + 1;
end if;
end loop;
else   -- -> diferente a agrupacion 18
if ws_keycon = 'H08' or ws_keycon = 'H09' then -- -> viaticos
--inserccion de registros
wn_numsec:=wn_numsec + 1;
insert into usrsiho.glwkcrys(cry_nomrep,cry_idepcc,cry_keyusu,
cry_numsec,cry_dec007,cry_dec008,cry_dec009,cry_dat003,cry_dat004,cry_dec010,
cry_dec011,cry_dec012,cry_dec013,cry_dec014,cry_dec015,cry_dec016,cry_dec017,
cry_dec018,cry_dec019,cry_chr001,cry_chr003,cry_chr004,cry_chr007,cry_chr012,
cry_chr013,cry_chr017,cry_chr018,cry_dat001,cry_dat002,cry_chr005,cry_dec021,
cry_dec022,cry_dec020,cry_chr019,cry_chr020,cry_chr021)
values (ws_nomrep,ws_idepcc,wn_keyusu,
wn_numsec,wn_numemi,wn_perini,wn_perfin,wd_fecini,wd_fecfin,wn_numrec,
wn_keyemp,null     ,null     ,null     ,null     ,wn_keynom,wn_keypro,
null     ,wn_costot,ws_nomemp,ws_desapr,ws_destip,null     ,null     ,
ws_regrfc,'H08'    ,'01'     ,wd_fecpag,null     ,'VIATICOS',3       ,
wn_tipcam,null     ,ws_sitfis,ws_estcta,ws_stscon);
elsif ws_keycon = 'H04' then --repeticion
-- -> inserccion de registros
wn_numsec:=wn_numsec + 1;
insert into usrsiho.glwkcrys(cry_nomrep,cry_idepcc,cry_keyusu,
cry_numsec,cry_dec007,cry_dec008,cry_dec009,cry_dat003,cry_dat004,cry_dec010,
cry_dec011,cry_dec012,cry_dec013,cry_dec014,cry_dec015,cry_dec016,cry_dec017,
cry_dec018,cry_dec019,cry_chr001,cry_chr003,cry_chr004,cry_chr005,cry_chr012,
cry_chr013,cry_chr017,cry_chr018,cry_dat001,cry_dat002,cry_chr006,cry_dec021,
cry_dec022,cry_dec020,cry_chr007,cry_chr019,cry_chr020,cry_chr021)
values (ws_nomrep,ws_idepcc,wn_keyusu,
wn_numsec,wn_numemi,wn_perini,wn_perfin,wd_fecini,wd_fecfin,wn_numrec,
wn_keyemp,null     ,null     ,null     ,null     ,wn_keynom,wn_keypro,
null     ,wn_costot,ws_nomemp,ws_desapr,ws_destip,null     ,null     ,
ws_regrfc,ws_keycon,ws_codimp,wd_fecpag,null     ,null     ,2        ,
wn_tipcam,null     ,null,ws_sitfis,ws_estcta,ws_stscon);
else -- el resto
-- puede ser percepcion o deduccion
-- en caso de ser una persepcion se realiza una nueva inserccion
if ws_codimp='01' then
wn_numsec:=wn_numsec + 1;
insert into usrsiho.glwkcrys(cry_nomrep,cry_idepcc,cry_keyusu,
cry_numsec,cry_dec007,cry_dec008,cry_dec009,cry_dat003,cry_dat004,cry_dec010,
cry_dec011,cry_dec012,cry_dec013,cry_dec014,cry_dec015,cry_dec016,cry_dec017,
cry_dec018,cry_dec019,cry_chr001,cry_chr003,cry_chr004,cry_chr005,cry_chr012,
cry_chr013,cry_chr017,cry_chr018,cry_dat001,cry_dat002,cry_chr006,
cry_dec020,cry_chr007,cry_dec021,cry_dec022,cry_chr019,cry_chr020,cry_chr021)
values (ws_nomrep,ws_idepcc,wn_keyusu,
wn_numsec,wn_numemi,wn_perini,wn_perfin,wd_fecini,wd_fecfin,wn_numrec,
wn_keyemp,null     ,null     ,null     ,null     ,wn_keynom,wn_keypro,
null     ,wn_costot,ws_nomemp,ws_desapr,ws_destip,ws_descon,null     ,
ws_regrfc,ws_keycon,ws_codimp,wd_fecpag,null     ,null     ,
null     ,null     ,4        ,wn_tipcam,ws_sitfis,ws_estcta,ws_stscon);
else --en caso de ser deduccion se hace una actualizacion o una inserccion
-- -> busqueda del registro para actualizar
begin
select coalesce(min(cry_numsec),0)
into strict wn_regded
from usrsiho.glwkcrys
where cry_nomrep = ws_nomrep
and cry_idepcc = ws_idepcc
and cry_keyusu = wn_keyusu
and cry_dec010 = wn_numrec
and cry_dec017 = wn_keypro
and nullif(cry_dec020::text, '') is null
and nullif(cry_chr007::text, '') is null;
exception when no_data_found then wn_regded := 0;
end;
-- -> si encontro el registro => se realiza la actualizacion
if wn_regded > 0 then
update usrsiho.glwkcrys
set cry_dec020 = wn_costot,
cry_chr007 = ws_descon
where cry_nomrep = ws_nomrep
and cry_idepcc = ws_idepcc
and cry_keyusu = wn_keyusu
and cry_numsec = wn_regded;
else
wn_numsec:=wn_numsec + 1;
insert into usrsiho.glwkcrys(cry_nomrep,cry_idepcc,cry_keyusu,
cry_numsec,cry_dec007,cry_dec008,cry_dec009,cry_dat003,cry_dat004,cry_dec010,
cry_dec011,cry_dec012,cry_dec013,cry_dec014,cry_dec015,cry_dec016,cry_dec017,
cry_dec018,cry_dec019,cry_chr001,cry_chr003,cry_chr004,cry_chr005,cry_chr012,
cry_chr013,cry_chr017,cry_chr018,cry_dat001,cry_dat002,cry_chr006,
cry_dec020,cry_chr007,cry_dec021,cry_dec022,cry_chr019,cry_chr020,cry_chr021)
values (ws_nomrep,ws_idepcc,wn_keyusu,
wn_numsec,wn_numemi,wn_perini,wn_perfin,wd_fecini,wd_fecfin,wn_numrec,
wn_keyemp,null     ,null     ,null     ,null     ,wn_keynom,wn_keypro,
null     ,null     ,ws_nomemp,ws_desapr,ws_destip,null     ,null     ,
ws_regrfc,ws_keycon,ws_codimp,wd_fecpag,null     ,null    ,
wn_costot,ws_descon,5        ,wn_tipcam,ws_sitfis,ws_estcta,ws_stscon);
end if;
end if;
end if;
end if;
end loop;
end loop;
end loop;
--actualiza indices
/* update statistics medium for table glwkcrys; */
-- -> elimina rangos
-- delete
--   from glwkrang
--  where ran_idepcc = ws_idepcc
--    and ran_keyusu = wn_keyusu
--    and ran_nomrep = ws_nomrep;
--dropea tablas temporales  jdcm
--delete from periodos;
--delete from emisiones;
--delete from nmlohism_tmp;
--delete from holoreci_tmp;
--delete from holofrph_tmp;
--delete from holohgdp_tmp;
--
end;
$body$
language plpgsql
;
