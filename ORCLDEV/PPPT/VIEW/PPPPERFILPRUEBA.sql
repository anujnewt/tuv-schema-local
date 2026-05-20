-- dmap_object_gen_tag : type : view name : pppperfilprueba
set search_path = pppt,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "pppperfilprueba"  ("idperfil", "idprueba", "peso", "aux", "opciones", "resultado", "auxiliar", "bdirecto") as select     idpuesto as idperfil,  idprueba,  peso,  aux,  opciones,  resultado,  auxiliar,  bdirecto
from       puestospruebas;/* dmap converted statement end */
-- estimed cost of view [ pppperfilprueba ]: 1.00;
