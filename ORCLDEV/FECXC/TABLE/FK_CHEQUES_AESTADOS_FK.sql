-- dmap_object_gen_tag : type : index name : fk_cheques_aestados_fk
set search_path = fecxc,oracle,dmap_extension,public;
create index fk_cheques_aestados_fk on xxchk_captura_cheques (id_estado_cheque);
