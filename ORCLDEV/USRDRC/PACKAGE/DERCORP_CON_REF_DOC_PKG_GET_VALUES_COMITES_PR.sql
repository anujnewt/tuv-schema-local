create or replace procedure usrdrc.dercorp_con_ref_doc_pkg_get_values_comites_pr (porcrscomites inout refcursor ,piinidmetarow numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open porcrscomites for
select   val_c14    as    solicitud
,val_c15    as    fec_doc
,val_c16    as    fec_rec
,val_c17    as    folio_num
,val_c18    as    num_doc_sol
,val_c19    as    acta_resol
,val_c20    as    num_doc_acta_resol
,val_c21    as    convocatoria
,val_c22    as    num_doc_convoc
,val_c23    as    documento_entregado
,val_c24    as    num_doc_doc_ent
from    dercorp_metatbl_tab
where   1=1
and     id_meta_row = piinidmetarow
;end;
$body$
language plpgsql
;
