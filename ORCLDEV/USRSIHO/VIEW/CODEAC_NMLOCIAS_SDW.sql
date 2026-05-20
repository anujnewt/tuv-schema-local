-- dmap_object_gen_tag : type : view name : codeac_nmlocias_sdw
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "codeac_nmlocias_sdw"  ("marca_act", "cmd", "old_cia_keycia", "old_cia_descia", "new_cia_keycia", "new_cia_descia", "orderid1", "orderid2") as select marca_act, cmd, old_cia_keycia, old_cia_descia, new_cia_keycia, new_cia_descia, orderid1, orderid2  from nmlocias_sdw;/* dmap converted statement end */
-- estimed cost of view [ codeac_nmlocias_sdw ]: 1.00;
