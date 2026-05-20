-- dmap_object_gen_tag : type : index name : det_cat_clasifica_fk
set search_path = fecxc,oracle,dmap_extension,public;
create index det_cat_clasifica_fk on fecxc_det_clasificados (cod_sec_catclas, cod_sec_det);
