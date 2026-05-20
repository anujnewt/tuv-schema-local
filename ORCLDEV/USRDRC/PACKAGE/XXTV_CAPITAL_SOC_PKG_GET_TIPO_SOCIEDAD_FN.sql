create or replace  function  usrdrc.xxtv_capital_soc_pkg_get_tipo_sociedad_fn (param_id_empresa numeric) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
lincountasoccivil    numeric := 0;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
select
count(*) into strict lincountasoccivil
from
dercorp_add_campo_valor_tab emp
inner join dercorp_add_campo_cat_val_tab cat
on (emp.val_valor)::numeric  = (cat.id_catalogo_valor)::numeric
where
emp.id_empresa = param_id_empresa
and
emp.id_add_campo = 517
and (upper(cat.nom_cat_val) like '%ASOCIACION CIVIL%' or upper(cat.nom_cat_val) like '%NOT%FOR%PROFIT%CORPORATION%');
return lincountasoccivil;end;
$body$
language plpgsql
stable;
