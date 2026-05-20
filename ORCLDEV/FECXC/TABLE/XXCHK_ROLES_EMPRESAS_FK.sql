-- dmap_object_gen_tag : type : index name : xxchk_roles_empresas_fk
set search_path = fecxc,oracle,dmap_extension,public;
create index xxchk_roles_empresas_fk on xxchk_roles_xempresa (id_rol);
