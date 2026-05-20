-- dmap_object_gen_tag : type : index name : xxchk_banco_a_cheques_fk
set search_path = fecxc,oracle,dmap_extension,public;
create index xxchk_banco_a_cheques_fk on xxchk_captura_cheques (id_banco);
