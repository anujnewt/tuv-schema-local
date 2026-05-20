-- dmap_object_gen_tag : type : view name : codeac_nmcodeps
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "codeac_nmcodeps"  ("dep_keydep", "dep_desdep", "dep_nu4aux", "dep_nu5aux", "dep_nu3aux") as select dep_keydep, dep_desdep, dep_nu4aux, dep_nu5aux, dep_nu3aux  from nmcodeps;/* dmap converted statement end */
-- estimed cost of view [ codeac_nmcodeps ]: 1.00;
