-- dmap_object_gen_tag : type : index name : xxchk_edo_cheque_fk
set search_path = fecxc,oracle,dmap_extension,public;
create index xxchk_edo_cheque_fk on xxchk_roles_actividad (e_codigo, id_estado_cheque);
