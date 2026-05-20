-- dmap_object_gen_tag : type : index name : usuario_idx
set search_path = feci,oracle,dmap_extension,public;
create index usuario_idx on feci_usuario_tab (des_email, ind_estado);
