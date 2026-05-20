-- dmap_object_gen_tag : type : unique name : index
set search_path = labppto,oracle,dmap_extension,public;
create unique index comcias_01 on comcias (numcia);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labppto,oracle,dmap_extension,public;
create unique index pk1_comparativo on comparativo (id_comp);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labppto,oracle,dmap_extension,public;
create unique index comtporegistro_01 on comtporegistro (numtporeg);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labppto,oracle,dmap_extension,public;
create unique index ix1397_1 on cuenta_compara (cve_cuenta);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labppto,oracle,dmap_extension,public;
create unique index pk_det_compara on det_compara (id_comp, cve_cuenta);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labppto,oracle,dmap_extension,public;
create unique index eorede01 on eocorede (red_keyest, red_hijdep);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labppto,oracle,dmap_extension,public;
create unique index eorede02 on eocorede (red_keyest, red_codniv);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labppto,oracle,dmap_extension,public;
create unique index glbiny01 on glcobiny (bin_keybin);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labppto,oracle,dmap_extension,public;
create unique index glcamp01 on glcocamp (cam_keytab, cam_keycam);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labppto,oracle,dmap_extension,public;
create unique index xpkppciapro on ppciapro (apr_keycia, apr_keypro);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labppto,oracle,dmap_extension,public;
create unique index ppempmesidx_01 on ppempmes (emm_keyver, emm_keycia, emm_keyemp, emm_mes);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labppto,oracle,dmap_extension,public;
create unique index ppfacint01 on ppfacint (int_condic, int_keypro, int_tpoemp);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labppto,oracle,dmap_extension,public;
create unique index pploaux1_01 on pploaux1 (pru_keycia, pru_keyver, pru_keyemp, pru_nummes);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labppto,oracle,dmap_extension,public;
create unique index xpkpplocomp on pplocomp (com_keycia, com_keyver, com_keycen, com_keyemp, com_keycon, com_keytpo);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labppto,oracle,dmap_extension,public;
create unique index xpkpploconc on pploconc (con_keycon);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labppto,oracle,dmap_extension,public;
create unique index idx_pplocuen01 on pplocuen (cue_keycue, cue_keytpo);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labppto,oracle,dmap_extension,public;
create unique index pporde01 on pploorde (ord_keycia, ord_keyver, ord_keyemp, ord_keymes);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labppto,oracle,dmap_extension,public;
create unique index pk_pploparnew on pploparnew (par_keycia, par_keyver, par_keypro, par_keyloc);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labppto,oracle,dmap_extension,public;
create unique index xpkpplopcxc on pplopcxc (pcx_keyver, pcx_keycia, pcx_ciaorg, pcx_keycen, pcx_keycon, pcx_tipcon, pcx_tipemp);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labppto,oracle,dmap_extension,public;
create unique index idx_01pploplza on pploplza (ppl_keyver, ppl_keycia, ppl_ciaorg, ppl_keycen);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labppto,oracle,dmap_extension,public;
create unique index idxu_ppto1 on pploppto (ppt_keycia, ppt_keyver, ppt_keyemp, ppt_keycon);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labppto,oracle,dmap_extension,public;
create unique index xpkpplorep on pplorep (rep_keycia, rep_keyver, rep_keyemp, rep_keycon);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labppto,oracle,dmap_extension,public;
create unique index xpkpplovice on pplovice (vic_keycia, vic_keyvic, vic_keyame);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labppto,oracle,dmap_extension,public;
create unique index partopidx01 on pppartop (top_keycia, top_keyver, top_keypro, top_cvezon, top_tpoemp, top_clave);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labppto,oracle,dmap_extension,public;
create unique index xpkpptpomov on pptpomov (tpo_keytpo);
