-- DMAP_OBJECT_GEN_TAG : TYPE : EDITIONABLE NAME : tvautsaf_local_tipo_incidencia
SET search_path = labprod,oracle,dmap_extension,public;

CREATE TYPE tvautsaf_local_tipo_incidencia AS (
wn_key_emp LABPROD.NUMERIC, ws_cve_ref LABPROD.varchar, wn_tot_sol LABPROD.NUMERIC, wn_imp_des LABPROD.NUMERIC,
    gn_fec_ini LABPROD.varchar, wn_imp_sal LABPROD.NUMERIC, wn_uni_pre LABPROD.NUMERIC, wn_uni_des LABPROD.NUMERIC,
    wn_uni_sal LABPROD.NUMERIC, ws_key_con LABPROD.varchar, ws_per_saf LABPROD.varchar

);
