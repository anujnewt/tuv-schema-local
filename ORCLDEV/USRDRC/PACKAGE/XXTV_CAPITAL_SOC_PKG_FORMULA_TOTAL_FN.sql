create or replace  function  usrdrc.xxtv_capital_soc_pkg_formula_total_fn (param_id_empresa varchar) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
lincountresplimitada    numeric;
linsinexpresionnominal  numeric;
lincountaplicacapital   numeric;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
select
count(*) into strict lincountresplimitada
from
dercorp_add_campo_valor_tab emp
inner join dercorp_add_campo_cat_val_tab cat
on (emp.val_valor)::numeric  = (cat.id_catalogo_valor)::numeric
where
emp.id_empresa = param_id_empresa
and
emp.id_add_campo = 517
and
upper(cat.nom_cat_val) like '%RESPONSABILIDAD%LIMITADA%';
select
count(*) into strict linsinexpresionnominal
from
dercorp_add_campo_valor_tab emp
inner join dercorp_add_campo_cat_val_tab cat
on (emp.val_valor)::numeric  = (cat.id_catalogo_valor)::numeric
where
emp.id_empresa = param_id_empresa
and
emp.id_add_campo = 519
and (upper(cat.nom_cat_val) like '%SIN%EXPRES%NOMINAL'
or
upper(cat.nom_cat_val) like '%VALOR%DESIGUAL%'
or
upper(cat.nom_cat_val) like '%N/A%'
)
;
select
count(*) into strict lincountaplicacapital
from dercorp_add_campo_valor_tab
where
id_empresa = param_id_empresa
and (
id_add_campo = 1030 -- aplica capital fijo
or
id_add_campo = 1031 -- aplica capital variable
);
if lincountaplicacapital = 0 then
return 'NO_APLICA';
end if;
if lincountresplimitada <> 0 then
return 'ACF_ACV';
end if;
if linsinexpresionnominal <> 0 then
return 'ACF_ACV';
--return valorteoriconominal;
end if;
return 'ACF_ACV_VN';end;
$body$
language plpgsql
stable;
