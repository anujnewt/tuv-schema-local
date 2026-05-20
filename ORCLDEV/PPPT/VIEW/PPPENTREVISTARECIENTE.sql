-- dmap_object_gen_tag : type : view name : pppentrevistareciente
set search_path = pppt,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "pppentrevistareciente"  ("identrevista", "idpersona", "idperfil", "fecha", "resultado", "compatibilidad", "entrevistador", "comentarios") as select     pppentrevista.identrevista, pppentrevista.idpersona, pppentrevista.idperfil, pppentrevista.fecha, pppentrevista.resultado, pppentrevista.compatibilidad, pppentrevista.entrevistador, pppentrevista.comentarios
from         pppentrevista inner join(select     idpersona, idperfil, max(fecha) as "fecha"
from          pppentrevista unica
group by idpersona, idperfil) ultima on pppentrevista.idpersona = ultima.idpersona and pppentrevista.idperfil = ultima.idperfil and
pppentrevista.fecha = ultima.fecha;/* dmap converted statement end */
-- estimed cost of view [ pppentrevistareciente ]: 1.00;
