create or replace procedure fecxc."feci_obtener_pais_pr"  (INOUT feci_cursor refcursor) as $body$
declare
-- pgv moved types start
-- pgv moved types end
--feci_cursor refcursor;

begin 

open feci_cursor for
select * from fecxc.feci_pais_cat 
where ind_estado =1;
end;
$body$
language plpgsql
;
