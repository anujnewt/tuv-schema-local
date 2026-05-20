create or replace procedure fecxc."xxchk_asociar_folio_acheque"  ( p_id_sec_cheque numeric, p_usuario varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_count       numeric;
v_id_estado_cheque    numeric;
xxchk_row record;
begin 

select count(1)
into strict v_count
from xxchk_cheques_all
where id_cheque_sel =p_id_sec_cheque;
if v_count > 0 then
begin
select count(1)
into strict v_count
from xxchk_cheques_all
where id_cheque_sel =p_id_sec_cheque
group by id_tipo_operacion_set, referencia_cliente, moneda
having count(1) > 1;
exception
when no_data_found then
v_count:=0;
end;
if v_count= 0 then
for xxchk_row in (select a.e_codigo, a.no_folio_det, a.id_status_mov, a.id_tipo_operacion_set,
a.importe, a.moneda, a.referencia_cliente, b.no_cheque
from xxchk_cheques_all a, xxchk_captura_cheques b
where a.id_cheque_sel = p_id_sec_cheque
and b.id_sec_cheque = p_id_sec_cheque) loop
update xxchk_cheques_all up_table
set procesado = 1
where e_codigo = xxchk_row.e_codigo
and no_folio_det = xxchk_row.no_folio_det
and id_status_mov = xxchk_row.id_status_mov;
begin
select id_estado_cheque
into strict v_id_estado_cheque
from xxchk_mapeo_de_estados
where id_tipo_operacion_set = xxchk_row.id_tipo_operacion_set;
exception
when no_data_found then
raise exception '%', 'NO EXISTE LA RELACION DE OPERACION DEL SET VERSUS ESTADO DEL CHEQUE. FAVOR CREARLA Y VOLVER A APLICAR EL PROCESO' using errcode = '45000';
end;
insert into xxchk_cheq_all_hist(
e_codigo, no_cheque, id_sec_cheque,
no_folio_det, date_created, modified_by,
tipo_cheq, referencia_cliente, id_tipo_operacion_set,
procesado, id_estado_cheque)
values (xxchk_row.e_codigo, xxchk_row.no_cheque, p_id_sec_cheque,
xxchk_row.no_folio_det, clock_timestamp(), p_usuario,
'MANUAL', xxchk_row.referencia_cliente, xxchk_row.id_tipo_operacion_set,
1, v_id_estado_cheque);
end loop;
update xxchk_captura_cheques up_table
set procesado = 1, last_modified_date= clock_timestamp(), id_estado_cheque = v_id_estado_cheque
where id_sec_cheque = p_id_sec_cheque;
else
raise exception '%', 'POR FAVOR SELECCIONE SOLO UN REGISTRO POR TIPO DE OPERACION, MONTO Y REFERENCIA.' using errcode = '45000';
end if;
else
raise exception '%', 'NO SE HA ASOCIADO NINGUN FOLIO, POR FAVOR SELECCIONE UNO Y VUELVA A APLICAR ESTE PROCESO.' using errcode = '45000';
end if;
/* commit; */
end;
$body$
language plpgsql
;
