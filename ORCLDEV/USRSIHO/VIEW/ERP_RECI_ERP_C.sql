-- dmap_object_gen_tag : type : view name : erp_reci_erp_c
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "erp_reci_erp_c"  ("rec_cvepol", "rec_fecpag", "rec_numerr", "rec_stsrec", "rec_status", "rec_tipcam", "rec_fecgen", "rec_forpag", "rec_fpafin", "rec_tcafin", "rec_tippag", "rec_refere", "rec_fecrec", "rec_cveban", "rec_ctaban") as select
rec_cvepol, rec_fecpag, rec_numerr, rec_stsrec, rec_status, rec_tipcam, rec_fecgen, rec_forpag, rec_fpafin,
rec_tcafin, rec_tippag, rec_refere, rec_fecrec, rec_cveban, rec_ctaban
from reci_erp_c;/* dmap converted statement end */
-- estimed cost of view [ erp_reci_erp_c ]: 1.00;
