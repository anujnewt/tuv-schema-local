-- dmap_object_gen_tag : type : view name : pppcompetencia
set search_path = pppt,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "pppcompetencia"  ("idcompetencia", "competencia", "tipo", "idempresa", "inactiva", "definicion") as select idcompetencia,  competencia,  tipo,  idempresa,  inactiva,  definicion
from catcompetencias360;/* dmap converted statement end */
-- estimed cost of view [ pppcompetencia ]: 1.00;
