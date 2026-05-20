create or replace procedure labconf.interfacerecibos_recibostv2016_details ( v_keybin varchar, keypro numeric, keyper varchar, cv_empdetails inout refcursor ) as $body$
declare
-- pgv moved types end
/*keypro  proceso
keyper  periodo */
v_prohon numeric(1)  := 0;
v_keypro numeric(10) := null;
v_keynom numeric(10) := null;
v_keyper varchar(7)  := null;
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
declare
-- pgv moved types start
v_nrchecksum numeric(10);
v_keypar     varchar(6);
v_keyconsar  varchar(3);
v_desconsar  varchar(50);
v_desconvales280 varchar(50) := 'VALES DE DESPENSA';
v_desconvales336 varchar(50) := 'VALES DE FOMENTO CULTURAL';
begin
----------
begin
execute 'ALTER SESSION SET NULLIF(nls_sort::text, '') IS NULLBINARY ;' ; /* dmap converted statement */
end;
-------- leer argumentos -----------------------
v_keypro := keypro;
v_keyper := keyper;
select per_keynom into strict v_keynom
from labconf.nmloperi
where per_keypro = v_keypro
and per_keyper = v_keyper;
begin
delete
from labconf.ps_tpw_msgxconcs
where msgs_keypro = v_keypro
and msgs_keyper = v_keyper;
exception
when no_data_found then
perform dbms_output.put_line('NO HACER NADA');
end;/* dmap converted statement start */
------------------ leer opcis -----------------------
begin
------------------ clave de opcis  ------------------
begin
select coalesce(rtrim(pam_folini::text), ' ')
into strict v_keypar
from labconf.glcopams
where pam_keypar = '00'
and pam_cvesec   = v_keybin;/* dmap converted statement end */
exception
when no_data_found then
v_keypar := '0000';
end;
-----------------------------------------------------
-- procesos de honorarios
-----------------------------------------------------
begin
select
case pam_folini when 'S' then 1 else 0 end
into strict v_prohon
from labconf.glcopams
where pam_keypar = v_keypar
and pam_cvesec = 'OPCI87'
and pam_folini = v_keypro;
exception
when no_data_found then
v_prohon := 0;
end;
-----------------------------------------------------
-- 1 his_dias
-----------------------------------------------------
begin
insert into labconf.ps_tpw_msgxconcs(select v_keypro, v_keyper, con_keycon , 1 from labconf.nmloconc where con_keycon in ( '001' ));
end;
-----------------------------------------------------
-- 2 tot_isr
-----------------------------------------------------
begin
insert into labconf.ps_tpw_msgxconcs(select distinct v_keypro, v_keyper, con_keycon , 2
from labconf.glcopams
join labconf.nmloconc on ( con_keycon  = pam_folfin )
where pam_keypar = v_keypar
and pam_folini = 'ISR'
-- and pam_cvesec   = opcixx
);
exception
when no_data_found then
insert into labconf.ps_tpw_msgxconcs(select v_keypro, v_keyper, con_keycon , 2 from labconf.nmloconc where con_keycon in ( '100','151','183','294','47A' )
);
end;
-----------------------------------------------------
-- 3 tot_per
-----------------------------------------------------
begin
insert
into labconf.ps_tpw_msgxconcs(select distinct v_keypro, v_keyper, con_keycon , 3
from labconf.glcopams
join labconf.nmloconc on ( con_keycon  = pam_folfin )
where pam_keypar = v_keypar
and pam_folini = 'PERCEPCIONES'
-- and pam_cvesec   = opcixx
);
exception
when no_data_found then
insert into labconf.ps_tpw_msgxconcs(select v_keypro, v_keyper, con_keycon, 3 from labconf.nmloconc  where con_keycon in ( '260','273','290' ));
end;
-----------------------------------------------------
-- 4 tot_ded
-----------------------------------------------------
insert
into labconf.ps_tpw_msgxconcs(select v_keypro, v_keyper, con_keycon, 4 from labconf.nmloconc
where con_keycon in ( '261','274','291' ));
-----------------------------------------------------
-- 5 imp_neto
-----------------------------------------------------
insert
into labconf.ps_tpw_msgxconcs(select v_keypro, v_keyper, con_keycon, 5
from labconf.nmloconc
where con_keycon in ( '262','275','292' )
);
-----------------------------------------------------
-- ver que opci es para suma aportaciones ca
-- 6 aportaciones ca
-----------------------------------------------------
begin
insert
into labconf.ps_tpw_msgxconcs(select distinct v_keypro, v_keyper, con_keycon, 6
from labconf.glcopams
join labconf.nmloconc
on ( con_keycon  = pam_folfin )
where pam_keypar = v_keypar
and pam_nompar = 'Suma Aportaciones CA'
-- and pam_cvesec   = opcixx
);
exception
when no_data_found then
insert
into labconf.ps_tpw_msgxconcs( select v_keypro, v_keyper, con_keycon , 6 from labconf.nmloconc where con_keycon in ( 'D63','23D' ));
end;
-----------------------------------------------------
-- ver que opci es para suma ptmos ca
-- 7 prestamos ca
-----------------------------------------------------
begin
insert
into labconf.ps_tpw_msgxconcs(select distinct v_keypro, v_keyper, con_keycon , 7
from labconf.glcopams
join labconf.nmloconc on ( con_keycon  = pam_folfin )
where pam_keypar = v_keypar
and pam_nompar = 'Suma Ptmos CA'
--and pam_cvesec   = opcixx
);
exception
when no_data_found then
insert
into labconf.ps_tpw_msgxconcs(select v_keypro, v_keyper, con_keycon , 7
from labconf.nmloconc
where con_keycon in ( 'D64','D68','21D','22D' )
);
end;
-----------------------------------------------------
--ver que opci es para suma fundacion ca
--8 fundacion tv,
-----------------------------------------------------
begin
insert
into labconf.ps_tpw_msgxconcs(select distinct v_keypro, v_keyper, con_keycon, 8
from labconf.glcopams
join labconf.nmloconc on ( con_keycon  = pam_folfin )
where pam_keypar = v_keypar
and pam_nompar = 'Suma Fundacion CA'
--and pam_cvesec   = opcixx
);
exception
when no_data_found then
insert
into labconf.ps_tpw_msgxconcs( select v_keypro, v_keyper, con_keycon , 8 from labconf.nmloconc where con_keycon in ( '28D' ));
end;/* dmap converted statement start */
-----------------------------------------------------
-- auxiliar (423) cesantia y vejez bimestral
-- 9 sar
-----------------------------------------------------
begin
select rtrim(agp_desagp::text), rtrim(agp_keycon::text)
into strict v_desconsar, v_keyconsar
from labconf.tvconagp
where agp_numagr = 11;/* dmap converted statement end */
exception
when no_data_found then
v_desconsar := 'APORTACION SAR: ';
v_keyconsar := '423';
end;
begin
insert
into labconf.ps_tpw_msgxconcs(select distinct v_keypro, v_keyper, con_keycon , 9
from labconf.nmloconc
where con_keycon = v_keyconsar
);
exception
when no_data_found then
insert
into labconf.ps_tpw_msgxconcs( select v_keypro, v_keyper, con_keycon , 9 from labconf.nmloconc where con_keycon in ( '423' ));
end;
-----------------------------------------------------
-- 280 vales de despensa
-- 10 vales de despensa
-----------------------------------------------------
insert
into labconf.ps_tpw_msgxconcs(select v_keypro, v_keyper, con_keycon, 10 from labconf.nmloconc
where con_keycon in ( '280' ));
-----------------------------------------------------
-- 336 vales de fomento cultural
-- 11 vales de despensa
-----------------------------------------------------
insert
into labconf.ps_tpw_msgxconcs(select v_keypro, v_keyper, con_keycon, 11 from labconf.nmloconc
where con_keycon in ( '336' ));
-----------------------------------------------------
--ver que opci es para suma fundacion ca
--12 donativo para reconstruccion,
-----------------------------------------------------
begin
insert
into labconf.ps_tpw_msgxconcs
values (v_keypro, v_keyper, 'G09', 12);
end;
-----------------------------------------------------
-- rec acumulado de isr
-----------------------------------------------------
begin
insert
into labconf.ps_tpw_msgxconcs(select distinct v_keypro, v_keyper, pam_folfin, 13
from labconf.glcopams
where pam_keypar = v_keypar
and pam_folini = 'ISR-ACUM'
);
exception
when no_data_found then
insert
into labconf.ps_tpw_msgxconcs
values (v_keypro, v_keyper, 'REC', 13);
end;
-----------------------------------------------------
-- red acumulado de percepciones
-----------------------------------------------------
begin
insert
into labconf.ps_tpw_msgxconcs(select distinct v_keypro, v_keyper, pam_folfin, 14
from labconf.glcopams
where pam_keypar = v_keypar
and pam_folini = 'PERCEP-ACUM'
);
exception
when no_data_found then
insert
into labconf.ps_tpw_msgxconcs
values (v_keypro, v_keyper, 'RED', 14);
end;
end;
/* commit; */
v_nrchecksum := 0;/* dmap converted statement start */
--insert into tt_v_selempls values (2042703);
if v_keynom = 25 then
--para nomina de aguinaldo
open cv_empdetails for
select
oracle.substr(rtrim(cia_descia::text), 1, 37) razonsocial ,
rtrim(cia_dircia::text) direccioncia ,
per_keypro keypro ,
rtrim(ims_rfcims::text) regpatronal ,
his_keyemp keyemp ,
rtrim(replace(emp_nomemp::text, '/', ' ')) nomemp ,
oracle.substr(rtrim(hem_keydep::text), 1, 6) keydep ,
rtrim(hem_regrfc::text) rfc ,
rtrim(hem_recurp::text) curp ,
oracle.substr(rtrim(hem_keycen::text), 1, 8) keycen ,
coalesce(hem_fecaux, hem_fecing) ingreso ,---
per_keyper periodo ,
per_fecfin fecharecibo ,
(
case hem_tipsal
when '0' then 'FIJO' when '1' then 'VARIABLE'
when '2' then 'MIXTO'
else 'NO DEFINIDO'
end) tiposalimss ,
hem_regims afiliacionimss ,
case 0 when 0 then hem_saldia else null end salarodiario ,
case 0 when 0 then totales.his_dias else null end diastrabajados ,
hem_keyloc ubicacion1 ,
hem_keyloc ubicacion2 ,
hem_ctaban cuentadep ,--nmloctas, no se trae de nmloctas
totales.acum_isr isracum ,
totales.acum_per percepacum ,
totales.tot_isr ,
totales.tot_per ,
totales.tot_ded ,
totales.imp_neto ,
totales.apo_caho ,
totales.prest_caho ,
totales.imp_fund_tv,
totales.donativo_rec,
per_keycon ,
rtrim(cp.con_descon::text) per_descon ,
per_cantid ,
per_import ,
ded_keycon ,
rtrim(cd.con_descon::text) ded_descon ,
ded_cantid ,
ded_import ,
adeudo  ,
v_desconsar messagesar,
totales.tot_sar impmsgsar,
sec_row,
totales.val_desp,
totales.val_fom_cult ,
(totales.imp_neto + totales.apo_caho + totales.prest_caho + totales.imp_fund_tv + totales.donativo_rec) tot_net_rec,
case totales.val_desp when 0 then null else v_desconvales280 end msgvaldesp,
case totales.val_fom_cult when 0 then null else v_desconvales336 end  msgvalfomcult,
(totales.tot_ded - totales.apo_caho - totales.prest_caho - totales.imp_fund_tv - totales.donativo_rec) tot_ded_rec
from
(
select his_keyemp, sec_row,
max(per_keycon) per_keycon,
case when nullif(max(per_keycon)::text, '') is null then null else sum(per_cantid) end per_cantid,
case when nullif(max(per_keycon)::text, '') is null then null else sum(per_import) end per_import,
max(ded_keycon) ded_keycon,
case when nullif(max(ded_keycon)::text, '') is null then null else sum(ded_cantid) end ded_cantid,
case when nullif(max(ded_keycon)::text, '') is null then null else sum(ded_import) end ded_import,
sum(adeudo) adeudo
from
(   --esta es la diferencia del query entre la nomina de aguinaldo y la nomina ordinaria
--en la nomina de aguinaldo cada concepto va en una linea por separado
select  his_keyemp,
row_number() over ( partition by his_keyemp  order by  his_keyemp, his_codimp, his_keycon ) sec_row,
case his_codimp when 1 then his_keycon else null end per_keycon ,
case his_codimp when 1 then his_cantid else null end per_cantid ,
case his_codimp when 1 then his_import else null end per_import ,
case his_codimp when 2 then his_keycon else null end ded_keycon ,
case his_codimp when 2 then his_cantid else null end ded_cantid ,
case his_codimp when 2 then his_import else null end ded_import,
adeudo
from (
select his_keyemp,
coalesce(rtrim(con_ca1aux::text), his_keycon) group_conc,
case when min(his_keycon) = '026' then '000' else min(his_keycon) end his_keycon,
utils_convert_to_number(his_codimp,1,0) his_codimp,
sum(his_cantid) his_cantid,
sum(his_import) his_import,
count(*) his_count,
sum(coalesce(pre_impsal, 0)) adeudo
from labconf.nmloperi
join labconf.nmlohism on ( his_keypro = per_keypro and his_keyper  = per_keyper )
join labconf.nmloconc on ( con_keycon = his_keycon )
left outer join labconf.nmlopres on (pre_keyemp = his_keyemp and pre_keycon = his_keycon and pre_keypre = his_rowide)
where his_codimp in ( '01', '02' )
and con_nu1aux = (case per_keynom when 1 then '1' else con_nu1aux end ) -- tipo de recibo 1 paranomina ordinaria
and per_keypro     = v_keypro
and per_keyper     = v_keyper
and ( v_nrchecksum = 0 or ( his_keyemp in (select keyemp from labconf.tt_v_selempls) ) )
--and his_keyemp = 2028171  -- 2043702
group by his_keyemp, coalesce(rtrim(con_ca1aux::text), his_keycon), his_codimp
) hism
)hism_grps
group by his_keyemp, sec_row --, per_keycon, ded_keycon
) concs
join labconf.nmloperi on ( per_keypro = v_keypro and per_keyper = v_keyper )
join labconf.nmcoempl on ( emp_keyemp = his_keyemp )
join labconf.nmlohemp on ( hem_keypro = per_keypro and hem_keyper = per_keyper and hem_keyemp = his_keyemp )
join labconf.nmloproc on ( pro_keypro = per_keypro )
join labconf.nmlocias on ( cia_keycia = pro_keycia )
join labconf.nmloimss on ( ims_keyims = hem_keyims )
left join labconf.nmloconc cp on ( cp.con_keycon = concs.per_keycon )
left join labconf.nmloconc cd on ( cd.con_keycon = concs.ded_keycon )
join(select hem_keyemp keyemp ,
hism_per.acum_isr ,
hism_per.acum_per ,
hism_per.his_dias ,
hism_per.tot_isr ,
hism_per.tot_per ,
hism_per.tot_ded ,
hism_per.imp_neto ,
hism_per.apo_caho ,
hism_per.prest_caho ,
hism_per.imp_fund_tv,
hism_per.tot_sar,
hism_per.val_desp,
hism_per.val_fom_cult,
hism_per.donativo_rec
from labconf.nmloperi per_tots
join labconf.nmlohemp hem_tots on ( hem_tots.hem_keypro = per_tots.per_keypro and hem_tots.hem_keyper  = per_tots.per_keyper )
left join(select his_keyemp ,
sum( case msgs_tipocon when 1 then his_cantid else 0 end) his_dias ,
sum( case msgs_tipocon when 2 then his_import else 0 end) tot_isr ,
sum( case msgs_tipocon when 3 then his_import else 0 end) tot_per ,
sum( case msgs_tipocon when 4 then his_import else 0 end) tot_ded ,
sum( case msgs_tipocon when 5 then his_import else 0 end) imp_neto ,
sum( case msgs_tipocon when 6 then his_import else 0 end) apo_caho ,
sum( case msgs_tipocon when 7 then his_import else 0 end) prest_caho ,
sum( case msgs_tipocon when 8 then his_import else 0 end) imp_fund_tv,
sum( case msgs_tipocon when 9 then his_import else 0 end) tot_sar,
sum( case msgs_tipocon when 10 then his_import else 0 end) val_desp,
sum( case msgs_tipocon when 11 then his_import else 0 end) val_fom_cult,
sum( case msgs_tipocon when 12 then his_import else 0 end) donativo_rec,
sum( case msgs_tipocon when 13 then his_import else 0 end) acum_isr,
sum( case msgs_tipocon when 14 then his_import else 0 end) acum_per
from labconf.nmlohism
join labconf.ps_tpw_msgxconcs on (msgs_keypro = his_keypro and msgs_keyper = his_keyper and his_keycon    = msgs_keycon )
where his_keypro   = v_keypro
and his_keyper     = v_keyper
and ( v_nrchecksum = 0 or his_keyemp in (select keyemp from labconf.tt_v_selempls) )
group by his_keyemp
) hism_per on ( hism_per.his_keyemp = hem_tots.hem_keyemp )
where ( per_keypro                    = v_keypro
and per_keyper                        = v_keyper )
--and ( v_nrchecksum = 0 or acu_keyemp in (select keyemp from tt_v_selempls) )
) totales on totales.keyemp = his_keyemp
order by  his_keyemp,sec_row;/* dmap converted statement end *//* dmap converted statement start */
else
open cv_empdetails for
select
oracle.substr(rtrim(cia_descia::text), 1, 37) razonsocial ,
rtrim(cia_dircia::text) direccioncia ,
per_keypro keypro ,
rtrim(ims_rfcims::text) regpatronal ,
his_keyemp keyemp ,
rtrim(replace(emp_nomemp::text, '/', ' ')) nomemp ,
oracle.substr(rtrim(hem_keydep::text), 1, 6) keydep ,
rtrim(hem_regrfc::text) rfc ,
rtrim(hem_recurp::text) curp ,
oracle.substr(rtrim(hem_keycen::text), 1, 8) keycen ,
coalesce(hem_fecaux, hem_fecing) ingreso ,---
per_keyper periodo ,
per_fecpag fecharecibo ,
(
case hem_tipsal
when '0' then 'FIJO' when '1' then 'VARIABLE'
when '2' then 'MIXTO'
else 'NO DEFINIDO'
end) tiposalimss ,
hem_regims afiliacionimss ,
case 0 when 0 then hem_saldia else null end salarodiario ,
case 0 when 0 then totales.his_dias else null end diastrabajados ,
hem_keyloc ubicacion1 ,
hem_keyloc ubicacion2 ,
hem_ctaban cuentadep ,--nmloctas, no se trae de nmloctas
totales.acum_isr isracum ,
totales.acum_per percepacum ,
totales.tot_isr ,
totales.tot_per ,
totales.tot_ded ,
totales.imp_neto ,
totales.apo_caho ,
totales.prest_caho ,
totales.imp_fund_tv,
totales.donativo_rec,
per_keycon ,
rtrim(cp.con_descon::text) per_descon ,
per_cantid ,
per_import ,
ded_keycon ,
rtrim(cd.con_descon::text) ded_descon ,
ded_cantid ,
ded_import ,
adeudo  ,
v_desconsar messagesar,
totales.tot_sar impmsgsar,
sec_row,
totales.val_desp,
totales.val_fom_cult ,
(totales.imp_neto + totales.apo_caho + totales.prest_caho + totales.imp_fund_tv + totales.donativo_rec) tot_net_rec,
case totales.val_desp when 0 then null else v_desconvales280 end msgvaldesp,
case totales.val_fom_cult when 0 then null else v_desconvales336 end  msgvalfomcult,
(totales.tot_ded - totales.apo_caho - totales.prest_caho - totales.imp_fund_tv - totales.donativo_rec) tot_ded_rec
from
(
select his_keyemp, sec_row,
max(per_keycon) per_keycon,
case when nullif(max(per_keycon)::text, '') is null then null else sum(per_cantid) end per_cantid,
case when nullif(max(per_keycon)::text, '') is null then null else sum(per_import) end per_import,
max(ded_keycon) ded_keycon,
case when nullif(max(ded_keycon)::text, '') is null then null else sum(ded_cantid) end ded_cantid,
case when nullif(max(ded_keycon)::text, '') is null then null else sum(ded_import) end ded_import,
sum(adeudo) adeudo
from
(
select  his_keyemp,
row_number() over ( partition by his_keyemp, his_codimp  order by  his_keyemp, his_codimp, his_keycon ) sec_row,
case his_codimp when 1 then his_keycon else null end per_keycon ,
case his_codimp when 1 then his_cantid else null end per_cantid ,
case his_codimp when 1 then his_import else null end per_import ,
case his_codimp when 2 then his_keycon else null end ded_keycon ,
case his_codimp when 2 then his_cantid else null end ded_cantid ,
case his_codimp when 2 then his_import else null end ded_import,
adeudo
from (
select his_keyemp,
coalesce(rtrim(con_ca1aux::text), his_keycon) group_conc,
min(his_keycon) his_keycon,
utils_convert_to_number(his_codimp,1,0) his_codimp,
sum(his_cantid) his_cantid,
sum(his_import) his_import,
count(*) his_count,
sum(coalesce(pre_impsal, 0)) adeudo
from labconf.nmloperi
join labconf.nmlohism on ( his_keypro = per_keypro and his_keyper  = per_keyper )
join labconf.nmloconc on ( con_keycon = his_keycon )
left outer join labconf.nmlopres on (pre_keyemp = his_keyemp and pre_keycon = his_keycon and pre_keypre = his_rowide)
where his_codimp in ( '01', '02' )
and con_nu1aux = (case per_keynom when 1 then '1' else con_nu1aux end ) -- tipo de recibo 1 paranomina ordinaria
and per_keypro     = v_keypro
and per_keyper     = v_keyper
and ( v_nrchecksum = 0 or ( his_keyemp in (select keyemp from labconf.tt_v_selempls) ) )
--and his_keyemp = 2028171  -- 2043702
group by his_keyemp, coalesce(rtrim(con_ca1aux::text), his_keycon), his_codimp
) hism
)hism_grps
group by his_keyemp, sec_row --, per_keycon, ded_keycon
) concs
join labconf.nmloperi on ( per_keypro = v_keypro and per_keyper = v_keyper )
join labconf.nmcoempl on ( emp_keyemp = his_keyemp )
join labconf.nmlohemp on ( hem_keypro = per_keypro and hem_keyper = per_keyper and hem_keyemp = his_keyemp )
join labconf.nmloproc on ( pro_keypro = per_keypro )
join labconf.nmlocias on ( cia_keycia = pro_keycia )
join labconf.nmloimss on ( ims_keyims = hem_keyims )
left join labconf.nmloconc cp on ( cp.con_keycon = concs.per_keycon )
left join labconf.nmloconc cd on ( cd.con_keycon = concs.ded_keycon )
join(select hem_keyemp keyemp ,
acums.acum_isr ,
acums.acum_per ,
hism_per.his_dias ,
hism_per.tot_isr ,
hism_per.tot_per ,
hism_per.tot_ded ,
hism_per.imp_neto ,
hism_per.apo_caho ,
hism_per.prest_caho ,
hism_per.imp_fund_tv,
hism_per.tot_sar,
hism_per.val_desp,
hism_per.val_fom_cult,
hism_per.donativo_rec
from labconf.nmloperi per_tots
join labconf.nmlohemp hem_tots on ( hem_tots.hem_keypro = per_tots.per_keypro and hem_tots.hem_keyper  = per_tots.per_keyper )
left join(select hem_keyemp acu_keyemp ,
sum( case msgs_tipocon
when 2 then coalesce(acu_impuno, 0) + coalesce(acu_impdos, 0) + coalesce(acu_imptre, 0) + coalesce(acu_impcua, 0) + coalesce(acu_impcin, 0) + coalesce(acu_impsei, 0) + coalesce(acu_impsie, 0) + coalesce(acu_impoch, 0) + coalesce(acu_impnue, 0) + coalesce(acu_impdie, 0) + coalesce(acu_imponc, 0) + coalesce(acu_impdoc, 0)
else 0 end) acum_isr ,
sum( case msgs_tipocon
when 3 then coalesce(acu_impuno, 0) + coalesce(acu_impdos, 0) + coalesce(acu_imptre, 0) + coalesce(acu_impcua, 0) + coalesce(acu_impcin, 0) + coalesce(acu_impsei, 0) + coalesce(acu_impsie, 0) + coalesce(acu_impoch, 0) + coalesce(acu_impnue, 0) + coalesce(acu_impdie, 0) + coalesce(acu_imponc, 0) + coalesce(acu_impdoc, 0)
else 0 end) acum_per
from labconf.nmloperi
join labconf.nmlohemp on ( hem_keypro = per_keypro and hem_keyper  = per_keyper )
left join labconf.nmloacum on ( acu_keyemp = hem_keyemp and acu_keypro  = hem_keypro and acu_anioac  = per_anioa1 )
left join labconf.ps_tpw_msgxconcs on (msgs_keypro = per_keypro and msgs_keyper = per_keyper and acu_keycon = msgs_keycon )
where ( per_keypro = v_keypro
and per_keyper     = v_keyper )
and ( v_nrchecksum = 0 or hem_keyemp in (select keyemp from labconf.tt_v_selempls) )
group by hem_keyemp
) acums on ( acums.acu_keyemp = hem_tots.hem_keyemp )
left join(select his_keyemp ,
sum( case msgs_tipocon when 1 then his_cantid else 0 end) his_dias ,
sum( case msgs_tipocon when 2 then his_import else 0 end) tot_isr ,
sum( case msgs_tipocon when 3 then his_import else 0 end) tot_per ,
sum( case msgs_tipocon when 4 then his_import else 0 end) tot_ded ,
sum( case msgs_tipocon when 5 then his_import else 0 end) imp_neto ,
sum( case msgs_tipocon when 6 then his_import else 0 end) apo_caho ,
sum( case msgs_tipocon when 7 then his_import else 0 end) prest_caho ,
sum( case msgs_tipocon when 8 then his_import else 0 end) imp_fund_tv,
sum( case msgs_tipocon when 9 then his_import else 0 end) tot_sar,
sum( case msgs_tipocon when 10 then his_import else 0 end) val_desp,
sum( case msgs_tipocon when 11 then his_import else 0 end) val_fom_cult,
sum( case msgs_tipocon when 12 then his_import else 0 end) donativo_rec
from labconf.nmlohism
join labconf.ps_tpw_msgxconcs on (msgs_keypro = his_keypro and msgs_keyper = his_keyper and his_keycon    = msgs_keycon )
where his_keypro   = v_keypro
and his_keyper     = v_keyper
and ( v_nrchecksum = 0 or his_keyemp in (select keyemp from labconf.tt_v_selempls) )
group by his_keyemp
) hism_per on ( hism_per.his_keyemp = hem_tots.hem_keyemp )
where ( per_keypro                    = v_keypro
and per_keyper                        = v_keyper )
--and ( v_nrchecksum = 0 or acu_keyemp in (select keyemp from tt_v_selempls) )
) totales on totales.keyemp = his_keyemp
order by  his_keyemp,sec_row;/* dmap converted statement end */
end if;
end;end;
$body$
language plpgsql
;
