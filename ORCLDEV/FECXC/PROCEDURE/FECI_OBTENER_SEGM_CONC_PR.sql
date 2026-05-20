create or replace procedure fecxc."feci_obtener_segm_conc_pr"  () as $body$
declare
-- pgv moved types start
-- pgv moved types end
--feci_cursor refcursor;
feci_cursor refcursor;
begin 

open feci_cursor for
select * from fecxc.feci_segm_conc_cat where ind_estado =1;
dbms_sql.return_result(feci_cursor);end;
$body$
language plpgsql
;
