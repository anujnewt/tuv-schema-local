create or replace procedure fecxc.fecxp_caratula_pkg_carga_caratula ( v_calcular_reales numeric, v_calcular_forecast numeric, v_calcular_presupuesto numeric, v_debug varchar default 'N') as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
if v_calcular_reales = 1 then
if v_debug = 'S' then
perform dbms_output.put_line('CALCULANDO REALES');
end if;
call fecxp_caratula_pkg_reales();
/* commit; */
end if;
if v_calcular_forecast = 1 then
if v_debug = 'S' then
perform dbms_output.put_line('CALCULANDO FORECAST');
end if;
call fecxp_caratula_pkg_forecast();
/* commit; */
end if;
if v_calcular_presupuesto = 1 then
if v_debug = 'S' then
perform dbms_output.put_line('CALCULANDO PRESUPUESTO');
end if;
call fecxp_caratula_pkg_presupuesto();
/* commit; */
end if;end;
$body$
language plpgsql
;
