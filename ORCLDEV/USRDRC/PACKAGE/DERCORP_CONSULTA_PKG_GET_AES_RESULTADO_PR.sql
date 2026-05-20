create or replace procedure usrdrc.dercorp_consulta_pkg_get_aes_resultado_pr (porcrsresultado inout refcursor ,piinidmetarow numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open porcrsresultado for
select  val_c7 as utilidad,
val_c9 as perdida
from    dercorp_metatbl_tab
where   1 = 1
and     id_meta_row = piinidmetarow
;end;
$body$
language plpgsql
;
