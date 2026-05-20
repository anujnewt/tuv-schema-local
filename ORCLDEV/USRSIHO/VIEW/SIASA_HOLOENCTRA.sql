-- dmap_object_gen_tag : type : view name : siasa_holoenctra
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "siasa_holoenctra"  ("enc_num_id", "enc_keydep", "enc_fecgra", "enc_keytpr", "enc_feccap", "enc_keypro", "enc_stsrep", "enc_desscc", "enc_numlla") as select enc_num_id, enc_keydep, enc_fecgra, enc_keytpr, enc_feccap, enc_keypro, enc_stsrep, enc_desscc, enc_numlla  from holoenctra;/* dmap converted statement end */
-- estimed cost of view [ siasa_holoenctra ]: 1.00;
