-- dmap_object_gen_tag : type : view name : pppconducta
set search_path = pppt,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "pppconducta"  ("idconducta", "idcompetencia", "peso", "conducta", "nivel") as select     idconducta,  idcompetencia,  peso,  conducta,  niveles as nivel
from         catconductasobs360;/* dmap converted statement end */
-- estimed cost of view [ pppconducta ]: 1.00;
