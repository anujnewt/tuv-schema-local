create or replace procedure labprod.interfaces_validaemp ( emp_tipmov varchar, emp_submov varchar, estatus inout varchar, code inout varchar, message inout varchar, fecha inout timestamp(0) ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
valida numeric := 0;
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
/* select api_movimientosper.emp_tipmov,api_movimientosper.emp_submov into validaemp.emp_tipmov,validaemp.emp_submov
from labprod.api_movimientosper where api_movimientosper.id_transaccion = validaemp.id_transaccion and  api_movimientosper.code = ok;
*/
code:='1';
fecha := clock_timestamp();
if validaemp.emp_tipmov = '1' and  validaemp.emp_submov = '11' then valida := 1; end if;
if validaemp.emp_tipmov = '1' and  validaemp.emp_submov = '45' then valida := 1; end if;
if validaemp.emp_tipmov = '1' and validaemp.emp_submov = '12' then valida := 1; end if;
if validaemp.emp_tipmov = '1' and validaemp.emp_submov = '13' then valida := 1; end if;
if validaemp.emp_tipmov = '1' and validaemp.emp_submov = '14' then valida := 1; end if;
if validaemp.emp_tipmov = '1' and validaemp.emp_submov = '15' then valida := 1; end if;
if validaemp.emp_tipmov = '1' and validaemp.emp_submov = '16' then valida := 1; end if;
if validaemp.emp_tipmov = '1' and validaemp.emp_submov = '19' then valida := 1; end if;
if validaemp.emp_tipmov = '1' and validaemp.emp_submov = 'AL' then valida := 1; end if;
if validaemp.emp_tipmov = '2' and  validaemp.emp_submov = '1' then valida := 1; end if;
if validaemp.emp_tipmov = '2' and validaemp.emp_submov = '2'  then valida := 1; end if;
if validaemp.emp_tipmov = '2' and validaemp.emp_submov = '3'  then valida := 1; end if;
if validaemp.emp_tipmov = '2' and validaemp.emp_submov = '4'  then valida := 1; end if;
if validaemp.emp_tipmov = '2' and validaemp.emp_submov = '5'  then valida := 1; end if;
if validaemp.emp_tipmov = '2' and validaemp.emp_submov = '7'  then valida := 1; end if;
if validaemp.emp_tipmov = '2' and validaemp.emp_submov = '8'  then valida := 1; end if;
if validaemp.emp_tipmov = '2' and validaemp.emp_submov = '9'  then valida := 1; end if;
if validaemp.emp_tipmov = '2' and validaemp.emp_submov = '10' then valida := 1; end if;
if validaemp.emp_tipmov = '2' and validaemp.emp_submov = '11' then valida := 1; end if;
if validaemp.emp_tipmov = '2' and validaemp.emp_submov = '12' then valida := 1; end if;
if validaemp.emp_tipmov = '2' and validaemp.emp_submov = '13' then valida := 1; end if;
if validaemp.emp_tipmov = '2' and validaemp.emp_submov = '14' then valida := 1; end if;
if validaemp.emp_tipmov = '2' and validaemp.emp_submov = '15' then valida := 1; end if;
if validaemp.emp_tipmov = '2' and validaemp.emp_submov = '16' then valida := 1; end if;
if validaemp.emp_tipmov = '2' and validaemp.emp_submov = '17' then valida := 1; end if;
if validaemp.emp_tipmov = '2' and validaemp.emp_submov = '21' then valida := 1; end if;
if validaemp.emp_tipmov = '2' and validaemp.emp_submov = 'AL' then valida := 1; end if;
if validaemp.emp_tipmov = '5' and validaemp.emp_submov = '21' then valida := 1; end if;
if validaemp.emp_tipmov = '5' and validaemp.emp_submov = '22' then valida := 1; end if;
if validaemp.emp_tipmov = '5' and validaemp.emp_submov = '24' then valida := 1; end if;
if validaemp.emp_tipmov = '5' and validaemp.emp_submov = '26' then valida := 1; end if;
if validaemp.emp_tipmov = '5' and validaemp.emp_submov = '27' then valida := 1; end if;
if validaemp.emp_tipmov = '5' and validaemp.emp_submov = '36' then valida := 1; end if;
if validaemp.emp_tipmov = '5' and validaemp.emp_submov = '53' then valida := 1; end if;
if validaemp.emp_tipmov = '6' and validaemp.emp_submov = '11' then valida := 1; end if;
if validaemp.emp_tipmov = '6' and validaemp.emp_submov = '12' then valida := 1; end if;
if validaemp.emp_tipmov = '6' and validaemp.emp_submov = '13' then valida := 1; end if;
if validaemp.emp_tipmov = '6' and validaemp.emp_submov = '14' then valida := 1; end if;
if validaemp.emp_tipmov = '6' and validaemp.emp_submov = '15' then valida := 1; end if;
if validaemp.emp_tipmov = '6' and validaemp.emp_submov = '16' then valida := 1; end if;
if validaemp.emp_tipmov = '6' and validaemp.emp_submov = '19' then valida := 1; end if;
if validaemp.emp_tipmov = '6' and validaemp.emp_submov = '44' then valida := 1; end if;
if validaemp.emp_tipmov = '6' and validaemp.emp_submov = 'AL' then valida := 1; end if;
if validaemp.emp_tipmov = '35' and validaemp.emp_submov = '35' then valida :=1; end if;
if validaemp.emp_tipmov = '36' and validaemp.emp_submov = '36' then valida := 1; end if;
if validaemp.emp_tipmov = '36' and validaemp.emp_submov = '22' then valida := 1; end if;
if validaemp.emp_tipmov = '36' and validaemp.emp_submov = '35' then valida := 1; end if;
if valida = 0  then
estatus := 'ERROR';
code := '3';/* dmap converted statement start */
message :=  concat('El Movimiento No existe: EMP_TIPMOV [', validaemp.emp_tipmov , '] EMP_SUBMOV [', validaemp.emp_submov , ']') ;/* dmap converted statement end */
/* update labprod.api_movimientosper
set api_movimientosper.message = el movimiento no existe: emp_tipmov [|| validaemp.emp_tipmov ||] emp_submov [|| validaemp.emp_submov ||],
api_movimientosper.estatus = 2,
api_movimientosper.code=error,
api_movimientosper.fecha_proc = sysdate
where api_movimientosper.id_transaccion = validaemp.id_transaccion;
/* commit; */
*/
end if;
exception
when no_data_found then
estatus := 'ERROR';
code := '3';
message := 'ID_TRANSACCION EN  API_MOVIMIENTOSPER NO EXISTE ';
when too_many_rows then
estatus := 'ERROR';
code := '3';
message := 'ID_TRANSACCION EN  API_MOVIMIENTOSPER DUPLICADO';
/*update  labprod.api_movimientosper set estatus = 2,code = error, message = id_transaccion en  api_movimientosper duplicado
where api_movimientosper.id_transaccion = validaemp.id_transaccion  and estatus = 1 ;*/
end;
$body$
language plpgsql
;
