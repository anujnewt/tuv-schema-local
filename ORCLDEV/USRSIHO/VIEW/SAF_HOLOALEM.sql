-- dmap_object_gen_tag : type : view name : saf_holoalem
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "saf_holoalem"  ("ale_keyemp", "ale_arefis") as select	ale_keyemp, ale_arefis  from holoalem;/* dmap converted statement end */
-- estimed cost of view [ saf_holoalem ]: 1.00;
