create or replace procedure fecxc."fecxp_exec_det_real_erp_pr"  () as $body$
declare
-- pgv moved types start
-- pgv moved types end
err_code    numeric;
err_msg     varchar(255);
fecha_ini   varchar(8);
begin 

select oracle.substr(estatus_ppto_sig_ejecucion, 42, 8)
--se obtiena la fecha incicial, como es automatico la fecha final siempre sera el sysdate
into strict fecha_ini
from fecxc.fecxp_ppto_extraccion_params
where proceso_id = 11;
call fecxc.fecxp_base_iva_intermpresas (to_timestamp(fecha_ini,'DDMMYYYY'), clock_timestamp());/* dmap converted statement start */
update fecxc.fecxp_ppto_extraccion_params
set atributo2 =
oracle. concat(substr(coalesce(atributo2, ''), 1, 190), 'Aperturacion CXC termino con Exito', to_char(clock_timestamp(),'DD-MM-YYYY')
) where proceso_id = 11;/* dmap converted statement end */
exception
when others
then
err_code := sqlstate;
err_msg := oracle.substr(sqlerrm, 1, 100);/* dmap converted statement start */
update fecxc.fecxp_ppto_extraccion_params
set atributo2 =
oracle. concat(substr(coalesce(atributo2, ''), 1, 100), 'Aperturacion CXC termino con ERROR'
, err_msg
) where proceso_id = 11;/* dmap converted statement end */end;
$body$
language plpgsql
;
