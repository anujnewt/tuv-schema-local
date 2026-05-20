-- dmap_object_gen_tag : type : index name : nmtabs01
set search_path = labprod,oracle,dmap_extension,public;
create index nmtabs01 on nmlotabs (tab_keysue, tab_cobert, tab_sueniv, tab_subniv);
