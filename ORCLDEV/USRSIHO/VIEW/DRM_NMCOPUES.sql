-- dmap_object_gen_tag : type : view name : drm_nmcopues
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "drm_nmcopues"  ("pue_keypue", "pue_despue") as select pue_keypue, pue_despue  from nmcopues;/* dmap converted statement end */
-- estimed cost of view [ drm_nmcopues ]: 1.00;
