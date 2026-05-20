-- dmap_object_gen_tag : type : view name : siasa_nmlonomi
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "siasa_nmlonomi"  ("nom_keynom", "nom_destip") as select nom_keynom, nom_destip  from nmlonomi
c;/* dmap converted statement end */
-- estimed cost of view [ siasa_nmlonomi ]: 1.00;
