-- dmap_object_gen_tag : type : index name : xxchk_empresas_a_roles_fk
set search_path = fecxc,oracle,dmap_extension,public;
create index xxchk_empresas_a_roles_fk on xxchk_roles_xempresa (e_codigo);
