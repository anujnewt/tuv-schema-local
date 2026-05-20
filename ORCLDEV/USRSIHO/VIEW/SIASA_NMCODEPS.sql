-- dmap_object_gen_tag : type : view name : siasa_nmcodeps
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "siasa_nmcodeps"  ("dep_keydep", "dep_desdep") as select dep_keydep, dep_desdep  from nmcodeps;/* dmap converted statement end */
-- estimed cost of view [ siasa_nmcodeps ]: 1.00;
