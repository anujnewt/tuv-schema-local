-- dmap_object_gen_tag : type : view name : puestoexperiencia2
set search_path = pppt,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "puestoexperiencia2"  ("idpuesto", "idexperiencia", "experiencia", "peso") as select puestoexperiencia.idpuesto,  puestoexperiencia.idexperiencia,  catexperiencia.experiencia,  puestoexperiencia.peso  from puestoexperiencia left join catexperiencia on puestoexperiencia.idexperiencia = catexperiencia.idexperiencia;/* dmap converted statement end */
-- estimed cost of view [ puestoexperiencia2 ]: 1.00;
