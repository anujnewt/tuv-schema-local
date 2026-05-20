-- dmap_object_gen_tag : type : index name : enc_tra2
set search_path = usrsiho,oracle,dmap_extension,public;
create index enc_tra2 on holoenctra (enc_keydep, enc_fecgra);
