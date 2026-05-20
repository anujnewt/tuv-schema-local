-- dmap_object_gen_tag : type : view name : saf_nmloctas
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "saf_nmloctas"  ("cta_keypro", "cta_keyemp", "cta_ctaban") as select	cta_keypro, cta_keyemp, cta_ctaban  from nmloctas;/* dmap converted statement end */
-- estimed cost of view [ saf_nmloctas ]: 1.00;
