-- dmap_object_gen_tag : type : view name : ppppersonaperfil
set search_path = pppt,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "ppppersonaperfil"  ("idperfil", "idpersona") as select     puesto as idperfil,  idpersonal as idpersona
from         personal
where (nullif(puesto::text, '') is not null and puesto > 0);/* dmap converted statement end */
-- estimed cost of view [ ppppersonaperfil ]: 1.00;
