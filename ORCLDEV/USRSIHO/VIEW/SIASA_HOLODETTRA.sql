-- dmap_object_gen_tag : type : view name : siasa_holodettra
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "siasa_holodettra"  ("det_num_id", "det_keydep", "det_fecgra", "det_keytco", "det_sindkto", "det_keyfol", "det_keyemp", "det_nomcor", "det_person", "det_keypue", "det_noforo", "det_hralla", "det_hraent", "det_hrasal", "det_capgra", "det_stsreg", "det_inanda", "det_capini", "det_capfin", "det_tipinc", "det_cosuni") as select
det_num_id, det_keydep, det_fecgra, det_keytco, det_sindkto, det_keyfol, det_keyemp, det_nomcor, det_person, det_keypue, det_noforo,
det_hralla, det_hraent, det_hrasal, det_capgra, det_stsreg, det_inanda, det_capini, det_capfin, det_tipinc, det_cosuni  from holodettra;/* dmap converted statement end */
-- estimed cost of view [ siasa_holodettra ]: 1.00;
