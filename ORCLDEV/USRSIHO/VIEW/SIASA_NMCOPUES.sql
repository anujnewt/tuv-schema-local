-- dmap_object_gen_tag : type : view name : siasa_nmcopues
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "siasa_nmcopues"  ("pue_keypue", "pue_despue", "pue_ca4aux") as select pue_keypue, pue_despue, pue_ca4aux  from nmcopues;/* dmap converted statement end */
-- estimed cost of view [ siasa_nmcopues ]: 1.00;
