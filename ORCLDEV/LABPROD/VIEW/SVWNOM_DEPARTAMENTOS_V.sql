-- dmap_object_gen_tag : type : view name : svwnom_departamentos_v
set search_path = labprod,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "svwnom_departamentos_v"  ("dep_keydep", "dep_desdep") as select dep_keydep
, dep_desdep
from labprod.nmcodeps
where length(dep_keydep)=10;/* dmap converted statement end */
-- estimed cost of view [ svwnom_departamentos_v ]: 1.00;
