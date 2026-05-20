-- dmap_object_gen_tag : type : view name : sim_nmcodeps
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "sim_nmcodeps"  ("dep_keydep", "dep_desdep") as select dep_keydep, dep_desdep  from nmcodeps;/* dmap converted statement end */
-- estimed cost of view [ sim_nmcodeps ]: 1.00;
