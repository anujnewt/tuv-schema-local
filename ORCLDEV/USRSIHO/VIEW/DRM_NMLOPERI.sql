-- dmap_object_gen_tag : type : view name : drm_nmloperi
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "drm_nmloperi"  ("per_keypro", "per_keyper", "per_nu3aux", "per_keynom", "per_nu4aux", "per_fecpag") as select per_keypro, per_keyper, per_nu3aux, per_keynom, per_nu4aux, per_fecpag  from nmloperi;/* dmap converted statement end */
-- estimed cost of view [ drm_nmloperi ]: 1.00;
