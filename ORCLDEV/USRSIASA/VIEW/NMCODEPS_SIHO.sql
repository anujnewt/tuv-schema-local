-- dmap_object_gen_tag : type : view name : nmcodeps_siho
set search_path = usrsiasa,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "nmcodeps_siho"  ("dep_keydep", "dep_desdep") as select dep_keydep, dep_desdep  from nmcodeps;/* dmap converted statement end */
-- estimed cost of view [ nmcodeps_siho ]: 1.00;
