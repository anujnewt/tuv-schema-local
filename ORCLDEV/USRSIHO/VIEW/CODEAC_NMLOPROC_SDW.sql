-- dmap_object_gen_tag : type : view name : codeac_nmloproc_sdw
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "codeac_nmloproc_sdw"  ("marca_act", "cmd", "old_pro_keypro", "old_pro_despro", "old_pro_keycia", "new_pro_keycia", "new_pro_keypro", "new_pro_despro", "orderid1", "orderid2") as select marca_act, cmd, old_pro_keypro, old_pro_despro, old_pro_keycia, new_pro_keycia, new_pro_keypro, new_pro_despro, orderid1, orderid2  from nmloproc_sdw;/* dmap converted statement end */
-- estimed cost of view [ codeac_nmloproc_sdw ]: 1.00;
