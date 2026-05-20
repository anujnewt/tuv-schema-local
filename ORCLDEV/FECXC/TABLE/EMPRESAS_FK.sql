-- dmap_object_gen_tag : type : index name : empresas_fk
set search_path = fecxc,oracle,dmap_extension,public;
create index empresas_fk on fecxc_roles_xempresa (e_codigo);
