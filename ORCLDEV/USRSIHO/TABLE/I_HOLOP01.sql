-- dmap_object_gen_tag : type : index name : i_holop01
set search_path = usrsiho,oracle,dmap_extension,public;
create index i_holop01 on holopres (pre_keydep, pre_keypue);
