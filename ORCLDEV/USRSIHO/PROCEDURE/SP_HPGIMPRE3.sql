create or replace procedure usrsiho."sp_hpgimpre3"  (ws_nomrep varchar,ws_idepcc varchar,wn_keyusu numeric, ws_keyapr varchar,wn_keypro numeric,wn_keynom numeric, wn_numemi numeric,wn_tiprec numeric,wn_lstemp numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
--- returning varvarchar(99);
--- define val varvarchar(99);
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
wn_tipcam  numeric;    -- cry_dec022
ws_nomemp  varchar(60); -- cry_chr001
ws_desapr  varchar(40); -- cry_chr003
ws_destip  varchar(40); -- cry_chr004
ws_desdep  varchar(40); -- cry_chr005
ws_descon  varchar(40); -- cry_chr006
ws_keydep  varchar(16); -- cry_chr012
ws_regrfc  varchar(13); -- cry_chr013
ws_keycon  varchar(3);  -- cry_chr017
ws_codimp  varchar(2);  -- cry_chr018
wd_fecpag  timestamp(0);     -- cry_dat001
wd_fectrab timestamp(0);     -- cry_dat002
wd_fecini  timestamp(0);     -- cry_dat003
wd_fecfin  timestamp(0);     -- cry_dat004
ws_sitfis  varchar(8);  -- cry_chr019
ws_estcta  varchar(8);  -- cry_chr020
ws_stscon  varchar(3);  -- cry_chr021
wn_keysec  numeric(10);  -- cry_dec025    variable nueva por jdcm
wn_keyagr  numeric(10);  -- numero de agrupacion
wn_regded  numeric(10);  -- numero del secuencial para deduccion
wn_defrec  numeric(5); -- cry_dec023 define si es recibo o liquidacisn para derechos de autor
wn_tip112  numeric(5); --            define si es recibo o liquidacisn para derechos de autor
lsdescon   varchar(40);
rec record;
rec2 record;
begin
-- descripcion de concepto para validar por opcis
perform dbms_output.put_line('inicio..');
-- limpia la tabla para este reporte
delete
from usrsiho.glwkcrys
where cry_nomrep = ws_nomrep
and cry_idepcc = ws_idepcc
and cry_keyusu = wn_keyusu;
wn_numsec:=0;/* dmap converted statement start */
--lectura de los datos del header
--norecibo,codigo,nomemp,rfcemp,ubicacion,keynom,desnom,numemi,perini,perfin,fecini,fecfin,fecpag
--per/ded codimp,conepto descon
for rec in (select rec_keyrec,emp_keyemp,emp_nomemp,emp_regrfc,pam_nompar,nom_destip,
min((per_keyper)::numeric ) perini,max((per_keyper)::numeric ) perfin,
min(per_fecini) fecini,max(per_fecfin) fecfin,per_fecpag,
his_codimp,con_keycon,con_descon,sum(his_import) suma_imp,agc_keyagr,per_nu1aux,emp_ca2aux,
emp_cveban,rec_stscon --decode(rec_stscon,1,' ','*') stscon
from usrsiho.holoreci
join usrsiho.nmcoempl on rec_keyemp=emp_keyemp
join usrsiho.nmlonomi on rec_keynom=nom_keynom
join usrsiho.nmloperi on rec_keypro=per_keypro and rec_keynom=per_keynom and rtrim(rec_keyapr::text)=rtrim(per_nu3aux::text)
and rec_numemi=rtrim(per_nu4aux::text)
join usrsiho.glcopams on rtrim(pam_cvesec::text)=rtrim(rec_keyapr::text) and pam_keypar='H2'
join usrsiho.nmlohism on per_keypro=his_keypro and per_keyper=his_keyper
and rec_keyemp=his_keyemp and his_codimp in ('01','02')
join usrsiho.nmloconc on his_keycon=con_keycon and con_keycon not in ('H08','H09','28D')
left join usrsiho.holoagcp on agc_keycon = con_keycon and agc_keyagr = 18
where rtrim(rec_keyapr::text)=rtrim(ws_keyapr::text)
and rec_keypro=wn_keypro
and rec_keynom=wn_keynom
and rec_numemi=wn_numemi
and ( (wn_lstemp > 0 and his_keyemp in (select ran_keyemp
from glwkrang
where ran_nomrep = 'hpgimpre3'
and ran_idepcc = ws_idepcc
and ran_keyusu = wn_keyusu
)
) or
wn_lstemp = 0 )
group by rec_keyrec,emp_keyemp,emp_nomemp,emp_regrfc,pam_nompar,nom_keynom,
nom_destip,rec_numemi,per_fecpag,his_codimp,con_keycon,con_descon,
agc_keyagr,per_nu1aux,emp_ca2aux,emp_cveban,rec_import,rec_stscon,rec_stscon
union
select rec_keyrec,emp_keyemp,emp_nomemp,emp_regrfc,pam_nompar,nom_destip,
min((per_keyper)::numeric ) perini,max((per_keyper)::numeric ) perfin,
min(per_fecini) fecini,max(per_fecfin) fecfin,per_fecpag,
his_codimp,'H08','VIATICOS' con_keycon,sum(his_import) suma_imp,agc_keyagr,per_nu1aux,
emp_ca2aux,emp_cveban,rec_stscon
from usrsiho.holoreci
join usrsiho.nmcoempl on rec_keyemp=emp_keyemp
join usrsiho.nmlonomi on rec_keynom=nom_keynom
join usrsiho.nmloperi on rec_keypro=per_keypro and rec_keynom=per_keynom and rtrim(rec_keyapr::text)=per_nu3aux
and rec_numemi=per_nu4aux
join usrsiho.glcopams on rtrim(pam_cvesec::text)=rtrim(rec_keyapr::text) and pam_keypar='H2'
join usrsiho.nmlohism on per_keypro=his_keypro and per_keyper=his_keyper
and rec_keyemp=his_keyemp
join usrsiho.nmloconc on his_keycon=con_keycon and his_codimp in ('01','02') and con_keycon in ('H08','H09')
left join usrsiho.holoagcp on agc_keycon = con_keycon
and agc_keyagr = 18
where rec_keyapr=ws_keyapr
and rec_keypro=wn_keypro
and rec_keynom=wn_keynom
and rec_numemi=wn_numemi
and ( (wn_lstemp > 0 and his_keyemp in (select ran_keyemp
from usrsiho.glwkrang
where ran_nomrep = 'hpgimpre3'
and ran_idepcc = ws_idepcc
and ran_keyusu = wn_keyusu
)
) or
wn_lstemp = 0 )
group by rec_keyrec,emp_keyemp,emp_nomemp,emp_regrfc,pam_nompar,nom_keynom,
nom_destip,rec_numemi,per_fecpag,his_codimp,agc_keyagr,per_nu1aux,
emp_ca2aux,emp_cveban,rec_import,rec_stscon,rec_stscon
order by  12,16) loop -- ordenado: pe - de
perform dbms_output.put_line('consulta principal 1..');/* dmap converted statement end */
--- let val = wn_numrec;
--- return val with resume;
--carlos
--verifico que no exista descripcion opcional por opcis
wn_numrec := rec.rec_keyrec;
wn_keyemp := rec.emp_keyemp;
ws_nomemp := rec.emp_nomemp;
ws_regrfc := rec.emp_regrfc;
ws_desapr := rec.pam_nompar;
ws_destip := rec.nom_destip;
wn_perini := rec.perini;
wn_perfin := rec.perfin;
wd_fecini := rec.fecini;
wd_fecfin := rec.fecfin;
wd_fecpag := rec.per_fecpag;
ws_codimp := rec.his_codimp;
ws_keycon := rec.con_keycon;
ws_descon := rec.con_descon;
wn_costot := rec.suma_imp;
wn_keyagr := rec.agc_keyagr;
wn_tipcam := rec.per_nu1aux;/* dmap converted statement start */
ws_sitfis := rtrim(rec.emp_ca2aux::text);/* dmap converted statement end */
ws_estcta := rec.emp_cveban;
--decode(rec_stscon,1,' ','*') stscon
--ws_stscon := rec.stscon;
if rec.rec_stscon = 1 then
ws_stscon := ' ';
else
ws_stscon := '*';
end if;
begin
select pam_nompar
into strict lsdescon
from usrsiho.glcopams
where pam_keypar=(select t1.pam_folini
from usrsiho.glcopams t1
where t1.pam_cvesec='gimpre')
and pam_folini=ws_keycon
and pam_folfin=wn_keypro;
exception
when no_data_found then
lsdescon := null;
if nullif(lsdescon::text, '') is not null then
ws_descon := lsdescon;
end if;
--  if lsdescon is not null then
--     ws_descon:=trim(lsdescon);
--  end if;
end;
-----------------------------------------------------------------------------
perform dbms_output.put_line('consulta principal..');
--por cada recibo hacer el desglose
if wn_keyagr=18 then -- desglose para la agrupacion
wn_defrec := 0;
for rec2 in (select hgd_numcap,trim(both frp_keydep)||' '||case when coalesce(con_stsfir,' ')='N' then '*'  else ' ' end lista ,
dep_desdep,frp_keyrph,hgd_keysec,frp_fectrab,
hgd_costog,hgd_capini,hgd_capfin,hgd_numcap*hgd_costog costot,
con_descon
from usrsiho.holohgdp
join usrsiho.holofrph on frp_keyrph=hgd_keyrph  and frp_keypro=wn_keypro
and frp_keynom=wn_keynom  and (frp_keyper)::numeric  between wn_perini and wn_perfin
join usrsiho.nmcodeps on frp_keydep=dep_keydep
join usrsiho.nmloconc on hgd_keycon=con_keycon
left join usrsiho.holocont on hgd_keytco=con_keytco
and hgd_keyfol=con_keyfol
where hgd_keyemp=wn_keyemp
and hgd_keycon=ws_keycon
) loop
--- let val = wn_numrec || '/' || wn_keyrph;
--- return val with resume;
--carlos
--verifico que no exista descripcion opcional por opcis
wn_numcap := rec2.hgd_numcap;
ws_keydep := rec2.lista;
ws_desdep := rec2.dep_desdep;
wn_keyrph := rec2.frp_keyrph;
wn_keysec := rec2.hgd_keysec;
wd_fectrab := rec2.frp_fectrab;
wn_cosuni := rec2.hgd_costog;
wn_capini := rec2.hgd_capini;
wn_capfin := rec2.hgd_capfin;
wn_costot := rec2.costot;
ws_descon := rec2.con_descon;
begin
select pam_nompar
into strict lsdescon
from usrsiho.glcopams
where pam_keypar=(select t1.pam_folini
from usrsiho.glcopams t1
where t1.pam_cvesec='gimpre')
and pam_folini=ws_keycon
and pam_folfin=wn_keypro;
exception
when no_data_found then
lsdescon := null;
if nullif(lsdescon::text, '') is not null then
ws_descon := lsdescon;
end if;
--if lsdescon is not null then
--   ws_descon:=trim(lsdescon);
--end if;
end;
-----------------------------------------------------------------------------
-- define si es recibo o liquidacisn para derechos de autor
if wn_tiprec = 3 then
if  oracle.substr(ws_keycon,1,3)='H65' then
wn_defrec:=2;
elsif oracle.substr(ws_keycon,1,3)='H66' or oracle.substr(ws_keycon,1,3) = 'H17' or oracle.substr(ws_keycon,1,3) = 'H2' then
wn_defrec:=3;
elsif oracle.substr(ws_keycon,1,3)='H67' then
wn_defrec:=1;
elsif oracle.substr(ws_keycon,1,3)='H68' then
wn_defrec:=2;
elsif oracle.substr(ws_keycon,1,3)='H69' or oracle.substr(ws_keycon,1,3)='H3' or oracle.substr(ws_keycon,1,3)='H4' or oracle.substr(ws_keycon,1,3)='H6' or oracle.substr(ws_keycon,1,3)='H7' then
wn_defrec:=2;
end if;
end if;
perform dbms_output.put_line('inserta..');
--inserccion de registros
wn_numsec:=wn_numsec + 1;
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
end loop;
-- si el recibo es para derecos de autor y no se ha definido el tipo
if wn_defrec = 3 then
select count(*)
into strict wn_tip112
from usrsiho.nmlohism
where his_keypro = wn_keypro
and his_keyper between wn_perini and wn_perfin
and his_keyemp = wn_keyemp
and trim(both his_keycon) in ('H24','H28')
and his_codimp in ('01','02');
if wn_tip112 > 0 then
wn_defrec := 2;
else
wn_defrec := 1;
end if;
-- define el tipo de recibo
update usrsiho.glwkcrys
set cry_dec023 = wn_defrec
where cry_nomrep=ws_nomrep
and cry_idepcc=ws_idepcc
and cry_keyusu=wn_keyusu
and cry_dec010=wn_numrec;
end if;
else
--- let val = wn_numrec || '/ OTRO CASO'
--- return val with resume;
perform dbms_output.put_line('inserta else..');
if ws_keycon='H08' or ws_keycon='H09' then --viaticos
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
elsif ws_keycon='H04' then --repeticion
--inserccion de registros
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
else --el resto
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
--busqueda del registro para actualizar
select coalesce(min(cry_numsec),0)
into strict wn_regded
from usrsiho.glwkcrys
where cry_nomrep=ws_nomrep
and cry_idepcc=ws_idepcc
and cry_keyusu=wn_keyusu
and cry_dec010=wn_numrec
and nullif(cry_dec020::text, '') is null
and nullif(cry_chr007::text, '') is null;
--si encontro el registro => se realiza la actualizacion
if wn_regded > 0 then
update usrsiho.glwkcrys
set cry_dec020=wn_costot,
cry_chr007=ws_descon
where cry_nomrep=ws_nomrep
and cry_idepcc=ws_idepcc
and cry_keyusu=wn_keyusu
and cry_numsec=wn_regded;
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
perform dbms_output.put_line('fin loop..');
-- elimina rangos
--delete
--from usrsiho.glwkrang
--where ran_nomrep = 'hpgimpre3'
--  and ran_idepcc = ws_idepcc
--  and ran_keyusu = wn_keyusu;
end;
$body$
language plpgsql
;
