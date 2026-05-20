-- dmap_object_gen_tag : type : index name : holopl01
set search_path = usrsiho,oracle,dmap_extension,public;
create index holopl01 on holoplza (plz_ctvplz, plz_keyfol);
