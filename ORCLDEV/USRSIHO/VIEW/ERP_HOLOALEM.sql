-- dmap_object_gen_tag : type : view name : erp_holoalem
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "erp_holoalem"  ("ale_keyemp", "ale_keytco", "ale_numext", "ale_numint", "ale_paisrs", "ale_origen") as select ale_keyemp, ale_keytco, ale_numext, ale_numint, ale_paisrs, ale_origen   from usrsiho.holoalem;/* dmap converted statement end */
-- estimed cost of view [ erp_holoalem ]: 1.00;
