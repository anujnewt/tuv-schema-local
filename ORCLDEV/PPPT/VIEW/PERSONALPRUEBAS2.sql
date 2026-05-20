-- dmap_object_gen_tag : type : view name : personalpruebas2
set search_path = pppt,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "personalpruebas2"  ("prueba", "x", "fecha", "idprueba", "idpuesto", "idpersonal") as select pruebas.prueba,  personalpruebas.resultado as x,  personalpruebas.fecha,  puestospruebas.idprueba,  puestospruebas.idpuesto,  personalpruebas.idpersonal  from (pruebas inner join puestospruebas on pruebas.idprueba = puestospruebas.idprueba) left join personalpruebas on puestospruebas.idprueba = personalpruebas.idprueba;/* dmap converted statement end */
-- estimed cost of view [ personalpruebas2 ]: 1.00;
