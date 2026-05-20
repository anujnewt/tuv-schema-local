create or replace procedure fecxc."feci_obtener_tipo_cambio_rcb_man_pr"  ( p_fecha_tc varchar, p_codigo_mon varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
feci_cursor             refcursor;
select_fec_ori          varchar(250);
select_fec_opc          varchar(250);
select_fec_alt          varchar(250);
select_fec_dol          varchar(250);
select_fec_dol_opc      varchar(250);
select_fec_dol_alt      varchar(250);
begin 

begin
select fec_fecha_tc into strict select_fec_opc
from fecxc.feci_tipo_cambio_cat
where fec_fecha_tc = p_fecha_tc
and cod_moneda = p_codigo_mon
fetch next 1 rows only;
perform_fec_ori := select_fec_opc;
select fec_fecha_tc into strict select_fec_dol_opc
from fecxc.feci_tipo_cambio_cat
where fec_fecha_tc = p_fecha_tc
and cod_moneda = 'USD'
fetch next 1 rows only;
perform_fec_dol := select_fec_dol_opc;/* dmap converted statement start */
exception
when no_data_found then
perform dbms_output.put_line( concat('SELECT_FEC_OPC ', select_fec_opc)) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('SELECT_FEC_DOL_OPC ', select_fec_dol_opc)) ;/* dmap converted statement end */
end;
begin
if nullif(select_fec_ori::text, '') is null then
select fec_fecha_tc into strict select_fec_alt
from fecxc.feci_tipo_cambio_cat
where fec_fecha_tc = (select max(fec_fecha_tc) from fecxc.feci_tipo_cambio_cat)
and cod_moneda = p_codigo_mon
fetch next 1 rows only;
perform_fec_ori := select_fec_alt;/* dmap converted statement start */
perform dbms_output.put_line( concat('SELECT_FEC_ALT ', select_fec_alt)) ;/* dmap converted statement end */
end if;
if nullif(select_fec_dol::text, '') is null then
select fec_fecha_tc into strict select_fec_dol_alt
from fecxc.feci_tipo_cambio_cat
where fec_fecha_tc = (select max(fec_fecha_tc) from fecxc.feci_tipo_cambio_cat where cod_moneda = 'USD')
and cod_moneda = 'USD'
fetch next 1 rows only;
perform_fec_dol := select_fec_dol_alt;/* dmap converted statement start */
perform dbms_output.put_line( concat('SELECT_FEC_DOL_ALT ', select_fec_dol_alt)) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
exception
when no_data_found then
perform dbms_output.put_line( concat('SELECT_FEC_ALT ', select_fec_alt)) ;/* dmap converted statement end */
end;
open feci_cursor for
select cod_moneda as "codigomoneda", fec_fecha_tc as "fechatcorigen",
num_valor as "tipocambioorigen", null, null
from fecxc.feci_tipo_cambio_cat
where fec_fecha_tc = select_fec_ori
and cod_moneda = p_codigo_mon
union
select null, null, null, fec_fecha_tc as "fechatcdolar",
num_valor as "tipocambiodolar"
from fecxc.feci_tipo_cambio_cat
where fec_fecha_tc = select_fec_dol
and cod_moneda = 'USD'
fetch next 1 rows only;
dbms_sql.return_result(feci_cursor);end;
$body$
language plpgsql
;
