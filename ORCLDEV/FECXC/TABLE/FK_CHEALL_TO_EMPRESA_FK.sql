-- dmap_object_gen_tag : type : index name : fk_cheall_to_empresa_fk
set search_path = fecxc,oracle,dmap_extension,public;
create index fk_cheall_to_empresa_fk on xxchk_cheques_all (e_codigo);
