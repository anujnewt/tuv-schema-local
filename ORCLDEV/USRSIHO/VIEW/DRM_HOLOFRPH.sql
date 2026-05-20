-- dmap_object_gen_tag : type : view name : drm_holofrph
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "drm_holofrph"  ("frp_keydep", "frp_fectrab", "frp_keyrph", "frp_keypro", "frp_keyper") as select frp_keydep, frp_fectrab, frp_keyrph, frp_keypro, frp_keyper  from holofrph;/* dmap converted statement end */
-- estimed cost of view [ drm_holofrph ]: 1.00;
