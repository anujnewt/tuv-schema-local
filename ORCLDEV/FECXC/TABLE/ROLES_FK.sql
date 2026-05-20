-- dmap_object_gen_tag : type : index name : roles_fk
set search_path = fecxc,oracle,dmap_extension,public;
create index roles_fk on fecxc_roles_xempresa (id_rol);
