-- dmap_object_gen_tag : type : type name : tvautsaf_local_tvautsaf_local_tipo_incidencia;
set search_path = labprod,oracle,dmap_extension,public;
drop type  if exists tvautsaf_local_tvautsaf_local_tipo_incidencia;
-- dmap_object_gen_tag : type : type name : LABPROD.tvautsaf_local_tvautsaf_local_tipo_incidencia
set search_path = labprod,oracle,dmap_extension,public;
create type LABPROD.tvautsaf_local_tvautsaf_local_tipo_incidencia as (wn_key_emp labprod.tvincsaf.inc_keyemp%type, ws_cve_ref labprod.tvincsaf.inc_cveref%type, wn_tot_sol labprod.tvincsaf.inc_totsol%type, wn_imp_des labprod.tvincsaf.inc_impdes%type,gn_fec_ini labprod.tvincsaf.inc_fecini%type, wn_imp_sal labprod.tvincsaf.inc_impsal%type, wn_uni_pre labprod.tvincsaf.inc_unipre%type, wn_uni_des labprod.tvincsaf.inc_unides%type,wn_uni_sal labprod.tvincsaf.inc_unisal%type, ws_key_con labprod.tvincsaf.inc_keycon%type, ws_per_saf labprod.tvincsaf.inc_persaf%type);
