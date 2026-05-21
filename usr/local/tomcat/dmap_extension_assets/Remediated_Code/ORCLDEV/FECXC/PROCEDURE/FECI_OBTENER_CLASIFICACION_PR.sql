create or replace procedure fecxc."feci_obtener_clasificacion_pr"  ( p_folio_recibo numeric, p_tipo_recibo varchar, 
INOUT feci_cursors refcursor ) 
as $body$
declare
-- pgv moved types start
-- pgv moved types end

begin 

open feci_cursors for
select * from fecxc.feci_clasificacion_tab
where folio_recibo = p_folio_recibo
and tipo_recibo = p_tipo_recibo
and ind_estado = 1;
end;
$body$
language plpgsql
;
