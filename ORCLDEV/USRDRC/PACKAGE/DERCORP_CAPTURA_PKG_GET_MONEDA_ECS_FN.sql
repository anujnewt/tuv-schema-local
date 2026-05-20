create or replace  function  usrdrc.dercorp_captura_pkg_get_moneda_ecs_fn (param_id_empresa integer) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
val_nominal integer;
moneda_val_nominal varchar(255);
moneda_val_teor_nominal varchar(255);
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
val_nominal := 0;
begin
select
count(*) into strict val_nominal
from
dercorp_add_campo_cat_val_tab
where
id_catalogo     = 9
and
id_catalogo_valor =
(select val_valor
from dercorp_add_campo_valor_tab
where id_empresa = param_id_empresa
and id_add_campo = 519
)
and
nom_cat_val like '%$%' or nom_cat_val like '%Valor Desigual'
;
exception
when others then
--
null;
end;
begin
select
nom_cat_val into strict moneda_val_nominal
from
dercorp_add_campo_cat_val_tab
where
id_catalogo     = 20
and
id_catalogo_valor =
(select val_valor
from dercorp_add_campo_valor_tab
where id_empresa = param_id_empresa
and id_add_campo = 520
);
exception
when others then
--
null;
end;
if length(moneda_val_nominal) > 0 and val_nominal > 0  then
return moneda_val_nominal;
end if;
/*select
nom_cat_val into moneda_val_teor_nominal
from
dercorp_add_campo_cat_val_tab
where
id_catalogo     = 20
and
id_catalogo_valor =
(select val_valor
from dercorp_add_campo_valor_tab
where id_empresa = param_id_empresa
and id_add_campo = 1077
);
if length(moneda_val_teor_nominal) > 0 then
return moneda_val_teor_nominal;
end if;*/
return '';
--return cuc;
/*
select
atributo1 into vtn_value
from
dercorp_add_campo_cat_val_tab
where
id_catalogo     = 9
and
id_catalogo_valor =
(select val_valor
from dercorp_add_campo_valor_tab
where id_empresa = param_id_empresa
and id_add_campo = 1076 -- valor teorico nominal
);
return vtn_value;
*/
end;
$body$
language plpgsql
;
