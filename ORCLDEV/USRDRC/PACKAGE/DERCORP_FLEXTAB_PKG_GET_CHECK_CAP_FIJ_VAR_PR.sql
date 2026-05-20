create or replace procedure usrdrc.dercorp_flextab_pkg_get_check_cap_fij_var_pr (poutcapvar inout integer ,poutcapfij inout integer ,pinidemp integer) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
--checkbox
select  count(*) into strict  poutcapfij
from    dercorp_add_campo_valor_tab
where   1=1
and     id_empresa = pinidemp
and     id_add_campo = 1030
;
--checkbox
select  count(*) into strict  poutcapvar
from    dercorp_add_campo_valor_tab
where   1=1
and     id_empresa = pinidemp
and     id_add_campo = 1031
;end;
$body$
language plpgsql
;
