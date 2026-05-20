-- dmap_object_gen_tag : type : view name : codeac_holocont_sdw2
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "codeac_holocont_sdw2"  ("con_keyemp", "con_keydep", "con_keypue", "con_fecini", "con_keytco", "consec", "con_keyfol", "estatus", "con_feccan") as select con_keyemp, con_keydep, con_keypue, con_fecini, con_keytco, consec, con_keyfol, estatus, con_feccan  from holocont_sdw2;/* dmap converted statement end */
-- estimed cost of view [ codeac_holocont_sdw2 ]: 1.00;
