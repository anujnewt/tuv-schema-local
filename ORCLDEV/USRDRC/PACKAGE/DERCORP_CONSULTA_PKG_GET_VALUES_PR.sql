create or replace procedure usrdrc.dercorp_consulta_pkg_get_values_pr (empresaid numeric, isasociacioncivil inout numeric) as $body$
declare
i record;
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
select
count(*) into strict isasociacioncivil
from
dercorp_add_campo_valor_tab emp
inner join dercorp_add_campo_cat_val_tab cat
on (emp.val_valor)::numeric  = (cat.id_catalogo_valor)::numeric
where
emp.id_empresa = empresaid
and
emp.id_add_campo = 517
and
upper(cat.nom_cat_val) like '%ASOC%CIVIL%';end;
$body$
language plpgsql
;
