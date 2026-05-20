-- dmap_object_gen_tag : type : view name : pppentrevista
set search_path = pppt,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "pppentrevista"  ("identrevista", "idpersona", "idperfil", "fecha", "resultado", "compatibilidad", "entrevistador", "comentarios") as select     identrevista,  idpersonal as idpersona,  idpuesto as idperfil,  fecha,  resultado,  compatibilidad,  entrevistador,  comentarios
from         ecpersonapuesto;/* dmap converted statement end */
-- estimed cost of view [ pppentrevista ]: 1.00;
