-- dmap_object_gen_tag : type : view name : siasa_holocont
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "siasa_holocont"  ("con_keyfol", "con_keytco", "con_keydep", "con_keypue", "con_keyemp", "con_pertra", "con_idioma", "con_keynac", "con_cosuni") as select con_keyfol, con_keytco, con_keydep, con_keypue, con_keyemp, con_pertra, con_idioma, con_keynac, con_cosuni  from holocont;/* dmap converted statement end */
-- estimed cost of view [ siasa_holocont ]: 1.00;
