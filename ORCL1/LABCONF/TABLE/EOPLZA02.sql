-- dmap_object_gen_tag : type : index name : eoplza02
set search_path = labconf,oracle,dmap_extension,public;
create index eoplza02 on eocoplza (plz_keyemp, plz_keyest);
