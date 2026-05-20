create or replace procedure usrdrc.dercorp_captura_pkg_delete_checkbox_adm_vig_pr (param_id_empresa integer) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
delete from dercorp_add_campo_valor_tab
where       id_empresa = param_id_empresa
and         id_add_campo in (select id_add_campo
from   dercorp_add_campo_tab
where  des_tipo_campo in ('CHECKBOX_A'));
/* commit; */
end;
$body$
language plpgsql
;
