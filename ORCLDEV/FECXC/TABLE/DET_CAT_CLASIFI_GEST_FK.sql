-- dmap_object_gen_tag : type : index name : det_cat_clasifi_gest_fk
set search_path = fecxc,oracle,dmap_extension,public;
create index det_cat_clasifi_gest_fk on fecxc_det_impges (cod_sec_catclas, cod_sec_det);
