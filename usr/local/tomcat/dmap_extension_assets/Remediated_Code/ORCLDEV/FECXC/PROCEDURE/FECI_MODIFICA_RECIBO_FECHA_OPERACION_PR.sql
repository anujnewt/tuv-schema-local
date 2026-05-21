create or replace procedure fecxc."feci_modifica_recibo_fecha_operacion_pr"  ( p_folio numeric, p_fecha_tc timestamp(0), p_codigo_mon varchar, p_codigo_est varchar, p_tipo_recibo varchar ) as $body$
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
select_num_tc_dol       varchar(250);
select_num_base         numeric := 1.01;
perform_fec_ori         varchar(250);
perform_fec_dol         varchar(250);
begin 

begin
select fec_fecha_tc into strict select_fec_opc
from fecxc.feci_tipo_cambio_cat
where fec_fecha_tc = to_timestamp(p_fecha_tc,'dd/mm/yyyy')
--and cod_moneda = p_codigo_mon
fetch next 1 rows only;
perform_fec_ori := select_fec_opc;
select fec_fecha_tc into strict select_fec_dol_opc
from fecxc.feci_tipo_cambio_cat
where fec_fecha_tc = to_timestamp(p_fecha_tc,'dd/mm/yyyy')
--and cod_moneda = 'USD'
fetch next 1 rows only;
perform_fec_dol := select_fec_dol_opc;/* dmap converted statement start */
exception
when no_data_found then
RAISE NOTICE 'SELECT_FEC_OPC %', select_fec_opc;/* dmap converted statement end *//* dmap converted statement start */
RAISE NOTICE 'SELECT_FEC_DOL_OPC %', select_fec_dol_opc;/* dmap converted statement end */
end;
if nullif(select_fec_ori::text, '') is null then
select fec_fecha_tc into strict select_fec_alt
from fecxc.feci_tipo_cambio_cat
where fec_fecha_tc = (select max(fec_fecha_tc) from fecxc.feci_tipo_cambio_cat)
--and cod_moneda = p_codigo_mon
fetch next 1 rows only;
perform_fec_ori := select_fec_alt;/* dmap converted statement start */
RAISE NOTICE 'SELECT_FEC_ALT %', select_fec_alt;/* dmap converted statement end */
end if;
if p_tipo_recibo = 'MANUAL' and p_codigo_est = 'PEND' then
update fecxc.feci_recibo_manual_tab
set fec_operativa = p_fecha_tc,
id_usuario_ult_modif = 1
where folio_recibo_manual = p_folio;
end if;
if p_tipo_recibo = 'MANUAL' then
update fecxc.feci_recibo_manual_tab
set fec_operativa = p_fecha_tc,
id_usuario_ult_modif = 1
where folio_recibo_manual = p_folio;
end if;
if p_tipo_recibo = 'BATCH' and p_codigo_est = 'PEND' then
update fecxc.feci_recibo_tab
set fec_operativa = p_fecha_tc,
id_usuario_ult_modif = 1
where folio_recibo = p_folio;
end if;
if p_tipo_recibo = 'BATCH' then
update fecxc.feci_recibo_tab
set fec_operativa = p_fecha_tc,
id_usuario_ult_modif = 1
where folio_recibo = p_folio;
end if;end;
$body$
language plpgsql
;
