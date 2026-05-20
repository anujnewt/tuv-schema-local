create or replace procedure fecxc."feci_obtener_rol_pr"  () as $body$
declare
-- pgv moved types start
-- pgv moved types end
--feci_cursor refcursor;
feci_cursor refcursor;
begin 

open feci_cursor for
select id_rol,nom_rol from feci_rol_tab where ind_estado =1;
dbms_sql.return_result(feci_cursor);end;
$body$
language plpgsql
;
