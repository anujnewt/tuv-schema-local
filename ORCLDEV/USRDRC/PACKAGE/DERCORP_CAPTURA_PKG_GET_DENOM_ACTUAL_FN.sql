create or replace  function  usrdrc.dercorp_captura_pkg_get_denom_actual_fn (param_id_empresa integer) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
vtn_value varchar(255);
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
select
val_cat_val into strict vtn_value
from
dercorp_add_campo_cat_val_tab
where
id_catalogo     = 1
and
id_catalogo_valor =
(select val_valor
from dercorp_add_campo_valor_tab
where id_empresa = param_id_empresa
and id_add_campo = 500
);
return vtn_value;end;
$body$
language plpgsql
;
