create or replace procedure fecxc."feci_inserta_iva_pr"  ( p_codigo varchar, p_descripcion varchar, p_usuario numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
id_registro numeric;
feci_cursors refcursor;
begin 

insert into fecxc.feci_porcentaje_iva_cat(cod_porcentaje_iva, num_valor, fec_creacion,
fec_ult_modificacion,id_usuario_creacion , id_usuario_ult_modif, ind_estado)
values (p_codigo, p_descripcion, clock_timestamp(), clock_timestamp(),
p_usuario, 0, 1) returning id_porcentaje_iva into id_registro;
open feci_cursors for
select id_porcentaje_iva from fecxc.feci_porcentaje_iva_cat where id_porcentaje_iva =  id_registro;
dbms_sql_return_result(feci_cursors);end;
$body$
language plpgsql
;
