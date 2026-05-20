-- dmap_object_gen_tag : type : index name : fk_mapfl_clasfecxc_fk
set search_path = fecxc,oracle,dmap_extension,public;
create index fk_mapfl_clasfecxc_fk on fecxc_mapeo_flujo (cod_sec_catclas, cod_sec_det);
