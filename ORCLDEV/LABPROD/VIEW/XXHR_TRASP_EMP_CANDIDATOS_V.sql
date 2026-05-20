-- dmap_object_gen_tag : type : view name : xxhr_trasp_emp_candidatos_v
set search_path = labprod,oracle,dmap_extension,public;/* dmap converted statement start */

create or replace view "xxhr_trasp_emp_candidatos_v"  ("no_candidato", "no_empleado", "sexo", "curp", "rfc", "imss", "fecha_contratacion", "fecha_nacimiento", "ciudad_nacimiento", "pais_de_nacimiento", "nacionalidad", "estado_civil", "correo_electronico", "clave_infonavit", "permiso_migratorio", "fecha_de_antiguedad", "fecha_de_venc_del_contrato", "fecha_planta", "fecha_de_reingreso", "submovimiento", "dias_de_venc_del_contrato", "fecha_venc_permiso_migratorio", "forma_de_pago", "cuenta_bancaria", "sucursal", "descuento_infonavit", "usuario_mam", "estatus_interface", "fecha_interface") as select
cand.idcandidato no_candidato,
trasp.no_empleado,
trasp.sexo,
trasp.curp,
trasp.rfc,
trasp.imss,
trasp.fecha_contratacion,
trasp.fecha_nacimiento,
trasp.ciudad_nacimiento,
trasp.pais_de_nacimiento,
trasp.nacionalidad,
trasp.estado_civil,
trasp.correo_electronico,
trasp.clave_infonavit,
trasp.permiso_migratorio,
trasp.fecha_de_antiguedad,
trasp.fecha_de_venc_del_contrato,
trasp.fecha_planta,
trasp.fecha_de_reingreso,
trasp.submovimiento,
trasp.dias_de_venc_del_contrato,
trasp.fecha_venc_permiso_migratorio,
trasp.forma_de_pago,
trasp.cuenta_bancaria,
trasp.sucursal,
trasp.descuento_infonavit,
trasp.usuario_mam,
trasp.estatus_interface,
trasp.fecha_interface
from labprod.xxhr_trasp_emp_candidatos trasp
inner join labprod.xxhr_crear_candidatos_lab cand on trasp.no_empleado::VARCHAR = cand.emp_keyemp::VARCHAR
where nullif(cand.idcandidato::text, '') is not null;/* dmap converted statement end */
-- estimed cost of view [ xxhr_trasp_emp_candidatos_v ]: 1.00;
