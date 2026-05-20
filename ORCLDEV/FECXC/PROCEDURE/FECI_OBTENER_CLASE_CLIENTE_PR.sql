create or replace procedure fecxc."feci_obtener_clase_cliente_pr"  () as $body$
declare
-- pgv moved types start
-- pgv moved types end
--feci_cursors refcursor;
feci_cursors refcursor;
begin 

open feci_cursors for
select * from fecxc.feci_clase_cliente_cat where  ind_estado =1;
dbms_sql.return_result(feci_cursors);end;
$body$
language plpgsql
;
