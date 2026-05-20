-- dmap_object_gen_tag : type : view name : drm_holocont
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "drm_holocont"  ("con_keyfol", "con_keyemp", "con_fecini", "con_numcap", "con_diapag", "con_tippag") as select con_keyfol, con_keyemp, con_fecini, con_numcap, con_diapag, con_tippag  from holocont;/* dmap converted statement end */
-- estimed cost of view [ drm_holocont ]: 1.00;
