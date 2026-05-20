-- dmap_object_gen_tag : type : view name : personalpuestoexperiencia
set search_path = pppt,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "personalpuestoexperiencia"  ("idpuesto", "idexperiencia", "experiencia", "peso", "idpersonal") as select puestoexperiencia.idpuesto,  puestoexperiencia.idexperiencia,  catexperiencia.experiencia,  puestoexperiencia.peso,  laboral.idpersonal  from (puestoexperiencia left join catexperiencia on puestoexperiencia.idexperiencia = catexperiencia.idexperiencia) inner join laboral on puestoexperiencia.idexperiencia = laboral.funcion;/* dmap converted statement end */
-- estimed cost of view [ personalpuestoexperiencia ]: 1.00;
