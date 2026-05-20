create or replace procedure fecxc."feci_inserta_tipo_cambio_pr"  ( p_fecha timestamp(0), p_codigo varchar, p_valor numeric, p_usuario numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
id_registro numeric;
feci_cursors refcursor;
begin 

insert into fecxc.feci_tipo_cambio_cat(fec_fecha_tc,cod_moneda, num_valor, fec_creacion,
fec_ult_modificacion,id_usuario_creacion , id_usuario_ult_modif, ind_estado)
values (p_fecha, p_codigo,p_valor, clock_timestamp(), clock_timestamp(),
p_usuario, 0, 1) returning id_tipo_cambio into id_registro;
open feci_cursors for
select id_tipo_cambio from fecxc.feci_tipo_cambio_cat where id_tipo_cambio =  id_registro;
dbms_sql_return_result(feci_cursors);end;
$body$
language plpgsql
;
