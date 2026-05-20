create or replace procedure usrsiho."sp_hpgimprenew_2"  (ws_nomrep varchar, ws_idepcc varchar, wn_keyusu numeric, wn_lenpro numeric, wn_lennom numeric, wn_lstemp numeric, wn_lenemi numeric, ws_tporec varchar ) as $body$
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
wn_costot1 numeric;
wn_tipcam  numeric;    -- cry_dec022
wn_keynom  numeric(5); --
ws_condic  varchar(10); --
ws_nomi    smallint; --
ws_nomexc  varchar(10); --
wn_numemi  numeric(10);  --
ws_keyapr  varchar(6);  --
wn_keypro  numeric(5); --
ws_nomemp  varchar(60); -- cry_chr001
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
wi_bandera numeric(5); -- bandera para saber si se encontro concepto de netos en la tabla glcopams.pam_keypar = "net"
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
rec_01 record;
rec_02 record;
rec_03 record;
rec_04 record;
begin
-- -> limpia la tabla glwkcrys para este reporte
delete from glwkcrys
where cry_nomrep = ws_nomrep
and cry_idepcc = ws_idepcc
and cry_keyusu = wn_keyusu;
-- -> obtenemos la fecha de pago tecleada por el usuario
begin
select ran_keycen
into strict vs_fecpag
from glwkrang
where ran_nomrep = ws_nomrep
and ran_idepcc = ws_idepcc
and ran_keyusu = wn_keyusu
and ran_keycon = 'FEC';
exception when no_data_found then vs_fecpag:= null;
end;
wn_numsec := 0;
vd_fecpago := to_timestamp(vs_fecpag,'MM/DD/YYYY');
vn_ejerci := extract(year from vd_fecpago);
-- -> lectura de todos los procesos y areas (1er foreach)
--foreach
for rec_01 in (
select distinct per_keypro, per_nu3aux, per_nu4aux
-- into wn_keypro,ws_keyapr,wn_emision
from nmloperi, glwkrang
where per_fecpag = vs_fecpag
and ( (wn_lenpro > 0
and per_keypro  in (select ran_keycen
from glwkrang
where ran_nomrep = ws_nomrep
and ran_idepcc = ws_idepcc
and ran_keyusu = wn_keyusu
and ran_keycon = 'PRO') ) or wn_lenpro = 0 )
and per_nu3aux = ran_keycen
and ran_nomrep = ws_nomrep
and ran_idepcc = ws_idepcc
and ran_keyusu = wn_keyusu
and ran_keycon = 'ARE'
and ( (wn_lenemi > 0 and per_nu4aux  in (select ran_keycen
from glwkrang
where ran_nomrep = ws_nomrep
and ran_idepcc = ws_idepcc
and ran_keyusu = wn_keyusu
and ran_keycon = 'EMI') ) or wn_lenemi = 0 )) loop
wn_keypro := rec_01.per_keypro;
ws_keyapr := rec_01.per_nu3aux;
wn_emision := rec_01.per_nu4aux;
-- -> lectura de todos los recibos de ese procesos, area y emision (2o. foreach)
-- foreach
for rec_02 in (
select distinct rec_keyrec
-- into numreci_e
from holoreci
where rec_ejerci = vn_ejerci
and rec_keypro = wn_keypro
and rec_keyapr = ws_keyapr
and rec_numemi = wn_emision
and rec_fecpag = vs_fecpag
and rec_ejerci = year(rec_fecpag)
and ( (wn_lennom > 0 and rec_keynom in (select ran_keycen
from glwkrang
where ran_nomrep = ws_nomrep
and ran_idepcc = ws_idepcc
and ran_keyusu = wn_keyusu
and ran_keycon = 'NOM') ) or wn_lennom = 0 )
and ( (wn_lstemp > 0 and rec_keyemp in (select ran_keycen
from glwkrang
where ran_nomrep = ws_nomrep
and ran_idepcc = ws_idepcc
and ran_keyusu = wn_keyusu
and ran_keycon = 'EMP') ) or wn_lstemp = 0 ) ) loop
numreci_e := rec_02.rec_keyrec;
-- -> lectura de los datos del header (3er. foreach)
-- foreach
for rec_03 in ( select rec_keyrec, emp_keyemp, emp_nomemp, emp_regrfc, pam_nompar, nom_destip,
min( (per_keyper)::numeric ) perini, max((per_keyper)::numeric ) perfin,
min(per_fecini) fecini, max(per_fecfin) fecfin,per_fecpag,
his_codimp,con_keycon,con_descon,sum(his_import) importe ,agc_keyagr,per_nu1aux,emp_ca2aux,
emp_cveban,case when rec_stscon=1 then ' '  else '*' end  stscon ,rec_keynom,rec_numemi
-- into wn_numrec,wn_keyemp,ws_nomemp,ws_regrfc,ws_desapr,ws_destip,wn_perini,wn_perfin,wd_fecini,
--      wd_fecfin,wd_fecpag,ws_codimp,ws_keycon,ws_descon,wn_costot,wn_keyagr,wn_tipcam,ws_sitfis,
--      ws_estcta,ws_stscon,wn_keynom,wn_numemi
from holoreci, nmcoempl, nmlonomi, nmloperi, glcopams, nmlohism,
nmloconc left outer join holoagcp on agc_keycon = con_keycon and agc_keyagr = 18
where rec_ejerci = vn_ejerci
and rec_keypro = wn_keypro
and rec_keyrec = numreci_e
and rec_keyapr = ws_keyapr
and rec_numemi = wn_emision
and rec_fecpag = vs_fecpag
and rec_ejerci = year(rec_fecpag)
and rec_keyemp = emp_keyemp
and rec_keynom = nom_keynom
and rec_keypro = per_keypro
and rec_keynom = per_keynom
and rec_keyapr = per_nu3aux
and rec_numemi = per_nu4aux
and pam_cvesec = rec_keyapr
and per_keypro = his_keypro
and per_keyper = his_keyper
and rec_keyemp = his_keyemp
and his_keycon = con_keycon
and his_codimp in ('01','02')
and con_keycon not in ('H08','H09','28D')
and pam_keypar = 'H2' -- areas de produccion
-- (5/5) empleado(s)
and ( (wn_lstemp > 0 and his_keyemp in (select ran_keycen
from glwkrang
where ran_nomrep = ws_nomrep
and ran_idepcc = ws_idepcc
and ran_keyusu = wn_keyusu
and ran_keycon = 'EMP') ) or wn_lstemp = 0 )
-- (4/5) nomina(s)
and ( (wn_lennom > 0 and rec_keynom in (select ran_keycen
from glwkrang
where ran_nomrep = ws_nomrep
and ran_idepcc = ws_idepcc
and ran_keyusu = wn_keyusu
and ran_keycon = 'NOM') ) or wn_lennom = 0 )
group by rec_keyrec,emp_keyemp,emp_nomemp,emp_regrfc,pam_nompar,nom_keynom,
nom_destip,rec_numemi,per_fecpag,his_codimp,con_keycon,con_descon,
agc_keyagr,per_nu1aux,emp_ca2aux,emp_cveban,rec_import,rec_stscon,rec_keynom,rec_numemi
union
select /*+ use_hash (holoreci /build) */											rec_keyrec,emp_keyemp,emp_nomemp,emp_regrfc,pam_nompar,nom_destip,
min((per_keyper)::numeric ) perini,max((per_keyper)::numeric ) perfin,
min(per_fecini) fecini,max(per_fecfin) fecfin,per_fecpag,
his_codimp,'H08','VIATICOS' con_keycon,sum(his_import),agc_keyagr,per_nu1aux,
emp_ca2aux,emp_cveban,case when rec_stscon=1 then ' '  else '*' end ,rec_keynom,rec_numemi
from holoreci,nmcoempl,nmlonomi,nmloperi,glcopams,nmlohism,
nmloconc left outer join holoagcp on agc_keycon = con_keycon and agc_keyagr = 18
where rec_ejerci = vn_ejerci
and rec_keypro = wn_keypro
and rec_keyrec = numreci_e
and rec_keyapr = ws_keyapr
and rec_numemi = wn_emision
and rec_fecpag = vs_fecpag
and rec_ejerci = year(rec_fecpag)
and rec_keyemp = emp_keyemp
and rec_keynom = nom_keynom
and rec_keypro = per_keypro
and rec_keynom = per_keynom
and rec_keyapr = per_nu3aux
and rec_numemi = per_nu4aux
and pam_cvesec = rec_keyapr
and per_keypro = his_keypro
and per_keyper = his_keyper
and rec_keyemp = his_keyemp
and his_keycon = con_keycon
and his_codimp in ('01','02')
and con_keycon in ('H08','H09')
and pam_keypar = 'H2' -- areas de produccion
-- (5/5) empleado(s)
and ( (wn_lstemp > 0 and his_keyemp in (select ran_keycen
from glwkrang
where ran_nomrep = ws_nomrep
and ran_idepcc = ws_idepcc
and ran_keyusu = wn_keyusu
and ran_keycon = 'EMP') ) or wn_lstemp = 0 )
-- (4/5) nomina(s)
and ( (wn_lennom > 0 and rec_keynom in (select ran_keycen
from glwkrang
where ran_nomrep = ws_nomrep
and ran_idepcc = ws_idepcc
and ran_keyusu = wn_keyusu
and ran_keycon = 'NOM') ) or wn_lennom = 0 )
group by rec_keyrec,emp_keyemp,emp_nomemp,emp_regrfc,pam_nompar,nom_keynom,
nom_destip,rec_numemi,per_fecpag,his_codimp,agc_keyagr,per_nu1aux,
emp_ca2aux,emp_cveban,rec_import,rec_stscon,rec_keynom,rec_numemi
order by  12,16  ) loop		-- ordenado: his_codimp,agc_keyagr
wn_numrec := rec_03.rec_keyrec;
wn_keyemp := rec_03.emp_keyemp;
ws_nomemp := rec_03.emp_nomemp;
ws_regrfc := rec_03.emp_regrfc;
ws_desapr := rec_03.pam_nompar;
ws_destip := rec_03.nom_destip;
wn_perini := rec_03.perini;
wn_perfin := rec_03.perfin;
wd_fecini := rec_03.fecini;
wd_fecfin := rec_03.fecfin;
wd_fecpag := rec_03.per_fecpag;
ws_codimp := rec_03.his_codimp;
ws_keycon := rec_03.con_keycon;
ws_descon := rec_03.con_descon;
wn_costot := rec_03.importe;
wn_keyagr := rec_03.agc_keyagr;
wn_tipcam := rec_03.per_nu1aux;
ws_sitfis := rec_03.emp_ca2aux;
ws_estcta := rec_03.emp_cveban;
ws_stscon := rec_03.stscon;
wn_keynom := rec_03.rec_keynom;
wn_numemi := rec_03.rec_numemi;
-- -> verifico que no exista descripcion opcional por opcis
begin
select pam_nompar
into strict lsdescon
from glcopams
where pam_keypar = (select t1.pam_folini
from glcopams t1
where t1.pam_cvesec='gimpre')
and pam_folini = ws_keycon
and pam_folfin = wn_keypro;
exception when no_data_found then lsdescon:= null;
end;
if nullif(lsdescon::text, '') is not null then
ws_descon := trim(both lsdescon);
end if;
-- -> por cada recibo hacer el desglose
if wn_keyagr = 18 then   -- -> desglose para la agrupacion 18
wn_defrec := 0;
-- -> checamos en la tabla "net" si existe el concepto original para saber si se procesan conceptos netos ( futbol)
ws_keyconcep:= null;
wi_bandera := 0;
begin
select pam_nompar
into strict ws_keyconcep
from glcopams
where pam_keypar = 'NET'
and pam_cvesec = ws_keycon;
exception when no_data_found then ws_keyconcep:= null;
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
-- foreach
for rec_04 in (
select hgd_numcap,
trim(both frp_keydep) || ' ' || case when coalesce(con_stsfir,' ')='N' then '*'  else ' ' end  keydep,
dep_desdep,frp_keyrph,hgd_keysec,frp_fectrab, hgd_costog,hgd_capini,hgd_capfin,
hgd_numcap*hgd_costog costot, con_descon,hgd_keypue,frp_keyper
from holofrph,nmcodeps, nmloconc,
holohgdp left outer join holocont on hgd_keytco = con_keytco and hgd_keyfol = con_keyfol
where frp_keyrph = hgd_keyrph
and frp_keydep = dep_keydep
and frp_keypro = wn_keypro
and frp_keynom = wn_keynom
and (frp_keyper)::numeric  between wn_perini and wn_perfin
and hgd_keyemp = wn_keyemp
and hgd_keycon = ws_keycon
and hgd_keycon = con_keycon) loop
wn_numcap := rec_04.hgd_numcap;
ws_keydep := rec_04.keydep;
ws_desdep := rec_04.dep_desdep;
wn_keyrph := rec_04.frp_keyrph;
wn_keysec := rec_04.hgd_keysec;
wd_fectrab := rec_04.frp_fectrab;
wn_cosuni := rec_04.hgd_costog;
wn_capini := rec_04.hgd_capini;
wn_capfin := rec_04.hgd_capfin;
wn_costot := rec_04.costot;
ws_descon := rec_04.con_descon;
wn_keypue := rec_04.hgd_keypue;
ws_keyper := rec_04.frp_keyper;
-- -----------------------------------
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
from glcopams
where pam_keypar = (select t1.pam_folini
from glcopams t1
where t1.pam_cvesec='gimpre')
and pam_folini = ws_keycon
and pam_folfin = wn_keypro;
exception when no_data_found then lsdescon:= null;
end;
if nullif(lsdescon::text, '') is not null then
ws_descon := trim(both lsdescon);
end if;
-----------------------------------------------------------------------------
if wi_bandera = 1 then
wn_costot := wn_costot1;
end if;
-- -> inserccion de registros
wn_numsec := wn_numsec + 1;
insert into glwkcrys(cry_nomrep,cry_idepcc,cry_keyusu,
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
wn_tipcam,null, null, ws_sitfis, wn_defrec, ws_estcta, ws_stscon, wn_keysec);
if wi_bandera = 1 then    -- se procesan conceptos netos ( futbol)
wi_primeravez := wi_primeravez + 1;
end if;
end loop;	-- rec_04
else   -- -> diferente a agrupacion 18
if ws_keycon = 'H08' or ws_keycon = 'H09' then -- -> viaticos
--inserccion de registros
wn_numsec := wn_numsec + 1;
insert into glwkcrys(cry_nomrep,cry_idepcc,cry_keyusu,
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
else
--				else if ws_keycon = 'H04' then --repeticion
if ws_keycon = 'H04' then --repeticion
-- -> inserccion de registros
wn_numsec := wn_numsec + 1;
insert into glwkcrys(cry_nomrep,cry_idepcc,cry_keyusu,
cry_numsec,cry_dec007,cry_dec008,cry_dec009,cry_dat003,cry_dat004,cry_dec010,
cry_dec011,cry_dec012,cry_dec013,cry_dec014,cry_dec015,cry_dec016,cry_dec017,
cry_dec018,cry_dec019,cry_chr001,cry_chr003,cry_chr004,cry_chr005,cry_chr012,
cry_chr013,cry_chr017,cry_chr018,cry_dat001,cry_dat002,cry_chr006,cry_dec021,
cry_dec022,cry_dec020,cry_chr007,cry_chr019,cry_chr020,cry_chr021)
values (ws_nomrep,ws_idepcc,wn_keyusu, wn_numsec,wn_numemi,wn_perini,wn_perfin,wd_fecini,wd_fecfin,
wn_numrec, wn_keyemp, null, null, null, null,wn_keynom,wn_keypro,
null, wn_costot,ws_nomemp,ws_desapr,ws_destip, null, null,
ws_regrfc,ws_keycon,ws_codimp,wd_fecpag, null, null, 2,
wn_tipcam, null, null, ws_sitfis, ws_estcta, ws_stscon);
else -- el resto
-- puede ser percepcion o deduccion
-- en caso de ser una persepcion se realiza una nueva inserccion
if ws_codimp = '01' then
wn_numsec := wn_numsec + 1;
insert into glwkcrys(cry_nomrep,cry_idepcc,cry_keyusu,
cry_numsec,cry_dec007,cry_dec008,cry_dec009,cry_dat003,cry_dat004,cry_dec010,
cry_dec011,cry_dec012,cry_dec013,cry_dec014,cry_dec015,cry_dec016,cry_dec017,
cry_dec018,cry_dec019,cry_chr001,cry_chr003,cry_chr004,cry_chr005,cry_chr012,
cry_chr013,cry_chr017,cry_chr018,cry_dat001,cry_dat002,cry_chr006,
cry_dec020,cry_chr007,cry_dec021,cry_dec022,cry_chr019,cry_chr020,cry_chr021)
values (ws_nomrep,ws_idepcc,wn_keyusu, wn_numsec,wn_numemi,wn_perini,wn_perfin,wd_fecini,wd_fecfin,
wn_numrec, wn_keyemp, null, null, null, null, wn_keynom,wn_keypro,
null,wn_costot,ws_nomemp,ws_desapr,ws_destip,ws_descon,null,
ws_regrfc,ws_keycon,ws_codimp,wd_fecpag,null     ,null     ,
null, null, 4, wn_tipcam, ws_sitfis, ws_estcta, ws_stscon);
else --en caso de ser deduccion se hace una actualizacion o una inserccion
-- -> busqueda del registro para actualizar
begin
select coalesce(min(cry_numsec),0)
into strict wn_regded
from glwkcrys
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
update glwkcrys
set cry_dec020 = wn_costot,
cry_chr007 = ws_descon
where cry_nomrep = ws_nomrep
and cry_idepcc = ws_idepcc
and cry_keyusu = wn_keyusu
and cry_numsec = wn_regded;
else
wn_numsec := wn_numsec + 1;
insert into glwkcrys(cry_nomrep,cry_idepcc,cry_keyusu,
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
end if; --
end if; --
end if; --
end if; --
end if; --
end loop;  -- rec_03
end loop;  -- rec_02
end loop;  -- rec_01
-- -> elimina rangos
delete from glwkrang
where ran_idepcc = ws_idepcc
and ran_keyusu = wn_keyusu
and ran_nomrep = ws_nomrep;end;
$body$
language plpgsql
;
