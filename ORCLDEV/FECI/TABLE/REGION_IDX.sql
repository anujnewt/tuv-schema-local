-- dmap_object_gen_tag : type : index name : region_idx
set search_path = feci,oracle,dmap_extension,public;
create index region_idx on feci_region_cat (cod_region, ind_estado);
