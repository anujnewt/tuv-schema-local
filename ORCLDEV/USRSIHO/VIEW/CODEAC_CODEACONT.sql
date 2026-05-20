-- dmap_object_gen_tag : type : view name : codeac_codeacont
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "codeac_codeacont"  ("con_keyemp", "con_fecven", "con_keyplz", "con_fecoto") as select con_keyemp, con_fecven, con_keyplz, con_fecoto  from codeacont;/* dmap converted statement end */
-- estimed cost of view [ codeac_codeacont ]: 1.00;
