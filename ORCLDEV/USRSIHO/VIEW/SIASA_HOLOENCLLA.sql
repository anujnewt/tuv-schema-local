-- dmap_object_gen_tag : type : view name : siasa_holoenclla
set search_path = usrsiho,oracle,dmap_extension,public;/* dmap converted statement start */
create or replace view "siasa_holoenclla"  ("enc_num_id", "enc_feclla", "enc_feccap") as select enc_num_id, enc_feclla, enc_feccap  from holoenclla;/* dmap converted statement end */
-- estimed cost of view [ siasa_holoenclla ]: 1.00;
