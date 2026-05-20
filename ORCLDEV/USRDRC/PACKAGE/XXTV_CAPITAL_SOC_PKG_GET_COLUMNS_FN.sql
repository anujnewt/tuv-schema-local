create or replace  function  usrdrc.xxtv_capital_soc_pkg_get_columns_fn (pstidempresa varchar) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
lincountresplimitada    numeric;
linsinexpresionnominal  numeric;
lincountaplicacapfijo   numeric;
lincountaplicacapvariab numeric;
aplica_cap_fijo         numeric;
aplica_cap_variable     numeric;
formato_campos          varchar(1000);
texto_cap_fijo          varchar(1000);
texto_cap_variable      varchar(1000);
texto_total             varchar(1000);
habilitar_valor_captura numeric;
accionista              varchar(1000);
lincountsa              numeric;--jjaq 20/02/2017 cambiar nombre columna de las s.a
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
emp.id_empresa = pstidempresa
and
emp.id_add_campo = 517
and
upper(cat.nom_cat_val) like '%RESPONSABILIDAD%LIMITADA%';
select
count(*)into lincountsa
from
dercorp_add_campo_valor_tab emp
inner join dercorp_add_campo_cat_val_tab cat
on (emp.val_valor)::numeric  = (cat.id_catalogo_valor)::numeric
where
emp.id_empresa = pstidempresa
and
emp.id_add_campo = 517
and
upper(cat.nom_cat_val) like '%SOCIEDAD%ANONIMA';
select
count(*) into strict linsinexpresionnominal
from
dercorp_add_campo_valor_tab emp
inner join dercorp_add_campo_cat_val_tab cat
on (emp.val_valor)::numeric  = (cat.id_catalogo_valor)::numeric
where
emp.id_empresa = pstidempresa
and
emp.id_add_campo = 519
and (upper(cat.nom_cat_val) like '%SIN%EXPRES%NOMINAL'
or
upper(cat.nom_cat_val) like '%VALOR%DESIGUAL%'
)
;
select
count(*) into strict lincountaplicacapfijo
from dercorp_add_campo_valor_tab
where
id_empresa = pstidempresa
and (
id_add_campo = 1030 -- aplica capital fijo
);
select
count(*) into strict lincountaplicacapvariab
from dercorp_add_campo_valor_tab
where
id_empresa = pstidempresa
and (
id_add_campo = 1031 -- aplica capital variable
);
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
if linsinexpresionnominal <> 0 then
if lincountsa > 0
then
texto_cap_fijo     := 'Acciones';
else
texto_cap_fijo     := 'Acciones </br> Capital Fijo';
end if;
texto_cap_variable := 'Acciones  </br> Capital Variable';
texto_total := 'Total';
end if;
--ecm 31 agosto 2015
if lincountresplimitada = 0 and linsinexpresionnominal = 0 then
texto_total := 'Valor';
end if;
--ecm 01 septiembre 2015
if lincountresplimitada = 1 then
accionista          := 'Socios';
texto_cap_fijo      := 'Partes Sociales Capital Fijo';
texto_cap_variable  := 'Partes Sociales Capital Variable';
texto_total         := 'Total Partes Sociales';
elsif lincountresplimitada = 0 then
accionista          := 'Accionistas';
end if;/* dmap converted statement start */
return  concat(accionista, '|', texto_cap_fijo, '|', texto_cap_variable, '|', texto_total) ;/* dmap converted statement end */end;
$body$
language plpgsql
stable;
