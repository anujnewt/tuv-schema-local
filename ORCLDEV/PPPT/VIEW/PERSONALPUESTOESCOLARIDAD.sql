-- dmap_object_gen_tag : type : view name : personalpuestoescolaridad
set search_path = pppt,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "personalpuestoescolaridad"  ("idpuesto", "idescolaridad", "escolaridad", "peso", "especialidad", "idpersonal") as select puestoescolaridad.idpuesto,  puestoescolaridad.idescolaridad,  catescolaridad.escolaridad,  puestoescolaridad.peso,  catescolaridad.especialidad,  escolaridad.idpersonal  from escolaridad inner join(puestoescolaridad inner join catescolaridad on puestoescolaridad.idescolaridad = catescolaridad.idescolaridad) on escolaridad.grado = puestoescolaridad.idescolaridad;/* dmap converted statement end */
-- estimed cost of view [ personalpuestoescolaridad ]: 1.00;
