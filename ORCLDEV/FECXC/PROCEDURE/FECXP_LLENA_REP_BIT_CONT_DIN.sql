create or replace procedure fecxc."fecxp_llena_rep_bit_cont_din"  ( v_fecha_ini datedefault sysdate-12, v_fecha_fin datedefault sysdate-1, v_e_codigo_ini integerdefault 0, v_e_codigo_fin integerdefault 9999 ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
/*
declare
v_fecha_ini date:= to_timestamp('20070626','YYYYMMDD');
v_fecha_fin date:= to_timestamp('20070626','YYYYMMDD');
v_e_codigo_ini integer:= 0;
v_e_codigo_fin integer:= 9999;
*/
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
cursor_clasificacion_fe_oracle cursor for
select	cla_fe_id, politica_erp_id, prioridad, tipo_operacion_ini, tipo_operacion_fin, id_banco_ini, id_banco_fin, id_chequera_ini, id_chequera_fin,
oracle_segmento1_ini, oracle_segmento1_fin, oracle_segmento2_ini, oracle_segmento2_fin, oracle_segmento3_ini, oracle_segmento3_fin, oracle_segmento4_ini, oracle_segmento4_fin, oracle_segmento5_ini, oracle_segmento5_fin, oracle_segmento6_ini, oracle_segmento6_fin, oracle_segmento7_ini, oracle_segmento7_fin
from	fecxp_politicas_erp
where 	id_tipo_movto in ('A', 'E')
and  	activa_regla = 1
order by prioridad asc;
begin 

--===============================================================================================--
--== empieza real ==--
delete from fecxp_rep_bit_cont_din_aper_e
where e_codigo > 0;
/* commit; */
delete from fecxp_rep_bit_cont_din_aper_d
where e_codigo > 0;
/* commit; */
insert	into fecxp_rep_bit_cont_din_aper_e(
id_segmento, des_segmento, secuencia_pagos_erp, e_codigo, des_empresa, folio_set,
mon_oracle, fecha_aplicacion, tipo_operacion, id_banco, forma_pago,
id_chequera, estatus_movimiento, concepto, beneficiario, importe_set, ap_invoice_amount,
ap_invoice_id, estatus_ultima_apertura, fec_ultima_ejecucion)
select	sf.id_segmento,
sf.des_segmento,
be.secuencia_pagos_erp,
e.e_codigo,
e.des_empresa,
be.folio_set,
m.mon_oracle,
be.fecha_aplicacion,
be.tipo_operacion,
be.id_banco,
be.forma_pago,
be.id_chequera,
be.estatus_movimiento,
be.concepto,
be.beneficiario,
be.importe_set,
bf.ap_invoice_amount,
bf.ap_invoice_id,
case estatus_cont_din_aper when 'C' then 'CUADRADO' when 'P' then 'PENDIENTE' else 'SIN CUADRAR' end,
be.fec_ultima_ejecucion
from	fecxp_bit_cont_din_aper_enc be,
fecxp_bit_cont_din_aper_det bd,
fecxp_bit_cont_din_folios_ap bf,
fecxp_monedas m,
fecxc_empresas e,
fecxc.fecxc_emp_x_segmento es,
fecxc.fecxc_segmentos_flujo sf
where	es.id_segmento not in (11, 14, 15, 17, 18, 20, 22, 26, 6, 13, 25)
and		be.e_codigo >= v_e_codigo_ini
and		be.e_codigo <= v_e_codigo_fin
and		to_timestamp(to_char(be.fecha_aplicacion, 'YYYYMMDD'),'YYYYMMDD') >= v_fecha_ini
and		to_timestamp(to_char(be.fecha_aplicacion, 'YYYYMMDD'),'YYYYMMDD') <= v_fecha_fin
and		e.e_codigo = be.e_codigo
and		m.mon_set = be.moneda
and		m.periodo = (to_char(be.fecha_aplicacion, 'YYYY'))::numeric
and		m.mes = (to_char(be.fecha_aplicacion, 'MM'))::numeric
and		bd.secuencia_pagos_erp = be.secuencia_pagos_erp
and		bd.e_codigo = be.e_codigo
and		bd.fec_ejecucion = be.fec_ultima_ejecucion
and		bf.secuencia_pagos_erp = be.secuencia_pagos_erp
and		bf.e_codigo = be.e_codigo
and		bf.secuencia_cont_din_aper_det = bd.secuencia_cont_din_aper_det
and		es.id_segmento = sf.id_segmento
and		es.e_codigo = e.e_codigo
order by  e.e_codigo,
be.folio_set,
bf.ap_invoice_id;
/* commit; */
insert	into fecxp_rep_bit_cont_din_aper_d(
secuencia_pagos_erp, e_codigo, ap_invoice_id, ap_distribution_line_number, ap_distribution_amount,
tipo_operacion, id_banco, id_chequera,
oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4, oracle_segmento5,
oracle_segmento6, oracle_segmento7, origen_registro)
select	be.secuencia_pagos_erp,
be.e_codigo,
bf.ap_invoice_id,
d.distribution_line_number,
d.amount,
be.tipo_operacion,
be.id_banco,
be.id_chequera,
case when nullif(d.attribute12::text, '') is null then  g.segment1  else oracle.substr(d.attribute12, 1, 3) end ,
case when nullif(d.attribute12::text, '') is null then  g.segment2  else oracle.substr(d.attribute12, instr(d.attribute12, '-', 1, 1) + 1, 2) end ,
case when nullif(d.attribute12::text, '') is null then  g.segment3  else oracle.substr(d.attribute12, instr(d.attribute12, '-', 1, 2) + 1, 3) end ,
case when nullif(d.attribute12::text, '') is null then  g.segment4  else oracle.substr(d.attribute12, instr(d.attribute12, '-', 1, 3) + 1, 6) end ,
case when nullif(d.attribute12::text, '') is null then  g.segment5  else oracle.substr(d.attribute12, instr(d.attribute12, '-', 1, 4) + 1, 8) end ,
case when nullif(d.attribute12::text, '') is null then  g.segment6  else oracle.substr(d.attribute12, instr(d.attribute12, '-', 1, 5) + 1, 3) end ,
case when nullif(d.attribute12::text, '') is null then  g.segment7  else oracle.substr(d.attribute12, instr(d.attribute12, '-', 1, 6) + 1, 1) end ,
case when nullif(d.attribute12::text, '') is null then 'AP' else 'FLEXFIELD' end "origen del registro"
from	fecxp_bit_cont_din_aper_enc be,
fecxp_bit_cont_din_aper_det bd,
fecxp_bit_cont_din_folios_ap bf,
ap_invoice_distributions_all__erp_prod d,
gl_code_combinations__erp_prod g
where	be.e_codigo >= v_e_codigo_ini
and		be.e_codigo <= v_e_codigo_fin
and		be.fecha_aplicacion >= v_fecha_ini
and		be.fecha_aplicacion <= v_fecha_fin
and		bd.secuencia_pagos_erp = be.secuencia_pagos_erp
and		bd.e_codigo = be.e_codigo
and		bd.fec_ejecucion = be.fec_ultima_ejecucion
and		bf.secuencia_pagos_erp = be.secuencia_pagos_erp
and		bf.e_codigo = be.e_codigo
and		bf.secuencia_cont_din_aper_det = bd.secuencia_cont_din_aper_det
and		d.invoice_id = bf.ap_invoice_id
and		g.code_combination_id = d.dist_code_combination_id
order by  be.e_codigo,
be.folio_set,
bf.ap_invoice_id;
/* commit; */
open cursor_clasificacion_fe_oracle;
loop
fetch	cursor_clasificacion_fe_oracle
into	v_cla_fe_id, v_politica_erp_id, v_prioridad, v_tipo_operacion_ini, v_tipo_operacion_fin, v_id_banco_ini, v_id_banco_fin, v_id_chequera_ini, v_id_chequera_fin,
v_ora_s1_ini, v_ora_s1_fin, v_ora_s2_ini, v_ora_s2_fin, v_ora_s3_ini, v_ora_s3_fin, v_ora_s4_ini, v_ora_s4_fin, v_ora_s5_ini, v_ora_s5_fin, v_ora_s6_ini, v_ora_s6_fin, v_ora_s7_ini, v_ora_s7_fin;
exit when not found; /* dmap converted statement start *//* apply on cursor_clasificacion_fe_oracle */
perform dbms_output.put_line( concat('CLAVE: ', v_cla_fe_id)) ;/* dmap converted statement end */
--== clasificacion de cuentas contables erp ==--
update	fecxp_rep_bit_cont_din_aper_d
set		cla_fe_id = v_cla_fe_id
where (tipo_operacion >= coalesce(v_tipo_operacion_ini, 0))
and (tipo_operacion <= coalesce(v_tipo_operacion_fin, 9999))
and (id_banco >= coalesce(v_id_banco_ini, 0))
and (id_banco <= coalesce(v_id_banco_fin, 9999))
and (lpad(id_chequera::text, 20, '0'::text) >= coalesce(lpad(v_id_chequera_ini::text, 20, '0'::text), '00000000000000000000'))
and (lpad(id_chequera::text, 20, '0'::text) <= coalesce(lpad(v_id_chequera_fin::text, 20, '0'::text), '99999999999999999999'))
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
and		coalesce(cla_fe_id, '|') = '|';
/* commit; */
end loop;
close cursor_clasificacion_fe_oracle;/* dmap converted statement start */
update	fecxp_rep_bit_cont_din_aper_d d
set		cla_fe_des =
(
select c.cla_fe_des
from   fecxp_clasificacion_fe c
where  c.cla_fe_id = rtrim(d.cla_fe_id::text)
);/* dmap converted statement end */
/* commit; */
--===============================================================================================--
--== termina real ==--
-- end;
exception
when no_data_found then
raise exception '%', 'NO HAY DATOS NUEVOS.' using errcode = '45000';end;
$body$
language plpgsql
;
