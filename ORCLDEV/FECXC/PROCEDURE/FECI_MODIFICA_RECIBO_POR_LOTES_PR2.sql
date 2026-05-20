create or replace procedure fecxc."feci_modifica_recibo_por_lotes_pr2"  () as $body$
declare
-- pgv moved types end
feci_cursor             refcursor;
select_fec_ori          timestamp(0);
select_fec_ori_opc      timestamp(0);
select_fec_dol          timestamp(0);
select_fec_dol_opc      timestamp(0);
select_val_ori          numeric;
select_val_ori_opc      numeric;
select_val_dol          numeric;
select_val_dol_opc      numeric;
begin 

declare
/*+pgv moved  types star*/ recibo cursor for
select *
from fecxc.feci_recibo_tab
where nullif(fec_tc_origen::text, '') is null and nullif(tipo_cambio_dolar::text, '') is null
and folio_recibo in (85990393, 86057494);/* dmap converted statement start */
begin
for r in recibo loop
perform dbms_output.put_line( concat(r.fec_tc_origen, ' ', r.tipo_cambio_dolar)) ;/* dmap converted statement end */
select tc.fec_fecha_tc, tc.num_valor into strict select_fec_ori_opc, select_val_ori_opc
from fecxc.feci_tipo_cambio_cat tc
where tc.fec_fecha_tc = (select max(fec_fecha_tc) from fecxc.feci_tipo_cambio_cat)
and tc.cod_moneda = r.cod_moneda;
perform_fec_ori := select_fec_ori_opc;
perform_val_ori := select_val_ori_opc;
update fecxc.feci_recibo_tab
set fec_tc_origen = select_fec_ori,
tipo_cambio_origen = select_val_ori
where nullif(fec_tc_origen::text, '') is null and nullif(tipo_cambio_origen::text, '') is null
and folio_recibo in (85990393, 86057494);
end loop;
end;
select tc.fec_fecha_tc, tc.num_valor into strict select_fec_dol_opc, select_val_dol_opc
from fecxc.feci_tipo_cambio_cat tc
where tc.fec_fecha_tc = (select max(fec_fecha_tc) from fecxc.feci_tipo_cambio_cat)
and tc.cod_moneda = 'USD';
perform_fec_dol := select_fec_dol_opc;
perform_val_dol := select_val_dol_opc;
update fecxc.feci_recibo_tab
set fec_tc_dolar = select_fec_dol,
tipo_cambio_dolar = select_val_dol
where nullif(fec_tc_dolar::text, '') is null and nullif(tipo_cambio_dolar::text, '') is null
and folio_recibo in (85990393, 86057494);
exception
when no_data_found then
perform dbms_output.put_line('SELECT_FEC_OPC ');
end;
$body$
language plpgsql
;
