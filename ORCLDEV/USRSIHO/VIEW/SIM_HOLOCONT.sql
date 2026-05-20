-- dmap_object_gen_tag : type : view name : sim_holocont
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "sim_holocont"  ("con_keyplz", "con_keyfol", "con_keydep", "con_diapag", "con_fecini", "con_cosuni", "con_numcap", "con_keyemp", "con_keypue", "con_keytco", "con_stspag", "con_keytva", "con_fecoto", "con_keyusg") as select con_keyplz, con_keyfol, con_keydep, con_diapag, con_fecini, con_cosuni, con_numcap, con_keyemp, con_keypue, con_keytco, con_stspag, con_keytva , con_fecoto, con_keyusg  from holocont;/* dmap converted statement end */
-- estimed cost of view [ sim_holocont ]: 1.00;
