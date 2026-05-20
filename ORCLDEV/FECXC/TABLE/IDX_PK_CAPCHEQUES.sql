-- dmap_object_gen_tag : type : index name : idx_pk_capcheques
set search_path = fecxc,oracle,dmap_extension,public;
create index idx_pk_capcheques on xxchk_captura_cheques (id_banco, no_cheque, referencia_cliente);
