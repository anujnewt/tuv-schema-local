-- dmap_object_gen_tag : type : view name : pppprueba
set search_path = pppt,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "pppprueba"  ("idprueba", "prueba", "bincluye", "bpondera", "bperfila", "binterpreta", "secuencia", "activa", "descripcion", "bautoservicio") as select     pruebas.idprueba, pruebas.prueba, pruebas.bincluye, pruebas.bpondera, pruebas.bperfila, pruebas.binterpreta, pruebas.secuencia, pruebas.activa, pruebas.descripcion, pruebas.bautoservicio
from         pruebas;/* dmap converted statement end */
-- estimed cost of view [ pppprueba ]: 1.00;
