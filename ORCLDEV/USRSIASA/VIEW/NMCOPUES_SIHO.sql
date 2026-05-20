-- dmap_object_gen_tag : type : view name : nmcopues_siho
set search_path = usrsiasa,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "nmcopues_siho"  ("pue_keypue", "pue_despue", "pue_ca4aux") as select pue_keypue, pue_despue, pue_ca4aux  from nmcopues;/* dmap converted statement end */
-- estimed cost of view [ nmcopues_siho ]: 1.00;
