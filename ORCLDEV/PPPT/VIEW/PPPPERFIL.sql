-- dmap_object_gen_tag : type : view name : pppperfil
set search_path = pppt,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "pppperfil"  ("idperfil", "perfil", "nivel", "idempresa", "bateria", "idnivel", "notaperfil") as select idpuesto as idperfil,  puesto as perfil,  nivel,  idempresa,  bateria,  idnivel,  notaperfil
from puestos;/* dmap converted statement end */
-- estimed cost of view [ pppperfil ]: 1.00;
