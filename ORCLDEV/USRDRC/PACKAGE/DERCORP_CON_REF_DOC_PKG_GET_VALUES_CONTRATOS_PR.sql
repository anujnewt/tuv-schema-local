create or replace procedure usrdrc.dercorp_con_ref_doc_pkg_get_values_contratos_pr (porcrscontratos inout refcursor ,piinidmetarow numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
open porcrscontratos for
select   mtl.val_c20 as solicitud
,mtl.val_c119 as sol_por
,mtl.val_c21 as fec_doc
,mtl.val_c22 as fec_rec
,mtl.val_c23 as fol_num
--,mtl.val_c138 as num_doc_sol
,mtl.val_c24 as num_doc_sol--solicitud jams 26/02/2018 se modifica
,mtl.val_c25 as contrato_ent
--,mtl.val_c26 as num_cont_cont_ent
,mtl.val_c138 as num_cont_cont_ent--documento de entrega jams 26/02/2018 se modifica
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
