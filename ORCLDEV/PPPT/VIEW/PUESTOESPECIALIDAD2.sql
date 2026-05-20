-- dmap_object_gen_tag : type : view name : puestoespecialidad2
set search_path = pppt,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "puestoespecialidad2"  ("idespecialidad", "especialidad", "peso", "idpuesto", "idescolaridad") as select catespecialidad.idespecialidad,  catespecialidad.especialidad,  puestoespecialidad.peso,  puestoespecialidad.idpuesto,  puestoespecialidad.idescolaridad  from puestoespecialidad inner join catespecialidad on puestoespecialidad.idespecialidad = catespecialidad.idespecialidad;/* dmap converted statement end */
-- estimed cost of view [ puestoespecialidad2 ]: 1.00;
