create or replace procedure usrdrc.dercorp_con_ref_doc_pkg_get_values_disminucion_cap_pr (porcrsdisminucioncap inout refcursor ,piinidmetarow numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open porcrsdisminucioncap for
select   mtl.val_c25 as solicitud
,mtl.val_c119 as sol_por
,mtl.val_c26 as fec_doc
,mtl.val_c27 as fec_rec
,mtl.val_c28 as fol_num
,mtl.val_c29 as num_doc_sol
,mtl.val_c30 as acta_resol
,mtl.val_c31 as num_doc_acta_resol
,mtl.val_c32 as convocatoria
,mtl.val_c33 as num_doc_conv
,mtl.val_c34 as publicaciones
,mtl.val_c35 as num_doc_publi
,mtl.val_c36 as documento_entregado
,mtl.val_c37 as num_doc_doc_ent
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
