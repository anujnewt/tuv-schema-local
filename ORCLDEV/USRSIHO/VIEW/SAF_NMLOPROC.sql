-- dmap_object_gen_tag : type : view name : saf_nmloproc
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "saf_nmloproc"  ("pro_keypro", "pro_despro", "pro_diaper") as select	pro_keypro, pro_despro, pro_diaper  from nmloproc;/* dmap converted statement end */
-- estimed cost of view [ saf_nmloproc ]: 1.00;
