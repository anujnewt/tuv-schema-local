-- dmap_object_gen_tag : type : view name : xxlmk_lineas_spots_vw
set search_path = xxmor,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "xxlmk_lineas_spots_vw"  ("id_linea", "id_ordhdr", "num_linea", "cve_canal", "des_fec_ini", "des_fec_fin", "num_duracion", "id_buyunt", "des_hora_ini", "des_hora_fin", "can_spots", "can_lun", "can_mar", "can_mie", "can_jue", "can_vie", "can_sab", "can_dom", "des_tipo_servicio", "ind_bn", "ind_p", "des_marca", "des_version", "can_tar_sp_sin_desc", "can_tar_sp_con_des", "can_tot_lin_sin_desc", "can_tot_lin_con_desc", "des_sobrecargo", "des_observaciones", "des_plataforma", "pos1", "pos2", "pos3", "pos_ant", "pos_pen", "pos_ult", "fec_creacion", "cve_creado_por", "fec_actualizacion", "cve_actualizado_por", "des_campana", "can_grps", "des_sptchr", "des_usrchr", "can_spots_x_sem", "ind_estatus", "id_spot", "id_linea1", "des_fecha_break", "des_hora_inicio", "des_hora_fin1", "des_hora_break", "num_duracion1", "des_tolerancia", "ind_estatus1", "fec_creacion1", "cve_creado_por1", "fec_actualizacion1", "cve_actualizado_por1", "num_camp", "fec_ini_camp", "fec_fin_camp", "val_tarifa", "estatus_orden", "ind_tipo_orden", "cve_advid", "cve_mcontid", "nom_archivo_sol", "num_product") as select
ol.id_linea ,
ol.id_ordhdr ,
ol.num_linea ,
ol.cve_canal ,
ol.des_fec_ini ,
ol.des_fec_fin ,
ol.num_duracion ,
ol.id_buyunt ,
ol.des_hora_ini ,
ol.des_hora_fin ,
ol.can_spots ,
ol.can_lun ,
ol.can_mar ,
ol.can_mie ,
ol.can_jue ,
ol.can_vie ,
ol.can_sab ,
ol.can_dom ,
ol.des_tipo_servicio ,
ol.ind_bn ,
ol.ind_p ,
ol.des_marca ,
ol.des_version ,
ol.can_tar_sp_sin_desc ,
ol.can_tar_sp_con_des ,
ol.can_tot_lin_sin_desc ,
ol.can_tot_lin_con_desc ,
ol.des_sobrecargo ,
ol.des_observaciones ,
ol.des_plataforma ,
ol.pos1 ,
ol.pos2 ,
ol.pos3 ,
ol.pos_ant ,
ol.pos_pen ,
ol.pos_ult ,
ol.fec_creacion ,
ol.cve_creado_por ,
ol.fec_actualizacion ,
ol.cve_actualizado_por ,
ol.des_campana ,
ol.can_grps ,
ol.des_sptchr ,
ol.des_usrchr ,
ol.can_spots_x_sem ,
ol.ind_estatus ,
ls.id_spot ,
ls.id_linea id_linea1 ,
ls.des_fecha_break ,
ls.des_hora_inicio ,
ls.des_hora_fin des_hora_fin1 ,
ls.des_hora_break ,
ls.num_duracion num_duracion1 ,
ls.des_tolerancia ,
ls.ind_estatus         ind_estatus1 ,
ls.fec_creacion        fec_creacion1 ,
ls.cve_creado_por      cve_creado_por1 ,
ls.fec_actualizacion   fec_actualizacion1 ,
ls.cve_actualizado_por cve_actualizado_por1 ,
ce.num_camp,
ce.fec_ini_camp,
ce.fec_fin_camp,
coalesce(ls.val_tarifa,  0) as val_tarifa,
o.ind_estatus         as estatus_orden,
o.ind_tipo_orden,
o.cve_advid,
o.cve_mcontid,
ar.nom_archivo_sol,
ce.num_product
from
xxmor.xxlmk_ordln_tab ol
join
xxmor.xxlmk_lineas_spots_tab ls
on
ol.id_linea = ls.id_linea
join
xxmor.xxlmk_ordhdr_tab o
on
ol.id_ordhdr = o.id_ordhdr
left join
xxmor.xxlmk_camp_env_tab ce
on
case
when o.ind_tipo_orden = 1
and o.id_ordhdr = ce.id_ordhdr
and ( ( trim(both ol.des_tipo_servicio) = trim(both ce.des_tipo_servicio) )
or ( trim(both ol.des_marca) = trim(both ce.des_tipo_servicio) ) )
then 1
when(o.ind_tipo_orden = 2
or  o.ind_tipo_orden = 3)
and o.id_ordhdr = ce.id_ordhdr
and trim(both o.des_tipo_serv) = trim(both ce.des_tipo_servicio)
then 1
else 0
end = 1
join
xxmor.xxlmk_archivos_sol_tab ar
on
o.id_archivo = ar.id_archivo_sol;/* dmap converted statement end */
-- estimed cost of view [ xxlmk_lineas_spots_vw ]: 1.00;
