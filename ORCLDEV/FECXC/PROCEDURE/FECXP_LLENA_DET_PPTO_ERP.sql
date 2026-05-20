create or replace procedure fecxc."fecxp_llena_det_ppto_erp"  ( v_version_fe numeric, v_mes_desde numeric, v_mes_hasta numeric, v_ecodigo_desde numeric, v_ecodigo_hasta numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_periodo integer:= (to_char(clock_timestamp(), 'YYYY'))::numeric;
v_mes_act integer := (to_char(clock_timestamp(), 'MM'))::numeric;
v_cla_fe_id fecxp_politicas_erp.cla_fe_id%type;
v_prioridad fecxp_politicas_erp.prioridad%type;
v_tipo_operacion_ini fecxp_politicas_erp.tipo_operacion_ini%type;
v_tipo_operacion_fin fecxp_politicas_erp.tipo_operacion_fin%type;
v_id_banco_ini fecxp_politicas_erp.id_banco_ini%type;
v_id_banco_fin fecxp_politicas_erp.id_banco_fin%type;
v_id_chequera_ini fecxp_politicas_erp.id_chequera_ini%type;
v_id_chequera_fin fecxp_politicas_erp.id_chequera_fin%type;
v_politica_erp_id fecxp_politicas_erp.politica_erp_id%type;
v_ora_s1_ini fecxp_politicas_erp.oracle_segmento1_ini%type;
v_ora_s1_fin fecxp_politicas_erp.oracle_segmento1_fin%type;
v_ora_s2_ini fecxp_politicas_erp.oracle_segmento2_ini%type;
v_ora_s2_fin fecxp_politicas_erp.oracle_segmento2_fin%type;
v_ora_s3_ini fecxp_politicas_erp.oracle_segmento3_ini%type;
v_ora_s3_fin fecxp_politicas_erp.oracle_segmento3_fin%type;
v_ora_s4_ini fecxp_politicas_erp.oracle_segmento4_ini%type;
v_ora_s4_fin fecxp_politicas_erp.oracle_segmento4_fin%type;
v_ora_s5_ini fecxp_politicas_erp.oracle_segmento5_ini%type;
v_ora_s5_fin fecxp_politicas_erp.oracle_segmento5_fin%type;
v_ora_s6_ini fecxp_politicas_erp.oracle_segmento6_ini%type;
v_ora_s6_fin fecxp_politicas_erp.oracle_segmento6_fin%type;
v_ora_s7_ini fecxp_politicas_erp.oracle_segmento7_ini%type;
v_ora_s7_fin fecxp_politicas_erp.oracle_segmento7_fin%type;
cursor_clasificacion_fe_ing cursor for
select	cla_fe_id, politica_erp_id, prioridad, tipo_operacion_ini, tipo_operacion_fin, id_banco_ini, id_banco_fin, id_chequera_ini, id_chequera_fin,
oracle_segmento1_ini, oracle_segmento1_fin, oracle_segmento2_ini, oracle_segmento2_fin, oracle_segmento3_ini, oracle_segmento3_fin, oracle_segmento4_ini, oracle_segmento4_fin, oracle_segmento5_ini, oracle_segmento5_fin, oracle_segmento6_ini, oracle_segmento6_fin, oracle_segmento7_ini, oracle_segmento7_fin
from	fecxp_politicas_erp
where	id_tipo_movto in ('A', 'I')
and		activa_regla = 1
order by prioridad asc;
cursor_clasificacion_fe_egr cursor for
select	cla_fe_id, politica_erp_id, prioridad, tipo_operacion_ini, tipo_operacion_fin, id_banco_ini, id_banco_fin, id_chequera_ini, id_chequera_fin,
oracle_segmento1_ini, oracle_segmento1_fin, oracle_segmento2_ini, oracle_segmento2_fin, oracle_segmento3_ini, oracle_segmento3_fin, oracle_segmento4_ini, oracle_segmento4_fin, oracle_segmento5_ini, oracle_segmento5_fin, oracle_segmento6_ini, oracle_segmento6_fin, oracle_segmento7_ini, oracle_segmento7_fin
from	fecxp_politicas_erp
where	id_tipo_movto in ('A', 'E')
and		activa_regla = 1
order by prioridad asc;
begin 

/*modificacion agosto 09 v8 separacion entre reales y ppto y a?adir parametros*/
/*proviene de fecxp_llena_det_cont_erp*/
/*modificacion mayo 09 v4  referencia,desc y nocte */
/*modificacion abr 09 v3.  crear detalles de inversion y coinversion*/
/*modificacion dic 08 v2.*/
--===============================================================================================--
--== empieza ppto ==--
delete from fecxp_del_ppto_com_cta_erp;
insert into fecxp_del_ppto_com_cta_erp
select	distinct e_codigo, code_combination, oracle_segmento1, oracle_segmento2, oracle_segmento3,oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7
from	fecxp_ppto_conversion_erp
where	e_codigo >= v_ecodigo_desde
and		e_codigo <= v_ecodigo_hasta
and		mes >= v_mes_desde
and		mes <= v_mes_hasta
and		version_fe = v_version_fe
;
/* commit; */
--== limpia tabla de enlace  ==--
delete	from fecxp_rep_ppto_com_cta_erp  a
where	exists (
select 1
from fecxp_ppto_conversion_erp d
where	d.e_codigo >= v_ecodigo_desde
and		d.e_codigo <= v_ecodigo_hasta
and		d.mes >= v_mes_desde
and		d.mes <= v_mes_hasta
and		d.version_fe = v_version_fe
and		coalesce(a.oracle_segmento1,'0') =  coalesce(d.oracle_segmento1,'0')
and		coalesce(a.oracle_segmento2,'0') = coalesce(d.oracle_segmento2,'0')
and		coalesce(a.oracle_segmento3,'0') = coalesce(d.oracle_segmento3,'0')
and		coalesce(a.oracle_segmento4,'0') = coalesce(d.oracle_segmento4,'0')
and		coalesce(a.oracle_segmento5,'0') = coalesce(d.oracle_segmento5,'0')
and		coalesce(a.oracle_segmento6,'0') = coalesce(d.oracle_segmento6,'0')
and		coalesce(a.oracle_segmento7,'0') = coalesce(d.oracle_segmento7,'0')
)
;
/* commit; */
--== se cargan las cuentas contables del presupuesto  ==--
/*insert into fecxp_rep_ppto_com_cta_erp (cla_fe_id, e_codigo, code_combination_id, oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7)
select	distinct '|'as cla_fe_id, e_codigo, code_combination, oracle_segmento1, oracle_segmento2, oracle_segmento3,oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7
from	fecxp_ppto_conversion_erp
where	e_codigo >= v_ecodigo_desde
and		e_codigo <= v_ecodigo_hasta
and		mes >= v_mes_desde
and		mes <= v_mes_hasta
and		version_fe = v_version_fe
;*/
insert	into fecxp_rep_ppto_com_cta_erp(cla_fe_id, e_codigo, code_combination_id, oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7)
select	distinct '|'as cla_fe_id, e_codigo, code_combination_id, oracle_segmento1, oracle_segmento2, oracle_segmento3,oracle_segmento4, oracle_segmento5, oracle_segmento6, oracle_segmento7
from	fecxp_del_ppto_com_cta_erp;
/* commit; */
--==  clasificacion de cuentas sesgun politicas de clasificacion de fe ==--
open	cursor_clasificacion_fe_egr;
loop
fetch	cursor_clasificacion_fe_egr
into	v_cla_fe_id, v_politica_erp_id, v_prioridad, v_tipo_operacion_ini, v_tipo_operacion_fin, v_id_banco_ini, v_id_banco_fin, v_id_chequera_ini, v_id_chequera_fin,
v_ora_s1_ini, v_ora_s1_fin, v_ora_s2_ini, v_ora_s2_fin, v_ora_s3_ini, v_ora_s3_fin, v_ora_s4_ini, v_ora_s4_fin, v_ora_s5_ini, v_ora_s5_fin, v_ora_s6_ini, v_ora_s6_fin, v_ora_s7_ini, v_ora_s7_fin;
exit when not found; /* apply on cursor_clasificacion_fe_egr */
update	fecxp_rep_ppto_com_cta_erp
set		cla_fe_id = v_cla_fe_id
where (oracle_segmento1 >= coalesce(v_ora_s1_ini, '0'))
and (oracle_segmento1 <= coalesce(v_ora_s1_fin, 'z'))
and (oracle_segmento2 >= coalesce(v_ora_s2_ini, '0'))
and (oracle_segmento2 <= coalesce(v_ora_s2_fin, 'z'))
and (oracle_segmento3 >= coalesce(v_ora_s3_ini, '0'))
and (oracle_segmento3 <= coalesce(v_ora_s3_fin, 'z'))
and (oracle_segmento4 >= coalesce(v_ora_s4_ini, '0'))
and (oracle_segmento4 <= coalesce(v_ora_s4_fin, 'z'))
and (oracle_segmento5 >= coalesce(v_ora_s5_ini, '0'))
and (oracle_segmento5 <= coalesce(v_ora_s5_fin, 'z'))
and (oracle_segmento6 >= coalesce(v_ora_s6_ini, '0'))
and (oracle_segmento6 <= coalesce(v_ora_s6_fin, 'z'))
and (oracle_segmento7 >= coalesce(v_ora_s7_ini, '0'))
and (oracle_segmento7 <= coalesce(v_ora_s7_fin, 'z'))
and		coalesce(v_tipo_operacion_ini, 0) = 0
and		coalesce(v_tipo_operacion_fin, 0) = 0
and		coalesce(v_id_banco_ini, 0) = 0
and		coalesce(v_id_banco_fin, 0) = 0
and		coalesce(lpad(v_id_chequera_ini::text, 20, '0'::text), '00000000000000000000') = '00000000000000000000'
and		coalesce(lpad(v_id_chequera_fin::text, 20, '0'::text), '00000000000000000000') = '00000000000000000000'
and		e_codigo >= v_ecodigo_desde
and		e_codigo <= v_ecodigo_hasta
and		coalesce(cla_fe_id, '|') = '|';
/* commit; */
end loop;
close	cursor_clasificacion_fe_egr;
delete	from fecxp_det_cont_version_fe
where	proceso = 'FECXP_LLENA_DET_PPTO_ERP';
insert	into fecxp_det_cont_version_fe(
proceso, version_fe)
values (
'FECXP_LLENA_DET_PPTO_ERP', v_version_fe);
/* commit; */
--===============================================================================================--
--== termina ppto ==--
exception
when no_data_found then
raise exception '%', 'NO HAY DATOS NUEVOS.' using errcode = '45000';
when others then
rollback;/* dmap converted statement start */
raise exception '%',  concat('Error:', sqlstate , ' - ' , sqlerrm)  using errcode = '45000';/* dmap converted statement end */end;
$body$
language plpgsql
;
