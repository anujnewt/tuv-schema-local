-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index agrupa01 on agrupxcod (xco_keypro);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index anexo01 on anexo1 (keycia, c);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index anexo02 on anexo2 (keycia, a);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index idx_cfdiconf on cfdiconf (idconfig);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index codea_1 on codeacont (con_keyemp);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index consec01 on consagrup (gru_cvegpo);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index ix_detpcanr1 on detpcanr (dpc_numpco);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index pk_00_emacce on emacceso (acc_keyusu, acc_keyobj, acc_tipacc);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index pk_00_emacmo on emaccmod (acc_keyusu, acc_keymod);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index pk_00_emagen on emagencia (age_numage);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index pk_00_embita on embitacora (bit_keybit);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index pk_00_emcamp on emcampos (cam_keycam);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index pk_00_emdetb on emdetbit (det_keybit, det_tabla, det_campo);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index ix592_1 on emenvios (env_keyenv);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index pk_00_emfech on emfechfac (fec_fecha);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index pk_00_emimag on emimagen (ima_keyim1, ima_keyim2, ima_keyim3, ima_tipima);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index ix580_1 on emlocacion (loc_keyloc);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index pk_00_emmenc on emmencat (men_keyobj);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index pk_00_emmodu on emmodulo (mod_keymod);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index pk_00_emobje on emobjeto (obj_keyobj);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index ix575_2 on empagdxm (pag_keydet);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index ix574_1 on empagexm (pag_keypag);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index ix1068_1 on empercomple (per_keyper);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index pk_00_empers on empersonas (per_keyper);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index pk_00_emtabl on emtablas (tab_keytab);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index pk_00_emtabu on emtabulador (tab_keytab);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index pk_00_emusua on emusuari (usu_keyusu);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index ix_encpcanr1 on encpcanr (epc_numpco);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index ix_encpetco1 on encpetco (epc_numpco);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index ix_encsolact1 on encsolact (esa_numsol);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index eoplza04 on eocoplza (plz_keyplz);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index eorede01 on eocorede (red_keyest, red_hijdep);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index eorede02 on eocorede (red_keyest, red_codniv);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index eoplan01 on eoloplan (pla_keyest, pla_keydep, pla_keypue);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index pk_factura_erp on factura_erp (poliza);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index pk_factura_ter on factura_ter (poliza);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index glbiny01 on glcobiny (bin_keybin);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index glcaes01 on glcocaes (cae_keyest);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index glcamp01 on glcocamp (cam_keytab, cam_keycam);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index idx_glcocons on glcocons (con_keycvc, con_keyemp);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index gldocu01 on glcodocu (doc_keydoc);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index glesev01 on glcoesev (ese_keyeve);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index ix701_1 on glcofmts (fmt_keyfmt);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index glusua01 on glcousua (usu_keyusu);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index iholococa1 on holococa (coc_keyplz, coc_keycap, coc_numsec);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index ihcont01 on holocont (con_keyfol, con_keytco);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index i_hcont08 on holocont (con_keytco, con_keyfol);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index enc_1 on holoenclla (enc_num_id);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index enc_tra1 on holoenctra (enc_num_id);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index ix626_1 on holoenlla (enl_numfol);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index idx_holoequi on holoequi (equ_keypro, equ_keynom, equ_keyapr);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index ix490_1 on holosoco (soc_keysol);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index in_coac_hotmcoac on hotmcoac (coa_keypue);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index in_coac_tmp on hotmcoac_tmp (coa_keypue);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index in_coca_hotmcoca on hotmcoca (coc_keycap);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index in_coca_tmp on hotmcoca_tmp (coc_keycap);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index indwor01 on inlodwor (dwo_keywor, dwo_numsec);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index indwsq01 on inlodwsq (dws_keywor, dws_numsql, dws_numsec);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index inword01 on inloword (wor_keywor);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index inwsql01 on inlowsql (wsq_keywor, wsq_numsql);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index nmempl01 on nmcoempl (emp_keyemp);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index nmempl01_b on nmcoempl2 (emp_keyemp);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index nmpues01 on nmcopues (pue_keypue);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index nmcate01 on nmlocate (cat_keycat);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index nmcenc01 on nmlocenc (cen_keycen);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index nmcier01 on nmlocier (cie_keycie);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index nmconc01 on nmloconc (con_keycon);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index nmenfm01 on nmloenfm (enf_keyfor);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index nmmnem01 on nmlomnem (mne_keynem);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index nmnomi01 on nmlonomi (nom_keynom);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index nmpres02 on nmlopres (pre_keypre);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index nmproc01 on nmloproc (pro_keypro);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index nmtanu01 on nmlotanu (tan_keytab);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index idx_reci_erp on reci_erp (rec_cvepol);
-- dmap_object_gen_tag : type : unique name : index
set search_path = usrsiho,oracle,dmap_extension,public;
create unique index idx_r_erp_kaz01 on reci_erp (rec_cvepol, rec_fecpag);
