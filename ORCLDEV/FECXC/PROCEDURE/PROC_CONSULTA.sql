create or replace procedure fecxc."proc_consulta"  () as $body$
declare
-- pgv moved types start
-- pgv moved types end
cursor_resultados cursor for
select folio_recibo, tipo_recibo
from fecxc.feci_recibos_vw
where nullif(tipo_cambio_origen::text, '') is null and tipo_recibo = 'BATCH';
v_valor1 fecxc.feci_recibos_vw.folio_recibo%type;
v_valor2 fecxc.feci_recibos_vw.tipo_recibo%type;
begin 

for registro in cursor_resultados loop
v_valor1 := registro.folio_recibo;
v_valor2 := registro.tipo_recibo;/* dmap converted statement start */
perform dbms_output.put_line( concat('Valor de FOLIO_RECIBO: ', v_valor1)) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('Valor de TIPO_RECIBO: ', v_valor2)) ;/* dmap converted statement end */
-- llama al procedimiento proc_accion con los valores del registro
--proc_accion(v_valor1, v_valor2);
end loop;end;
$body$
language plpgsql
;
