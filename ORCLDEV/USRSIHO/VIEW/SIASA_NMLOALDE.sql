-- dmap_object_gen_tag : type : view name : siasa_nmloalde
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "siasa_nmloalde"  ("ald_keydep", "ald_keytpr", "ald_keyemp", "ald_pertra") as select ald_keydep, ald_keytpr, ald_keyemp, ald_pertra  from nmloalde;/* dmap converted statement end */
-- estimed cost of view [ siasa_nmloalde ]: 1.00;
