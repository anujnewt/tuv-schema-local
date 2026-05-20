-- dmap_object_gen_tag : type : view name : xxlmk_orden_cc_vw
set search_path = xxmor,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "xxlmk_orden_cc_vw"  ("id_ordhdr", "id_seg_neg", "id_archivo", "ind_proc_x_lin", "ind_garantizado", "cve_advid", "cve_mcontid", "cve_mcont_cutin", "des_email", "des_ref_folio", "cve_agyestnum", "cve_accthdrid", "des_rtcrd", "des_rtcrd_cutin", "des_coment", "des_secnum", "des_plat_canal", "id_prddes", "num_total_spts", "can_tot_sin_desc", "can_tot_con_desc", "des_tip_factur", "can_desc", "des_target", "cve_modulo", "num_ord_agen", "des_targ_afin", "des_tipo_serv", "ind_kids", "ind_fav_lo_mejor", "num_grps_totales", "num_ejecucion", "des_tipo_orden", "des_version_fich", "can_inversion_total", "id_sol_cc", "id_orden", "ind_estatus", "ind_rechazo_gestor", "id_motivo_ar_cc", "des_coment_ar_cc", "num_carga", "fec_creacion", "cve_creado_por", "fec_actualizacion", "cve_actualizado_por", "ind_tipo_orden") as select
ord.id_ordhdr,
ord.id_seg_neg,
ord.id_archivo,
ord.ind_proc_x_lin,
ord.ind_garantizado,
ord.cve_advid,
ord.cve_mcontid,
ord.cve_mcont_cutin,
ord.des_email,
ord.des_ref_folio,
ord.cve_agyestnum,
ord.cve_accthdrid,
ord.des_rtcrd,
ord.des_rtcrd_cutin,
ord.des_coment,
ord.des_secnum,
ord.des_plat_canal,
ord.id_prddes,
ord.num_total_spts,
ord.can_tot_sin_desc,
ord.can_tot_con_desc,
ord.des_tip_factur,
ord.can_desc,
ord.des_target,
ord.cve_modulo,
ord.num_ord_agen,
ord.des_targ_afin,
ord.des_tipo_serv,
ord.ind_kids,
ord.ind_fav_lo_mejor,
ord.num_grps_totales,
ord.num_ejecucion,
ord.des_tipo_orden,
ord.des_version_fich,
ord.can_inversion_total,
cc.id_sol_cc,
cc.id_orden,
cc.ind_estatus,
cc.ind_rechazo_gestor,
cc.id_motivo_ar_cc,
cc.des_coment_ar_cc,
cc.num_carga,
cc.fec_creacion,
cc.cve_creado_por,
cc.fec_actualizacion,
cc.cve_actualizado_por,
ord.ind_tipo_orden
from
xxmor.xxlmk_ordhdr_tab ord
join
xxmor.xxlmk_credito_corporativo_tab cc
on
ord.id_ordhdr = cc.id_orden
where
cc.ind_estatus = 2
or  cc.ind_estatus = 5;/* dmap converted statement end */
-- estimed cost of view [ xxlmk_orden_cc_vw ]: 1.00;
