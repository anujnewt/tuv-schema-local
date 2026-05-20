create or replace procedure usrdrc.xxtv_capital_soc_pkg_get_variables_pr (param_id_empresa varchar, aplica_cap_fijo inout numeric, aplica_cap_variable inout numeric, formato_campos inout varchar, texto_cap_fijo inout varchar, texto_cap_variable inout varchar, texto_total inout varchar, habilitar_valor_captura inout numeric, accionista inout varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
lincountresplimitada       numeric;
linsinexpresionnominal     numeric;
lincountaplicacapfijo      numeric;
lincountaplicacapvariab    numeric;
lincountasociacioncivil    numeric;
lisociedadcivil            numeric;
liasociacioncivil          numeric;
lincountresplimitadanvo    numeric;--jjaq 20/02/2017 se agrega nueva sociedad
lincountsa                 numeric;--jjaq 20/02/2017 cambiar nombre columna de las s.a
lincountsab                numeric;
lincountsabdecv            numeric;
lincountllc                numeric;
lincountslu                numeric;
lincountltd                numeric;
lincountsau                numeric;
lincountnpc                numeric;
lincountsl                 numeric;
lincountsac                numeric;
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
count(*) into strict lincountresplimitadanvo
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
count(*)into liasociacioncivil
from
dercorp_add_campo_valor_tab emp
inner join dercorp_add_campo_cat_val_tab cat
on (emp.val_valor)::numeric  = (cat.id_catalogo_valor)::numeric
where
emp.id_empresa = param_id_empresa
and
emp.id_add_campo = 517
and
upper(cat.nom_cat_val) like '%ASOCIACION%CIVIL%';
select
count(*)into lincountsa
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
select
count(*)into lincountsabdecv
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
count(*)into lincountsab
from
dercorp_add_campo_valor_tab emp
inner join dercorp_add_campo_cat_val_tab cat
on (emp.val_valor)::numeric  = (cat.id_catalogo_valor)::numeric
where
emp.id_empresa = param_id_empresa
and
emp.id_add_campo = 517
and
upper(cat.nom_cat_val) like '%SOCIEDAD%ANONIMA%BURSATIL%';
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
upper(cat.nom_cat_val) like '%N/A'
);
select
count(*) into strict lincountaplicacapfijo
from dercorp_add_campo_valor_tab
where
id_empresa = param_id_empresa
and (
id_add_campo = 1030 -- aplica capital fijo
);
select
count(*) into strict lincountaplicacapvariab
from dercorp_add_campo_valor_tab
where
id_empresa = param_id_empresa
and (
id_add_campo = 1031 -- aplica capital variable
);
-- kaz-nava-26oct
select
count(*) into strict lincountasociacioncivil
from
dercorp_add_campo_valor_tab emp
inner join dercorp_add_campo_cat_val_tab cat
on (emp.val_valor)::numeric  = (cat.id_catalogo_valor)::numeric
where
emp.id_empresa = param_id_empresa
and
emp.id_add_campo = 517
and
upper(cat.nom_cat_val) like '%ASOCIACI%CIVIL%';
--ecm 26 mayo 2016
select  count(*) into strict lisociedadcivil
from    dercorp_add_campo_valor_tab emp
inner join dercorp_add_campo_cat_val_tab cat
on (emp.val_valor)::numeric  = (cat.id_catalogo_valor)::numeric
where   1=1
and     emp.id_empresa = param_id_empresa
and     emp.id_add_campo = 517
and     upper(cat.nom_cat_val) like '%SOCIEDAD%CIVIL%'
;
select  count(*) into strict lincountllc
from    dercorp_add_campo_valor_tab emp
inner join dercorp_add_campo_cat_val_tab cat
on (emp.val_valor)::numeric  = (cat.id_catalogo_valor)::numeric
where   1=1
and     emp.id_empresa = param_id_empresa
and     emp.id_add_campo = 517
and     upper(cat.nom_cat_val) like '%LIMITED%LIABILITY%COMPANY%'
;
select  count(*) into strict lincountslu
from    dercorp_add_campo_valor_tab emp
inner join dercorp_add_campo_cat_val_tab cat
on (emp.val_valor)::numeric  = (cat.id_catalogo_valor)::numeric
where   1=1
and     emp.id_empresa = param_id_empresa
and     emp.id_add_campo = 517
and     upper(cat.nom_cat_val) like '%SOCIEDAD%LIMITADA%UNIPERSONAL%'
;
select  count(*) into strict lincountsac
from    dercorp_add_campo_valor_tab emp
inner join dercorp_add_campo_cat_val_tab cat
on (emp.val_valor)::numeric  = (cat.id_catalogo_valor)::numeric
where   1=1
and     emp.id_empresa = param_id_empresa
and     emp.id_add_campo = 517
and     upper(cat.nom_cat_val) like '%SOCIEDAD%AN%CERRADA%'
;
select  count(*) into strict lincountltd
from    dercorp_add_campo_valor_tab emp
inner join dercorp_add_campo_cat_val_tab cat
on (emp.val_valor)::numeric  = (cat.id_catalogo_valor)::numeric
where   1=1
and     emp.id_empresa = param_id_empresa
and     emp.id_add_campo = 517
and     upper(cat.nom_cat_val) like '%LIMITED'
;
select  count(*) into strict lincountsau
from    dercorp_add_campo_valor_tab emp
inner join dercorp_add_campo_cat_val_tab cat
on (emp.val_valor)::numeric  = (cat.id_catalogo_valor)::numeric
where   1=1
and     emp.id_empresa = param_id_empresa
and     emp.id_add_campo = 517
and     upper(cat.nom_cat_val) like '%SOCIEDAD%AN%UNIPERSONAL%'
;
select  count(*) into strict lincountnpc
from    dercorp_add_campo_valor_tab emp
inner join dercorp_add_campo_cat_val_tab cat
on (emp.val_valor)::numeric  = (cat.id_catalogo_valor)::numeric
where   1=1
and     emp.id_empresa = param_id_empresa
and     emp.id_add_campo = 517
and     upper(cat.nom_cat_val) like '%NOT%FOR%PROFIT%CORPORATION%'
;
aplica_cap_fijo     := lincountaplicacapfijo;
aplica_cap_variable := lincountaplicacapvariab;
if lincountaplicacapfijo = 0 and lincountaplicacapvariab = 0  then
habilitar_valor_captura := 1;
else
habilitar_valor_captura := 0;
end if;
if lincountresplimitada <> 0 or linsinexpresionnominal <> 0 then
formato_campos := 'NUMBER';
else
formato_campos := 'INTEGER';
end if;
/*ecm 05 junio 2016*/
if lincountresplimitada <> 0 or linsinexpresionnominal = 1 then
formato_campos := 'INTEGER';
end if;
if lincountresplimitada <> 0  then
texto_cap_fijo     := 'Valor Acciones </br> Capital Fijo';
texto_cap_variable := 'Valor Acciones </br> Capital Variable';
texto_total := 'Valor';
else
if lincountsa > 0
then
texto_cap_fijo     := 'Acciones';
else
texto_cap_fijo     := 'Acciones </br> Capital Fijo';
end if;
texto_cap_variable := 'Acciones </br> Capital Variable';
texto_total := 'Total';
end if;
if linsinexpresionnominal <> 0 then--jjaq para no mostrar en empresas ac
if lincountsa > 0 then
texto_cap_fijo     := 'Acciones';
elsif lincountsab > 0 then
texto_cap_fijo     := 'Acciones';
else
texto_cap_fijo     := 'Acciones </br> Capital Fijo';
end if;
texto_cap_variable := 'Acciones </br> Capital Variable';
texto_total := 'Total';
end if;
--ecm 31 agosto 2015
if lincountresplimitada = 0 and linsinexpresionnominal = 0 then
texto_total := 'Valor';
end if;
--ecm 01 septiembre 2015
if lincountresplimitada = 1 then
accionista          := 'Socios';
--se agrega if para cambiar titulo en las sociedad de srlcv y srl nueva
if lincountresplimitadanvo > 0
then
--partes sociales capital fijo;
texto_cap_fijo      := 'Valor Parte Social';
else
texto_cap_fijo      := 'Valor Parte Social Capital Fijo';
end if;
texto_cap_variable  := 'Valor Parte Social Capital Variable';--partes sociales capital variable;
--texto_total         := total partes sociales;
texto_total         := 'Valor Total Partes Sociales';
formato_campos := 'AMOUNT'; -- kaz-nava 26-oct-15
else
if lincountresplimitada = 0 then
if lisociedadcivil >= 1 -- viri 02/12/2016
then
accionista          := 'Socios';
formato_campos := 'INTEGER';
else
accionista          := 'Accionistas';
end if;
-- formato_campos := amount_sc;
end if;
end if;
if lincountasociacioncivil = 1 then
accionista          := 'Asociados';
end if;
--ecm 26 mayo 2016
--if lisociedadcivil >= 1 and linsinexpresionnominal >=1 then
if lisociedadcivil >= 1 then
texto_total         := 'Valor Total Partes Sociales';
end if;
----****inicia limited liability company llc jjaq 12/04/2017 inicio ----
if lincountllc > 0
then
if linsinexpresionnominal >= 0
then
formato_campos := 'INTEGER';
end if;
texto_total         := 'Participations';
accionista          := 'Members';
texto_cap_fijo      := 'Quota';
end if;
--termina
--****inicia sociedad limitada unipersonal jjaq 12/04/2017
if lincountslu > 0
then
if linsinexpresionnominal >= 0
then
formato_campos := 'INTEGER';
end if;
texto_total         := 'Valor';
accionista          := 'Socios';
texto_cap_fijo      := 'Participaciones';
end if;
--fin
--****inicia sociedad anonima cerrada jjaq 12/04/2017
if lincountsac > 0
then
if linsinexpresionnominal >= 0
then
formato_campos := 'INTEGER';
end if;
texto_total         := 'Valor';
accionista          := 'Accionistas';
texto_cap_fijo      := 'Acciones';
end if;
--****fin
--****inicia sociedad anonima unipersonal jjaq 12/04/2017
if lincountltd > 0
then
if linsinexpresionnominal >= 0
then
formato_campos := 'INTEGER';
end if;
texto_total         := 'Value';
accionista          := 'Shareholders';
texto_cap_fijo      := 'Shares';
end if;
--****fin  jjaq 12/04/2017
--****inicia sociedad anonima unipersonal jjaq 12/04/2017
if lincountsau > 0
then
if linsinexpresionnominal >= 0
then
formato_campos := 'INTEGER';
end if;
texto_total         := 'Valor';
accionista          := 'Accionista';
texto_cap_fijo      := 'Acciones';
end if;
--****fin  jjaq 12/04/2017
--****inicia sociedad limitada jjaq 12/04/2017
if lincountsl > 0
then
if linsinexpresionnominal >= 0
then
formato_campos := 'INTEGER';
end if;
texto_total         := 'Valor';
accionista          := 'Socios';
texto_cap_fijo      := 'Participaciones';
end if;
--fin
if lincountnpc > 0 then
accionista          := 'Members';
--formato_campos := amount;
end if;end;
$body$
language plpgsql
;
