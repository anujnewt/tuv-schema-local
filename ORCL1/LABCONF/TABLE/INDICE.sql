-- dmap_object_gen_tag : type : index name : indice
set search_path = labconf,oracle,dmap_extension,public;
create index indice on glcomenu (men_keymen, men_gpomen);
