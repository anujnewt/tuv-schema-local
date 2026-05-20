create or replace procedure feci."feci_inserta_moneda_pr"  ( p_codigo varchar, p_descripcion varchar, p_usuario numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
id_registro numeric;
feci_cursors refcursor;
begin
insert into feci_moneda_cat(cod_moneda, des_moneda, fec_creacion,
fec_ult_modificacion,id_usuario_creacion , id_usuario_ult_modif, ind_estado)
values (p_codigo, p_descripcion, clock_timestamp(), clock_timestamp(),
p_usuario, 0, 1) returning id_moneda into id_registro;
open feci_cursors for
select id_moneda from feci_moneda_cat where id_moneda =  id_registro;
dbms_sql_return_result(feci_cursors);end;
$body$
language plpgsql
;
