-- dmap_object_gen_tag : type : view name : codeac_nmloproc
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "codeac_nmloproc"  ("pro_keypro", "pro_keycia") as select pro_keypro, pro_keycia  from nmloproc;/* dmap converted statement end */
-- estimed cost of view [ codeac_nmloproc ]: 1.00;
