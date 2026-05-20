-- dmap_object_gen_tag : type : view name : xxcofidi_usuarios_consulta_vw
set search_path = cofidi,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "xxcofidi_usuarios_consulta_vw"  ("usuario", "nombre_completo", "puesto", "correo_electronico", "fec_creacion", "fec_ultima_modificacion", "fec_ultimo_logeo", "fec_vigencia", "comentarios", "rol", "status", "origen_asignado", "cambiar_contrasenia", "eliminar_reg", "consulta_usuarios", "generar_reporte_usuarios", "administrar_usuarios", "consultar_bitacora", "consultar_documentos", "administrar_catalogos", "nom_empresa", "rfc", "cod_cia", "tipo_usuario") as select xut.user_name usuario,
xut.ap_paterno || ' ' || xut.ap_materno || ' ' || xut.nom_usuario
nombre_completo,
xut.puesto puesto,
xut.correo_electronico correo_electronico,
xut.fec_creacion fec_creacion,
xut.fec_ultima_modificacion fec_ultima_modificacion,
xult.fec_ultimo_logeo fec_ultimo_logeo,
xut.fec_vigencia fec_vigencia,
xut.comentarios comentarios,
xrct.rol rol,
xect.estado status,
xoct.origen origen_asignado,
case when xut.cambiar_contrasenia=1 then  'SI'  else 'NO' end  cambiar_contrasenia,
case when xut.eliminar_reg=1 then  'SI'  else 'NO' end  eliminar_reg,
case when xut.consultar_usuarios=1 then  'SI'  else 'NO' end  consulta_usuarios,
case when xut.generar_reporte_usuarios=1 then  'SI'  else 'NO' end
generar_reporte_usuarios,
case when xut.administrar_usuarios=1 then  'SI'  else 'NO' end
administrar_usuarios,
case when xut.consultar_bitacora=1 then  'SI'  else 'NO' end  consultar_bitacora,
case when xut.consultar_documentos=1 then  'SI'  else 'NO' end
consultar_documentos,
case when xut.administrar_catalogos=1 then  'SI'  else 'NO' end
administrar_catalogos,
---------------------------------------------------------------
xect.nom_empresa nom_empresa,
xect.rfc rfc,
xect.cod_cia cod_cia,
case when xut.tipo_usuario=1 then  'COFIDI'  else 'LDAP' end  tipo_usuario
from xxcofidi_usuario_tab xut
left outer join xxcofidi_usuario_login_tab xult on (xut.id_usuario_pk = xult.id_usuario_fk)
left outer join xxcofidi_origen_ct_tab xoct on (xut.id_origen_fk = xoct.id_origen_pk)
left outer join xxcofidi_usu_ori_emp_tab xuoet on (xut.id_usuario_pk = xuoet.id_usuario_fk)
left outer join xxcofidi_empresa_ct_tab xect on (xuoet.id_empresa_fk = xect.id_empresa_pk)
, xxcofidi_rol_ct_tab xrct
left outer join xxcofidi_usuario_tab xut on (xrct.id_rol_pk = xut.id_rol_fk)
where 1 = 1   and xect.id_estado_pk = xut.id_estado_fk  ------------------------------------------
order by  xut.ap_paterno;/* dmap converted statement end */
-- estimed cost of view [ xxcofidi_usuarios_consulta_vw ]: 1.40;
