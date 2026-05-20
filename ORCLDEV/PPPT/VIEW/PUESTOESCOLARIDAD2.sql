-- dmap_object_gen_tag : type : view name : puestoescolaridad2
set search_path = pppt,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "puestoescolaridad2"  ("idpuesto", "idescolaridad", "escolaridad", "peso", "especialidad") as select puestoescolaridad.idpuesto,  puestoescolaridad.idescolaridad,  catescolaridad.escolaridad,  puestoescolaridad.peso,  catescolaridad.especialidad  from puestoescolaridad inner join catescolaridad on puestoescolaridad.idescolaridad = catescolaridad.idescolaridad;/* dmap converted statement end */
-- estimed cost of view [ puestoescolaridad2 ]: 1.00;
