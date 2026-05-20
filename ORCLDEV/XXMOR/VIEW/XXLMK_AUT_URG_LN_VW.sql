-- dmap_object_gen_tag : type : view name : xxlmk_aut_urg_ln_vw
set search_path = xxmor,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "xxlmk_aut_urg_ln_vw"  ("id_linea", "id_ordhdr", "num_linea", "cve_canal", "des_fec_ini", "des_fec_fin", "num_duracion", "id_buyunt", "des_hora_ini", "des_hora_fin", "can_spots", "can_lun", "can_mar", "can_mie", "can_jue", "can_vie", "can_sab", "can_dom", "des_tipo_servicio", "ind_bn", "ind_p", "des_marca", "des_version", "can_tar_sp_sin_desc", "can_tar_sp_con_des", "can_tot_lin_sin_desc", "can_tot_lin_con_desc", "des_sobrecargo", "des_observaciones", "des_plataforma", "pos1", "pos2", "pos3", "pos_ant", "pos_pen", "pos_ult", "fec_creacion", "cve_creado_por", "fec_actualizacion", "cve_actualizado_por", "des_campana", "can_grps", "des_sptchr", "des_usrchr", "can_spots_x_sem", "ind_estatus", "id_aut", "id_orden", "ind_estatus_aut", "ind_tipo_aut", "ind_nivel", "num_linea_aut", "des_aut") as select
o.id_linea,
o.id_ordhdr,
o.num_linea,
o.cve_canal,
o.des_fec_ini,
o.des_fec_fin,
o.num_duracion,
o.id_buyunt,
o.des_hora_ini,
o.des_hora_fin,
o.can_spots,
o.can_lun,
o.can_mar,
o.can_mie,
o.can_jue,
o.can_vie,
o.can_sab,
o.can_dom,
o.des_tipo_servicio,
o.ind_bn,
o.ind_p,
o.des_marca,
o.des_version,
o.can_tar_sp_sin_desc,
o.can_tar_sp_con_des,
o.can_tot_lin_sin_desc,
o.can_tot_lin_con_desc,
o.des_sobrecargo,
o.des_observaciones,
o.des_plataforma,
o.pos1,
o.pos2,
o.pos3,
o.pos_ant,
o.pos_pen,
o.pos_ult,
o.fec_creacion,
o.cve_creado_por,
o.fec_actualizacion,
o.cve_actualizado_por,
o.des_campana,
o.can_grps,
o.des_sptchr,
o.des_usrchr,
o.can_spots_x_sem,
o.ind_estatus,
aut.id_aut,
aut.id_orden,
coalesce(aut.ind_estatus,  0) as ind_estatus_aut,
aut.ind_tipo_aut,
aut.ind_nivel,
aut.num_linea as num_linea_aut,
aut.des_aut
from
xxlmk_ordln_tab    o
join(select * from
xxlmk_autorizaciones_tab    a
where a.ind_nivel       = 'L'
and   a.ind_tipo_aut    = 'URG'
) aut
on o.id_ordhdr = aut.id_orden
and o.num_linea = aut.num_linea;/* dmap converted statement end */
-- estimed cost of view [ xxlmk_aut_urg_ln_vw ]: 1.00;
