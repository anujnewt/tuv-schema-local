create or replace procedure usrdrc.dercorp_captura_pkg_get_tel_comercial_pr (piiniddomcom integer ,posttelefono inout varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
lsttelefono varchar(32000);
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
select atributo1
into strict   lsttelefono
from   dercorp_add_campo_cat_val_tab
where  1=1
and    id_catalogo_valor = piiniddomcom
;
posttelefono := lsttelefono;end;
$body$
language plpgsql
;
