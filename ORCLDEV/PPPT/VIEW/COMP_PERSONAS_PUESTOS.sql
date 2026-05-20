-- dmap_object_gen_tag : type : view name : comp_personas_puestos
set search_path = pppt,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "comp_personas_puestos"  ("idpersonal", "idpuesto", "nombre", "puesto", "total") as select compatibilidad.idpersonal,  compatibilidad.idpuesto,  personal.nombre,  puestos.puesto,  compatibilidad.total  from (compatibilidad inner join puestos on compatibilidad.idpuesto = puestos.idpuesto) inner join personal on compatibilidad.idpersonal = personal.idpersonal;/* dmap converted statement end */
-- estimed cost of view [ comp_personas_puestos ]: 1.00;
