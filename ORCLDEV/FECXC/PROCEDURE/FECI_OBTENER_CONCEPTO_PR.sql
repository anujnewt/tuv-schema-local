create or replace procedure fecxc."feci_obtener_concepto_pr"  () as $body$
declare
-- pgv moved types start
-- pgv moved types end
--feci_cursors refcursor;
feci_cursors refcursor;
begin 

open feci_cursors for
select * from fecxc.feci_concepto_cat where  ind_estado =1;
dbms_sql.return_result(feci_cursors);end;
$body$
language plpgsql
;
