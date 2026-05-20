-- dmap_object_gen_tag : type : view name : pppperfilentrevista
set search_path = pppt,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "pppperfilentrevista"  ("idperfil", "idcompetencia", "nivel") as select     idpuesto as idperfil,  idcompetencia,  nivel
from         ecpuestocompetencianivel;/* dmap converted statement end */
-- estimed cost of view [ pppperfilentrevista ]: 1.00;
