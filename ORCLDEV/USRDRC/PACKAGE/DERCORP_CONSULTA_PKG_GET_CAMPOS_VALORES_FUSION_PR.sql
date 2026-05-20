create or replace procedure usrdrc.dercorp_consulta_pkg_get_campos_valores_fusion_pr (porcrsresultado inout refcursor ,piinidmetarow numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open porcrsresultado for
select   val_c149 as asunto
,val_c2   as tiporeunion
,val_c98  as sociedadfusionante
,val_c3   as fecha
,val_c4   as hora
,val_c99  as asambleassociedadesfusionadas
,val_c18  as fechaefectospartes
,val_c19  as fechaefectosterceros
,val_c20  as artclauestatrefor
,val_c21  as otrosobservaciones
,val_c100 as otrosregistros
from    dercorp_metatbl_tab
where   1=1
and     id_meta_row = piinidmetarow
;end;
--ecm 29 agosto 2016 obtner el valor nominal o valor te??rico nominal.
$body$
language plpgsql
;
