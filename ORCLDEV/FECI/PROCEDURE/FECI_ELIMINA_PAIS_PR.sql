create or replace procedure feci."feci_elimina_pais_pr"  ( p_cod varchar, p_usuario numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
feci_cursors refcursor;
begin
update feci_pais_cat  pais
set ind_estado = 0,
id_usuario_ult_modif = p_usuario,
fec_ult_modificacion = clock_timestamp()
where pais.cod_pais = p_cod
and not exists (
select 1
from feci_clasificacion_tab cls
where cls.cod_pais = pais.cod_pais
);
open feci_cursors for
select count(cod_pais) from feci_clasificacion_tab where cod_pais =  p_cod;
dbms_sql_return_result(feci_cursors);end;
$body$
language plpgsql
;
