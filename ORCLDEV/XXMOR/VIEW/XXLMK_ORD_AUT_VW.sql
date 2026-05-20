-- dmap_object_gen_tag : type : view name : xxlmk_ord_aut_vw
set search_path = xxmor,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "xxlmk_ord_aut_vw"  ("id_ordhdr", "id_seg_neg", "id_archivo", "ind_proc_x_lin", "ind_garantizado", "cve_advid", "cve_mcontid", "cve_mcont_cutin", "des_email", "des_ref_folio", "cve_agyestnum", "cve_accthdrid", "des_rtcrd", "des_rtcrd_cutin", "des_coment", "des_secnum", "des_plat_canal", "id_prddes", "num_total_spts", "can_tot_sin_desc", "can_tot_con_desc", "des_tip_factur", "can_desc", "des_target", "cve_modulo", "num_ord_agen", "des_targ_afin", "des_tipo_serv", "ind_kids", "ind_fav_lo_mejor", "num_grps_totales", "num_ejecucion", "des_tipo_orden", "des_version_fich", "fec_creacion", "cve_creado_por", "fec_actualizacion", "cve_actualizado_por", "can_inversion_total", "ind_tipo_orden", "ind_estatus", "des_agrupador", "id_fza_ventas", "id_aut", "ind_tipo_aut", "id_orden", "ind_estatus_aut", "fec_creacion_aut", "cve_creado_por_aut", "fec_actualizacion_aut", "cve_actualizado_por_aut", "ind_nivel", "num_linea", "des_aut") as select
o.id_ordhdr,
o.id_seg_neg,
o.id_archivo,
o.ind_proc_x_lin,
o.ind_garantizado,
o.cve_advid,
o.cve_mcontid,
o.cve_mcont_cutin,
o.des_email,
o.des_ref_folio,
o.cve_agyestnum,
o.cve_accthdrid,
o.des_rtcrd,
o.des_rtcrd_cutin,
o.des_coment,
o.des_secnum,
o.des_plat_canal,
o.id_prddes,
o.num_total_spts,
o.can_tot_sin_desc,
o.can_tot_con_desc,
o.des_tip_factur,
o.can_desc,
o.des_target,
o.cve_modulo,
o.num_ord_agen,
o.des_targ_afin,
o.des_tipo_serv,
o.ind_kids,
o.ind_fav_lo_mejor,
o.num_grps_totales,
o.num_ejecucion,
o.des_tipo_orden,
o.des_version_fich,
o.fec_creacion,
o.cve_creado_por,
o.fec_actualizacion,
o.cve_actualizado_por,
o.can_inversion_total,
o.ind_tipo_orden,
o.ind_estatus,
o.des_agrupador,
o.id_fza_ventas,
aut.id_aut,
aut.ind_tipo_aut,
aut.id_orden,
aut.ind_estatus         ind_estatus_aut,
aut.fec_creacion        fec_creacion_aut,
aut.cve_creado_por      cve_creado_por_aut,
aut.fec_actualizacion   fec_actualizacion_aut,
aut.cve_actualizado_por cve_actualizado_por_aut,
aut.ind_nivel,
aut.num_linea,
aut.des_aut
from
xxmor.xxlmk_ordhdr_tab o
join
xxmor.xxlmk_autorizaciones_tab aut
on
o.id_ordhdr = aut.id_orden
order by
aut.num_linea asc;/* dmap converted statement end */
-- estimed cost of view [ xxlmk_ord_aut_vw ]: 1.00;
