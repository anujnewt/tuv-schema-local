-- dmap_object_gen_tag : type : view name : compatibilidadreporte
set search_path = pppt,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "compatibilidadreporte"  ("idpuesto", "idpersonal") as select (compatibilidad.idpuesto*-1) as idpuesto,  compatibilidad.idpersonal  from compatibilidad;/* dmap converted statement end */
-- estimed cost of view [ compatibilidadreporte ]: 1.00;
