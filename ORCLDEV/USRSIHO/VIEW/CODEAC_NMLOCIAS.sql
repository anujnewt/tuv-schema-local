-- dmap_object_gen_tag : type : view name : codeac_nmlocias
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "codeac_nmlocias"  ("cia_keycia", "cia_descia") as select cia_keycia, cia_descia  from nmlocias;/* dmap converted statement end */
-- estimed cost of view [ codeac_nmlocias ]: 1.00;
