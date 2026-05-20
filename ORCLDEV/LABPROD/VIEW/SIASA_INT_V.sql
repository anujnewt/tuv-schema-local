-- dmap_object_gen_tag : type : view name : siasa_int_v
set search_path = labprod,oracle,dmap_extension,public;
 /* dmap converted statement start */
create or replace view "siasa_int_v"  ("numero_asociado", "nombre", "ant_remanente_dis", "estatus", "fecha_pago", "fecha_proceso", "area", "subcuenta", "concepto", "hem_keypro", "pro_despro", "cve_actividad", "actividad", "centro_costos", "desc_centro_costos", "cve_empresa", "nombre_empresa", "fecha_ingreso", "fecha_baja", "plaza", "periodo", "per_fecini", "per_fecfin", "per_nummes", "per_keynom", "his_ca1aux", "his_keypue", "his_keycon", "pro_diaper", "his_cantid", "his_import") as select
hem_keyemp numero_asociado,
emp_nomemp nombre,
hem_salmes ant_remanente_dis,
'pagado' estatus,
per_fecpag fecha_pago,
per_fecact fecha_proceso,
loc_desloc area,
'000000' subcuenta,
con_descon concepto,
hem_keypro,
pro_despro,
hem_keypue cve_actividad,
pue_despue actividad,
oracle.substr(dep_refcon,  15,  8) centro_costos,
cen_descen desc_centro_costos,
cia_ca3aux cve_empresa,
cia_descia nombre_empresa,
hem_fecing fecha_ingreso,
hem_fecbaj fecha_baja,
hal_keyplz plaza,
per_keyper periodo,
per_fecini,
per_fecfin,
per_nummes,
per_keynom,
his_ca1aux,
his_keypue,
his_keycon,
pro_diaper,
his_cantid,
his_import
from labprod.tvlohalt, labprod.nmlolocp, labprod.nmlohemp, labprod.nmlocepro, labprod.nmcopues, labprod.nmcoempl, labprod.nmcodeps, (select
*
from
labprod.nmloperi   nmloperi,
labprod.nmloproc   nmloproc,
labprod.nmloconc   nmloconc,
labprod.nmlohism   nmlohism,
labprod.nmlocias   nmlocias
where (1=1) and (nmlohism.his_keypro in (3,8,77,10,12,19,5,66,81,60)) and (nmlohism.his_keycon in ('250','260','001','f26')) and (nmloperi.per_keynom = 1) and (nmlohism.his_keyper=nmloperi.per_keyper) and (nmlohism.his_keypro=nmloperi.per_keypro) and (nmlohism.his_keypro=nmloproc.pro_keypro) and (nmlohism.his_keycon=nmloconc.con_keycon) and (cia_keycia = pro_keycia)) alias12
where (1=1);
 /* dmap converted statement end */
-- estimed cost of view [ siasa_int_v ]: 1.00;
