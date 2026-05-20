create or replace procedure usrdrc.dercorp_con_ref_doc_pkg_get_values_decreto_dividen_pr (porcrsdecretodividendo inout refcursor ,piinidmetarow numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open porcrsdecretodividendo for
select mtl.val_c15 as solicitud
,mtl.val_c119 as sol_por
,mtl.val_c16 as fec_doc
,mtl.val_c17 as fec_rec
,mtl.val_c18 as fol_num
,mtl.val_c19 as num_doc_sol
,mtl.val_c20 as acta_resol
,mtl.val_c21 as num_doc_acta_resol
,mtl.val_c22 as documento_entregado
,mtl.val_c23 as num_doc_doc_ent
,mtl.val_c120 as fec_doc_e
,mtl.val_c121 as fec_rec_e
,(select count(*) from pendium_ejercicio_social_tab where id_meta_row=mtl.id_meta_row) as agreg_doc
from   dercorp_metatbl_tab mtl
where  1=1
and    id_meta_row = piinidmetarow
;end;
$body$
language plpgsql
;
