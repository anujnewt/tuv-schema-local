-- dmap_object_gen_tag : type : view name : ppppersona
set search_path = pppt,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "ppppersona"  ("idpersona", "nombre", "email", "clave", "idprefijo", "folio", "login", "password") as select     personal.idpersonal as idpersona,  personal.nombre,  personal.email,  personal.clave,  prefijo.idprefijo,  personal.folio,
personal.email as "login",   personalpassword.password
from         prefijo right outer join
personal on prefijo.prefijo = personal.prefijo left outer join
personalpassword on prefijo.idprefijo = personalpassword.idprefijo and personal.folio = personalpassword.folio;/* dmap converted statement end */
-- estimed cost of view [ ppppersona ]: 1.00;
