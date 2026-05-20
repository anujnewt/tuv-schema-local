create or replace procedure usrdrc.dercorp_con_ref_doc_pkg_get_values_acta_otros_pr (porcrsactaotros inout refcursor ,piinidmetarow numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open porcrsactaotros for
select mtl.val_c13 as solicitud
,mtl.val_c119 as sol_por
,mtl.val_c14 as fec_doc
,mtl.val_c15 as fec_rec
,mtl.val_c16 as fol_num
,mtl.val_c17 as num_doc_sol
,mtl.val_c18 as acta_resoluciones
,mtl.val_c19 as num_doc_acta_resol
,mtl.val_c20 as convocatoria
,mtl.val_c21 as num_doc_convocatoria
,mtl.val_c22 as publicaciones
,mtl.val_c23 as num_doc_pub
,mtl.val_c24 as doc_entregado
,mtl.val_c25 as num_doc_doc_ent
,mtl.val_c120 as fec_doc_e
,mtl.val_c121 as fec_rec_e
,(select count(*) from pendium_ejercicio_social_tab where id_meta_row=mtl.id_meta_row) as agreg_doc
from    dercorp_metatbl_tab mtl
where   1=1
and     id_meta_row = piinidmetarow
;end;
$body$
language plpgsql
;
