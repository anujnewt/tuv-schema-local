-- dmap_object_gen_tag : type : view name : drm_nmloalde
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "drm_nmloalde"  ("ald_keydep", "ald_keytpr") as select ald_keydep, ald_keytpr  from nmloalde;/* dmap converted statement end */
-- estimed cost of view [ drm_nmloalde ]: 1.00;
