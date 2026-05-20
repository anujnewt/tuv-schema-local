-- dmap_object_gen_tag : type : view name : codeac_nmcodeps_sdw
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "codeac_nmcodeps_sdw"  ("marca_act", "cmd", "old_dep_keydep", "old_dep_desdep", "new_dep_keydep", "new_dep_desdep", "orderid1", "orderid2") as select marca_act, cmd, old_dep_keydep, old_dep_desdep, new_dep_keydep, new_dep_desdep, orderid1, orderid2  from nmcodeps_sdw;/* dmap converted statement end */
-- estimed cost of view [ codeac_nmcodeps_sdw ]: 1.00;
