-- dmap_object_gen_tag : type : index name : rol_idx
set search_path = feci,oracle,dmap_extension,public;
create index rol_idx on feci_rol_tab (cod_rol, ind_estado);
