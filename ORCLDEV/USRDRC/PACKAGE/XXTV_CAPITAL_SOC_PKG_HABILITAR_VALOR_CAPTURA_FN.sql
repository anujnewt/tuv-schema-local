create or replace  function  usrdrc.xxtv_capital_soc_pkg_habilitar_valor_captura_fn (param_id_empresa varchar) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
lincountresplimitada    numeric;
linsinexpresionnominal  numeric;
lincountaplicacapital   numeric;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
/*
select
count(*) into lincountresplimitada
from
dercorp_add_campo_valor_tab emp
inner join dercorp_add_campo_cat_val_tab cat
on to_number(emp.val_valor) = to_number(cat.id_catalogo_valor)
where
emp.id_empresa = param_id_empresa
and
emp.id_add_campo = 517
and
upper(cat.nom_cat_val) like %responsabilidad%limitada%;
select
count(*) into linsinexpresionnominal
from
dercorp_add_campo_valor_tab emp
inner join dercorp_add_campo_cat_val_tab cat
on to_number(emp.val_valor) = to_number(cat.id_catalogo_valor)
where
emp.id_empresa = param_id_empresa
and
emp.id_add_campo = 519
and
upper(cat.nom_cat_val) like %sin%expres%nominal;
*/
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
/*
if lincountresplimitada <> 0 then
return 1;
end if;
if linsinexpresionnominal <> 0 then
return 1;
end if;
*/
if lincountaplicacapital = 0 then
return 1;
end if;
return 0;end;
$body$
language plpgsql
stable;
