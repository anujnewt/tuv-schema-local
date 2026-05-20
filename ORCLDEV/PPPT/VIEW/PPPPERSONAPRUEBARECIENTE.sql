-- dmap_object_gen_tag : type : view name : ppppersonapruebareciente
set search_path = pppt,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "ppppersonapruebareciente"  ("idpersona", "idprueba", "fecha", "resultado") as select     ppppersonaprueba.idpersona, ppppersonaprueba.idprueba, ppppersonaprueba.fecha, ppppersonaprueba.resultado
from         ppppersonaprueba inner join(select     idpersona, idprueba, max(fecha) as "fecha"
from          ppppersonaprueba unica
group by idpersona, idprueba) ultima on ppppersonaprueba.idpersona = ultima.idpersona and
ppppersonaprueba.idprueba = ultima.idprueba and ppppersonaprueba.fecha = ultima.fecha;/* dmap converted statement end */
-- estimed cost of view [ ppppersonapruebareciente ]: 1.00;
