create or replace procedure fecxc."feci_modifica_tipo_cambio_recibo_masivo_pr"  (p_usuario numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
cursor_resultados cursor for
select folio_recibo, tipo_recibo
from fecxc.feci_recibos_vw
where nullif(tipo_cambio_origen::text, '') is null and tipo_recibo = 'BATCH';
v_folio fecxc.feci_recibos_vw.folio_recibo%type;
v_tipo fecxc.feci_recibos_vw.tipo_recibo%type;
begin 

for registro in cursor_resultados loop
v_folio := registro.folio_recibo;
v_tipo := registro.tipo_recibo;/* dmap converted statement start */
perform dbms_output.put_line( concat('Valor de FOLIO_RECIBO: ', v_folio)) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('Valor de TIPO_RECIBO: ', v_tipo)) ;/* dmap converted statement end */
-- llama al procedimiento proc_accion con los valores del registro
call fecxc.feci_modifica_tipo_cambio_recibo_pr (v_folio, v_tipo, p_usuario);
end loop;end;
$body$
language plpgsql
;
