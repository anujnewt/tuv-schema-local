-- dmap_object_gen_tag : type : index name : glmenu01
set search_path = labppto,oracle,dmap_extension,public;
create index glmenu01 on glcomenu (men_keymen, men_gpomen);
