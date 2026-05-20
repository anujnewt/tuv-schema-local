create or replace procedure fecxc."fecxp_mov_complemtos"  () as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_fecha       timestamp(0) := to_timestamp(clock_timestamp(),'DD-MM-YYYY');
v_fecha_eje   varchar(8);
v_fin_a integer:=(to_char(clock_timestamp(),'YYYY'))::numeric;
v_fin_m integer;
v_fin_d integer;
v_fecha_ini   varchar(8);
v_ini_a integer:=(to_char(clock_timestamp(),'YYYY'))::numeric;
v_ini_m integer;
v_ini_d integer;
v_fecha_fin   varchar(8);
v_eje_a integer:=(to_char(clock_timestamp(),'YYYY'))::numeric;
v_eje_m integer;
v_eje_d integer;
begin 

-- parametros de ejecucion.
select diaeje, meseje,  diaini,  mesini,  diafin,  mesfin
into strict  v_eje_d, v_eje_m, v_ini_d, v_ini_m, v_fin_d, v_fin_m
from fecxc.fecxp_param_ext_mc;
v_eje_m := (to_char(clock_timestamp(),'MM'))::numeric;-- + v_eje_m;         --mes ejecucion  .
v_eje_a :=(to_char(clock_timestamp(),'YYYY'))::numeric;
v_ini_m := (to_char(clock_timestamp(),'MM'))::numeric  + v_ini_m;    --mes inicio
v_ini_a := (to_char(clock_timestamp(),'YYYY'))::numeric  + case when v_eje_m - v_ini_m < 0 then -1 else 0 end;
v_fin_m := (to_char(clock_timestamp(),'MM'))::numeric  + v_fin_m;         --mes fin
v_fin_a :=(to_char(clock_timestamp(),'YYYY'))::numeric  + case when v_eje_m - v_fin_m < 0 then -1 else 0 end;
-- fecha de ejecucion de proc.
v_fecha_eje := to_char(v_eje_a) || case when v_eje_m < 10 then '0' else '' end || to_char(v_eje_m) || case when v_eje_d < 10 then '0' else '' end || to_char(v_eje_d);
-- fecha de inicio de extraccion
v_fecha_ini := to_char(v_ini_a) || case when v_ini_m < 10 then '0' else '' end || to_char(v_ini_m) || case when v_ini_d < 10 then '0' else '' end || to_char(v_ini_d);
-- fecha de final de extraccion
v_fecha_fin := to_char(v_fin_a) || case when v_fin_m < 10 then '0' else '' end || to_char(v_fin_m) || case when v_fin_d < 10 then '0' else '' end || to_char(v_fin_d);
-- v_fecha_eje := to_timestamp(v_fecha_eje_str,'YYYYMMDD');
if v_fecha_eje = to_char(clock_timestamp(),'YYYYMMDD') then
insert into fecxp_mov_comple_opera_erp(secuencia_mc_erp, origen_poliza, je_header_id, moneda,
fecha_efectiva, importe_linea, monto_deb_mon_orig, monto_cre_mon_orig,
monto_deb_mon_conv, monto_cre_mon_conv, libro_id, code_combination_id,
oracle_segmento1, oracle_segmento2, oracle_segmento3, oracle_segmento4,
oracle_segmento5, oracle_segmento6, oracle_segmento7)
select nextval('secuencia_mc_erp'),
upper(jh.je_source),		 				-- origen,
jh.je_header_id,			 		 		-- header_id,
jh.currency_code,							-- moneda,
jh.default_effective_date,					-- fecha_efectiva,
coalesce(jh.running_total_accounted_dr,0),		-- importe_linea, -- checar en la vista: header_run_total_accounted_dr
coalesce(jl.entered_dr,0),						-- monto_deb_mon_orig, -- moneda origen
coalesce(jl.entered_cr,0),						-- monto_cre_mon_orig, -- moneda origen
coalesce(jl.accounted_dr,0),						-- monto_deb_mon_conv, -- convetido
coalesce(jl.accounted_cr,0),						-- monto_cre_mon_conv, -- convetido
jh.set_of_books_id,  						-- libro_id,
g.code_combination_id,
g.segment1,
g.segment2,
g.segment3,
g.segment4,
g.segment5,
g.segment6,
g.segment7
from fecxp_gl_je_sources js,
gl_je_headers__erp_prod jh,
gl_je_lines__erp_prod jl,
gl_code_combinations__erp_prod g
where g.summary_flag            = 'N'
and  g.enabled_flag          	  = 'Y'
and  g.chart_of_accounts_id  	  = 101 -- 101 es para gl libro operativo
and  jh.currency_code       	 != 'STAT'
and  jh.status            	  = 'P'
and  jh.actual_flag        	  = 'A'
and  js.flag_origen_mc          = 1
and  to_char(jh.default_effective_date,'YYYYMMDD')
between v_fecha_ini and v_fecha_fin
and  js.je_source_name          = jh.je_source
and  jh.set_of_books_id         = jl.set_of_books_id
and  jh.je_header_id            = jl.je_header_id
and  g.code_combination_id      = jl.code_combination_id;
end if;
exception
when no_data_found then
raise exception '%', 'No hay datos nuevos.' using errcode = '45000';end;
$body$
language plpgsql
;
