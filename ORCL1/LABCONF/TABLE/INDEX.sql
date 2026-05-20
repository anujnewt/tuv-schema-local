-- dmap_object_gen_tag : type : unique name : index
set search_path = labconf,oracle,dmap_extension,public;
create unique index comcias_01 on comcias (numcia);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labconf,oracle,dmap_extension,public;
create unique index pk1_comparativo on comparativo (id_comp);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labconf,oracle,dmap_extension,public;
create unique index comtporegistro_01 on comtporegistro (numtporeg);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labconf,oracle,dmap_extension,public;
create unique index det_capinc01 on det_capinc (det_numid);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labconf,oracle,dmap_extension,public;
create unique index eorede01 on eocorede (red_keyest, red_hijdep);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labconf,oracle,dmap_extension,public;
create unique index eorede02 on eocorede (red_keyest, red_codniv);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labconf,oracle,dmap_extension,public;
create unique index eodpla02 on eolodpla (dpl_keydpl);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labconf,oracle,dmap_extension,public;
create unique index eoplan01 on eoloplan (pla_keyest, pla_keydep, pla_keypue);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labconf,oracle,dmap_extension,public;
create unique index eosolc01 on eolosolc (sol_keysol);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labconf,oracle,dmap_extension,public;
create unique index glbiny01 on glcobiny (bin_keybin);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labconf,oracle,dmap_extension,public;
create unique index glcamp01 on glcocamp (cam_keytab, cam_keycam);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labconf,oracle,dmap_extension,public;
create unique index ix701_1 on glcofmts (fmt_keyfmt);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labconf,oracle,dmap_extension,public;
create unique index glmoti01 on glcomoti (mot_keymot);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labconf,oracle,dmap_extension,public;
create unique index inword01 on inloword (wor_keywor);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labconf,oracle,dmap_extension,public;
create unique index inwsql01 on inlowsql (wsq_keywor, wsq_numsql);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labconf,oracle,dmap_extension,public;
create unique index pk_isnconf_1 on isnconf (idconfig);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labconf,oracle,dmap_extension,public;
create unique index pk_isnentidad on isnentidades (ent_keyent);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labconf,oracle,dmap_extension,public;
create unique index pk_isntotales on isntotales (isn_keyent, isn_keycia, isn_anio, isn_mes);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labconf,oracle,dmap_extension,public;
create unique index nmcapinc01 on nmcapinc (inc_keyusu, inc_keyemp, inc_keysem);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labconf,oracle,dmap_extension,public;
create unique index nmcvac01 on nmcocvac (vac_keyemp, vac_antigu);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labconf,oracle,dmap_extension,public;
create unique index nmcval01 on nmcocval (cva_nomvar, cva_keydep);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labconf,oracle,dmap_extension,public;
create unique index coforp01 on nmcoforp (for_keyfor);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labconf,oracle,dmap_extension,public;
create unique index i453_255 on nmcotvac (ant_keypro, ant_antigu);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labconf,oracle,dmap_extension,public;
create unique index nmacum01 on nmloacum (acu_keypro, acu_keyemp, acu_keycon, acu_anioac);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labconf,oracle,dmap_extension,public;
create unique index nmcfgn01 on nmlocfgn (cfg_keycfg);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labconf,oracle,dmap_extension,public;
create unique index nmcier01 on nmlocier (cie_keycie);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labconf,oracle,dmap_extension,public;
create unique index pk_ctas on nmloctas (cta_keypro, cta_keyemp);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labconf,oracle,dmap_extension,public;
create unique index nmenfm01 on nmloenfm (enf_keyfor);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labconf,oracle,dmap_extension,public;
create unique index nmpas01 on nmlopas (pas_keyemp);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labconf,oracle,dmap_extension,public;
create unique index nmpres02 on nmlopres (pre_keypre);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labconf,oracle,dmap_extension,public;
create unique index nmtanu01 on nmlotanu (tan_keytab);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labconf,oracle,dmap_extension,public;
create unique index nmurno01 on nmwkurno (urn_keymen);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labconf,oracle,dmap_extension,public;
create unique index cpcols01 on pllocols (col_keycol);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labconf,oracle,dmap_extension,public;
create unique index cpconc01 on plloconc (con_keycon);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labconf,oracle,dmap_extension,public;
create unique index conrec201 on tmpconrec2 (rec_keypro, rec_keyper, rec_keynom, rec_strcon);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labconf,oracle,dmap_extension,public;
create unique index tvverc02 on tvloverc (ver_keyver, ver_keycon);
-- dmap_object_gen_tag : type : unique name : index
set search_path = labconf,oracle,dmap_extension,public;
create unique index idx_wemail on wemail (keyemp);
