-- dmap_object_gen_tag : type : view name : codeac_holocont
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "codeac_holocont"  ("con_stspag", "con_feccan", "con_keyemp", "con_keyfol", "con_fecven", "con_keyplz", "con_fecoto", "con_keytco", "con_keypue", "con_fecini") as select con_stspag, con_feccan, con_keyemp, con_keyfol, con_fecven, con_keyplz, con_fecoto, con_keytco, con_keypue, con_fecini  from holocont;/* dmap converted statement end */
-- estimed cost of view [ codeac_holocont ]: 1.00;
