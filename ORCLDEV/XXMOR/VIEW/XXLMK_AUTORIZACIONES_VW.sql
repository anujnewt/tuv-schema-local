-- dmap_object_gen_tag : type : view name : xxlmk_autorizaciones_vw
set search_path = xxmor,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "xxlmk_autorizaciones_vw"  ("id_ordhdr", "id_seg_neg", "id_archivo", "ind_proc_x_lin", "ind_garantizado", "cve_advid", "cve_mcontid", "cve_mcont_cutin", "des_email", "des_ref_folio", "cve_agyestnum", "cve_accthdrid", "des_rtcrd", "des_rtcrd_cutin", "des_coment", "des_secnum", "des_plat_canal", "id_prddes", "num_total_spts", "can_tot_sin_desc", "can_tot_con_desc", "des_tip_factur", "can_desc", "des_target", "cve_modulo", "num_ord_agen", "des_targ_afin", "des_tipo_serv", "ind_kids", "ind_fav_lo_mejor", "num_grps_totales", "num_ejecucion", "des_tipo_orden", "des_version_fich", "fec_creacion", "cve_creado_por", "fec_actualizacion", "cve_actualizado_por", "can_inversion_total", "ind_tipo_orden", "ind_estatus", "des_agrupador", "id_fza_ventas", "auth_tm", "auth_cc", "auth_urg", "auth_oplg", "nom_archivo_sol", "repr_spots", "auth_ext") as select
all_ords.id_ordhdr,
all_ords.id_seg_neg,
all_ords.id_archivo,
all_ords.ind_proc_x_lin,
all_ords.ind_garantizado,
all_ords.cve_advid,
all_ords.cve_mcontid,
all_ords.cve_mcont_cutin,
all_ords.des_email,
all_ords.des_ref_folio,
all_ords.cve_agyestnum,
all_ords.cve_accthdrid,
all_ords.des_rtcrd,
all_ords.des_rtcrd_cutin,
all_ords.des_coment,
all_ords.des_secnum,
all_ords.des_plat_canal,
all_ords.id_prddes,
all_ords.num_total_spts,
all_ords.can_tot_sin_desc,
all_ords.can_tot_con_desc,
all_ords.des_tip_factur,
all_ords.can_desc,
all_ords.des_target,
all_ords.cve_modulo,
all_ords.num_ord_agen,
all_ords.des_targ_afin,
all_ords.des_tipo_serv,
all_ords.ind_kids,
all_ords.ind_fav_lo_mejor,
all_ords.num_grps_totales,
all_ords.num_ejecucion,
all_ords.des_tipo_orden,
all_ords.des_version_fich,
all_ords.fec_creacion,
all_ords.cve_creado_por,
all_ords.fec_actualizacion,
all_ords.cve_actualizado_por,
all_ords.can_inversion_total,
all_ords.ind_tipo_orden,
all_ords.ind_estatus,
all_ords.des_agrupador,
all_ords.id_fza_ventas,
all_ords.auth_tm,
all_ords.auth_cc,
all_ords.auth_urg,
all_ords.auth_oplg,
all_ords.nom_archivo_sol,
all_ords.repr_spots,
all_ords.auth_ext
from (
select
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
coalesce(tm.auth, 0)   as auth_tm,
0 as auth_cc,
coalesce(urg.auth, 0)  as auth_urg,
coalesce(oplg.auth, 0) as auth_oplg,
a.nom_archivo_sol,
case
when o.ind_estatus = 8
or  o.ind_estatus = 9.5
or  o.ind_estatus = 20
then 2
when coalesce(repr.auth, 0) = 1
or  o.ind_estatus = 9.7
then 1
else 0
end                           as repr_spots,
coalesce(ext.auth, 0) as "auth_ext"
from
xxmor.xxlmk_ordhdr_tab o
join
xxmor.xxlmk_archivos_sol_tab a
on
o.id_archivo = a.id_archivo_sol
left join(
select
a.id_orden,
1 as "auth"
from
xxmor.xxlmk_autorizaciones_tab a
where
a.ind_tipo_aut = 'TM'
and a.ind_estatus = 1
group by
id_orden) tm
on
o.id_ordhdr = tm.id_orden
left join(
select
a.id_orden,
1 as "auth"
from
xxmor.xxlmk_autorizaciones_tab a
where
a.ind_tipo_aut = 'URG'
and a.ind_estatus = 1
group by
id_orden) urg
on
o.id_ordhdr = urg.id_orden
left join(
select
a.id_orden,
1 as "auth"
from
xxmor.xxlmk_autorizaciones_tab a
where
a.ind_tipo_aut = 'OPLG'
and a.ind_estatus = 1
group by
id_orden) oplg
on
o.id_ordhdr = oplg.id_orden
left join(
select
a.id_orden,
1 as "auth"
from
xxmor.xxlmk_autorizaciones_tab a
where
a.ind_tipo_aut = 'EXT'
and a.ind_estatus = 1
group by
id_orden) ext
on
o.id_ordhdr = ext.id_orden
left join(
select
ol.id_ordhdr,
1 as "auth"
from
xxmor.xxlmk_lineas_spots_tab ls
join
xxmor.xxlmk_ordln_tab ol
on
ls.id_linea = ol.id_linea
where
ls.ind_estatus = 6
group by
id_ordhdr) repr
on
o.id_ordhdr = repr.id_ordhdr) all_ords
where
all_ords.auth_tm != 0 -- autoriaciones tarifa manual
or  all_ords.auth_cc != 0 -- autoriaciones tarifa manual
or  all_ords.auth_urg != 0 -- autorizaciones urgentes
or  all_ords.auth_oplg != 0 -- autorizaciones open log
or  all_ords.auth_ext != 0 -- autorizaciones extemporaneas
or  all_ords.repr_spots != 0 -- reprocesos
or  all_ords.ind_estatus = 3 -- con autorizaciones
or  all_ords.ind_estatus = 9.7 -- error al colocar spots
or  all_ords.ind_estatus = 8 -- reprocesando
;/* dmap converted statement end */
-- estimed cost of view [ xxlmk_autorizaciones_vw ]: 1.00;
