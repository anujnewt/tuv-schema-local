-- dmap_object_gen_tag : type : view name : siasa_nmloconc
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "siasa_nmloconc"  ("con_keycon", "con_descon") as select con_keycon, con_descon  from nmloconc;/* dmap converted statement end */
-- estimed cost of view [ siasa_nmloconc ]: 1.00;
