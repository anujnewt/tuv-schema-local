create or replace  function  usrdrc.dercorp_captura_pkg_get_valor_teorico_nominal_fn (param_id_empresa integer) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
vtn_value varchar(255);
var_val_valor   varchar(254);
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
select
--atributo1 into vtn_value
val_cat_val into strict vtn_value
from
dercorp_add_campo_cat_val_tab
where
id_catalogo     = 9
and
id_catalogo_valor =
(select val_valor
from dercorp_add_campo_valor_tab
where id_empresa = param_id_empresa
and id_add_campo = 519--1076 -- se cambio de valor teorico nominal a valor nominal se deja el mismo nombre del paquete
);
var_val_valor := replace(vtn_value, '$', ',');
var_val_valor := replace(var_val_valor, ',', '');
return var_val_valor;end;
$body$
language plpgsql
;
