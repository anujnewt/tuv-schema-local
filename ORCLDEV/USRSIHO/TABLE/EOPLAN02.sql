-- dmap_object_gen_tag : type : index name : eoplan02
set search_path = usrsiho,oracle,dmap_extension,public;
create index eoplan02 on eoloplan (pla_keyest, pla_keypue);
