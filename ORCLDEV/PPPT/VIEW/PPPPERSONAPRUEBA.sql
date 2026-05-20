-- dmap_object_gen_tag : type : view name : ppppersonaprueba
set search_path = pppt,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "ppppersonaprueba"  ("idpersona", "idprueba", "fecha", "resultado") as select     idpersonal as idpersona,  idprueba,  fecha,  resultados as resultado
from         personapruebah;/* dmap converted statement end */
-- estimed cost of view [ ppppersonaprueba ]: 1.00;
