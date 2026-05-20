-- dmap_object_gen_tag : type : view name : codeac_holoalem
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "codeac_holoalem"  ("ale_arefis", "ale_keyemp") as select ale_arefis, ale_keyemp  from holoalem;/* dmap converted statement end */
-- estimed cost of view [ codeac_holoalem ]: 1.00;
