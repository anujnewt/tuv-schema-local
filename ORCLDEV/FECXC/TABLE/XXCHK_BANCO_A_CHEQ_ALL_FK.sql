-- dmap_object_gen_tag : type : index name : xxchk_banco_a_cheq_all_fk
set search_path = fecxc,oracle,dmap_extension,public;
create index xxchk_banco_a_cheq_all_fk on xxchk_cheques_all (id_banco);
