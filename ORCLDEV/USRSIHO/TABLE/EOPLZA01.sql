-- dmap_object_gen_tag : type : index name : eoplza01
set search_path = usrsiho,oracle,dmap_extension,public;
create index eoplza01 on eocoplza (plz_keyest, plz_keydep, plz_keypue);
