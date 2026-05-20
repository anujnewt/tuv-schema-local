-- dmap_object_gen_tag : type : index name : webita_idx01
set search_path = labconf,oracle,dmap_extension,public;
create index webita_idx01 on webitacora (bit_keyemp, bit_fecha);
