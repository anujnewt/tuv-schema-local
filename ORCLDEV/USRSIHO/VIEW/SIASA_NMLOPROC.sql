-- dmap_object_gen_tag : type : view name : siasa_nmloproc
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "siasa_nmloproc"  ("pro_keypro", "pro_despro") as select pro_keypro, pro_despro  from nmloproc;/* dmap converted statement end */
-- estimed cost of view [ siasa_nmloproc ]: 1.00;
