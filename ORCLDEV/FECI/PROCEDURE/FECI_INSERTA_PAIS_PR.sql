create or replace procedure feci."feci_inserta_pais_pr"  ( p_codigo varchar, p_descripcion varchar, p_usuario numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
id_registro numeric;
feci_cursors refcursor;
begin
insert into feci_pais_cat(cod_pais, des_pais ,fec_creacion,
fec_ult_modificacion,id_usuario_creacion , id_usuario_ult_modif, ind_estado)
values (p_codigo, p_descripcion, clock_timestamp(), clock_timestamp(),
p_usuario, 0, 1) returning id_pais into id_registro;
open feci_cursors for
select id_pais from feci_pais_cat where id_pais =  id_registro;
dbms_sql_return_result(feci_cursors);end;
$body$
language plpgsql
;
