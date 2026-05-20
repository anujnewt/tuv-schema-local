create or replace  function  usrdrc.xxtv_capital_soc_pkg_sociedad_fn (param_id_empresa numeric) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
lincountasoccivil    numeric := 0;
lincountsderl        numeric := 0;
lincountsderldecv    numeric := 0;
lincountsa           numeric := 0;
lincountsadecv       numeric := 0;
lincountsab          numeric := 0;
lincountsabdecv      numeric := 0;
lincountsc           numeric := 0;
lincountllc          numeric := 0;
lincountslu          numeric := 0;
lincountsac          numeric := 0;
lincountsau          numeric := 0;
lincountltd          numeric := 0;
lincountsl           numeric := 0;
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
and
upper(cat.nom_cat_val) like '%ASOCIACION%CIVIL';
select
count(*) into strict lincountslu
from
dercorp_add_campo_valor_tab emp
inner join dercorp_add_campo_cat_val_tab cat
on (emp.val_valor)::numeric  = (cat.id_catalogo_valor)::numeric
where
emp.id_empresa = param_id_empresa
and
emp.id_add_campo = 517
and
upper(cat.nom_cat_val) like '%SOCIEDAD%LIMITADA%UNIPERSONAL%';
select
count(*) into strict lincountsac
from
dercorp_add_campo_valor_tab emp
inner join dercorp_add_campo_cat_val_tab cat
on (emp.val_valor)::numeric  = (cat.id_catalogo_valor)::numeric
where
emp.id_empresa = param_id_empresa
and
emp.id_add_campo = 517
and
upper(cat.nom_cat_val) like '%SOCIEDAD%AN%CERRADA%';
select
count(*) into strict lincountsau
from
dercorp_add_campo_valor_tab emp
inner join dercorp_add_campo_cat_val_tab cat
on (emp.val_valor)::numeric  = (cat.id_catalogo_valor)::numeric
where
emp.id_empresa = param_id_empresa
and
emp.id_add_campo = 517
and
upper(cat.nom_cat_val) like '%SOCIEDAD%AN%UNIPERSONAL%';
select
count(*) into strict lincountltd
from
dercorp_add_campo_valor_tab emp
inner join dercorp_add_campo_cat_val_tab cat
on (emp.val_valor)::numeric  = (cat.id_catalogo_valor)::numeric
where
emp.id_empresa = param_id_empresa
and
emp.id_add_campo = 517
and
upper(cat.nom_cat_val) like '%LIMITED';
select
count(*) into strict lincountsderldecv
from
dercorp_add_campo_valor_tab emp
inner join dercorp_add_campo_cat_val_tab cat
on (emp.val_valor)::numeric  = (cat.id_catalogo_valor)::numeric
where
emp.id_empresa = param_id_empresa
and
emp.id_add_campo = 517
and
upper(cat.nom_cat_val) like '%RESPONSABILIDAD%LIMITADA%DE%CAPITAL%VARIABLE%';
select
count(*) into strict lincountsderl
from
dercorp_add_campo_valor_tab emp
inner join dercorp_add_campo_cat_val_tab cat
on (emp.val_valor)::numeric  = (cat.id_catalogo_valor)::numeric
where
emp.id_empresa = param_id_empresa
and
emp.id_add_campo = 517
and
upper(cat.nom_cat_val) like '%RESPONSABILIDAD%LIMITADA';
select
count(*) into strict lincountsadecv
from
dercorp_add_campo_valor_tab emp
inner join dercorp_add_campo_cat_val_tab cat
on (emp.val_valor)::numeric  = (cat.id_catalogo_valor)::numeric
where
emp.id_empresa = param_id_empresa
and
emp.id_add_campo = 517
and
upper(cat.nom_cat_val) like '%SOCIEDAD%ANONIMA%DE%CAPITAL%VARIABLE%';
select
count(*) into strict lincountsa
from
dercorp_add_campo_valor_tab emp
inner join dercorp_add_campo_cat_val_tab cat
on (emp.val_valor)::numeric  = (cat.id_catalogo_valor)::numeric
where
emp.id_empresa = param_id_empresa
and
emp.id_add_campo = 517
and
upper(cat.nom_cat_val) like '%SOCIEDAD%ANONIMA';
select
count(*) into strict lincountsabdecv
from
dercorp_add_campo_valor_tab emp
inner join dercorp_add_campo_cat_val_tab cat
on (emp.val_valor)::numeric  = (cat.id_catalogo_valor)::numeric
where
emp.id_empresa = param_id_empresa
and
emp.id_add_campo = 517
and
upper(cat.nom_cat_val) like '%SOCIEDAD%ANONIMA%BURSATIL%DE%CAPITAL%VARIABLE%';
select
count(*) into strict lincountsab
from
dercorp_add_campo_valor_tab emp
inner join dercorp_add_campo_cat_val_tab cat
on (emp.val_valor)::numeric  = (cat.id_catalogo_valor)::numeric
where
emp.id_empresa = param_id_empresa
and
emp.id_add_campo = 517
and
upper(cat.nom_cat_val) like '%SOCIEDAD%ANONIMA%BURSATIL';
select
count(*) into strict lincountsc
from
dercorp_add_campo_valor_tab emp
inner join dercorp_add_campo_cat_val_tab cat
on (emp.val_valor)::numeric  = (cat.id_catalogo_valor)::numeric
where
emp.id_empresa = param_id_empresa
and
emp.id_add_campo = 517
and
upper(cat.nom_cat_val) like '%SOCIEDAD%CIVIL';
--jjaq se agrega la llc para que no muestre capital fijo o minimo y capital variable
select
count(*) into strict lincountllc
from
dercorp_add_campo_valor_tab emp
inner join dercorp_add_campo_cat_val_tab cat
on (emp.val_valor)::numeric  = (cat.id_catalogo_valor)::numeric
where
emp.id_empresa = param_id_empresa
and
emp.id_add_campo = 517
and
upper(cat.nom_cat_val) like '%LIMITED%LIABILITY%COMPANY%';
select
count(*)into lincountsl
from
dercorp_add_campo_valor_tab emp
inner join dercorp_add_campo_cat_val_tab cat
on (emp.val_valor)::numeric  = (cat.id_catalogo_valor)::numeric
where
emp.id_empresa = param_id_empresa
and
emp.id_add_campo = 517
and
upper(cat.nom_cat_val) like '%SOCIEDA%LIMITADA';
if lincountasoccivil      <> 0 then
return 'isAC';
elsif lincountsderldecv   <> 0 then
return 'isSdeRLdeCV';
elsif lincountsderl       <> 0 then
return 'isSdeRL';
elsif lincountsadecv      <> 0 then
return 'isSAdeCV';
elsif lincountsa          <> 0 then
return 'isSA';
elsif lincountsabdecv     <> 0 then
return 'isSABdeCV';
elsif lincountsab         <> 0 then
return 'isSAB';
elsif lincountsc          <> 0 then
return 'isSC';
elsif lincountllc         <> 0 then
return 'isLLC';
elsif lincountslu         <> 0 then
return 'isSLU';
elsif lincountsac         <> 0 then
return 'isSAC';
elsif lincountsau         <> 0 then
return 'isSAU';
elsif lincountltd         <> 0 then
return 'isLTD';
elsif lincountsl          <> 0 then
return 'isSL';
else
return 'NoAplica';
end if;end;
$body$
language plpgsql
stable;
