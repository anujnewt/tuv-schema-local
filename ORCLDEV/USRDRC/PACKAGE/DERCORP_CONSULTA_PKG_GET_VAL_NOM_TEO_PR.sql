create or replace procedure usrdrc.dercorp_consulta_pkg_get_val_nom_teo_pr (poinvalor inout numeric ,piinidaddcampo numeric ,piinidempresa numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
select   val_valor
into strict     poinvalor
from     dercorp_add_campo_valor_tab
where    1=1
and      id_add_campo in (piinidaddcampo)
and      id_empresa = piinidempresa
;
exception
when no_data_found then
poinvalor := 0;end;
$body$
language plpgsql
;
