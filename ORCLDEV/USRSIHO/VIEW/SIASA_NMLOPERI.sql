-- dmap_object_gen_tag : type : view name : siasa_nmloperi
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "siasa_nmloperi"  ("per_keypro", "per_keynom", "per_keyper", "per_fecpag", "per_nummes", "per_nu3aux", "per_nu4aux") as select per_keypro, per_keynom, per_keyper, per_fecpag, per_nummes, per_nu3aux, per_nu4aux  from nmloperi;/* dmap converted statement end */
-- estimed cost of view [ siasa_nmloperi ]: 1.00;
