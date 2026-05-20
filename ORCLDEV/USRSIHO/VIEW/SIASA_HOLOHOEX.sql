-- dmap_object_gen_tag : type : view name : siasa_holohoex
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "siasa_holohoex"  ("hoe_pertra", "hoe_jornad", "hoe_keytpr", "hoe_jorcos", "hoe_jortie") as select hoe_pertra, hoe_jornad, hoe_keytpr, hoe_jorcos, hoe_jortie  from holohoex;/* dmap converted statement end */
-- estimed cost of view [ siasa_holohoex ]: 1.00;
