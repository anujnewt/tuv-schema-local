-- dmap_object_gen_tag : type : index name : admp_parrilla_n01
set search_path = admp,oracle,dmap_extension,public;
create index admp_parrilla_n01 on admp_parrilla_tab (num_version, id_canal, id_tipo_parrilla);
