-- dmap_object_gen_tag : type : index name : cat_det_cattipo_fk
set search_path = fecxc,oracle,dmap_extension,public;
create index cat_det_cattipo_fk on fecxc_cat_xempresa (cod_sec_tipcat);
