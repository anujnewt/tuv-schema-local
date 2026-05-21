create or replace procedure fecxc."feci_obtener_clase_cliente_pr"  (INOUT feci_cursors refcursor) as $body$
declare
-- pgv moved types start
-- pgv moved types end
--feci_cursors refcursor;

begin 

open feci_cursors for
select * from fecxc.feci_clase_cliente_cat 
where  ind_estado =1;
end;
$body$
language plpgsql
;
