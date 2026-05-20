-- dmap_object_gen_tag : type : index name : fk_cheques_aempresas_fk
set search_path = fecxc,oracle,dmap_extension,public;
create index fk_cheques_aempresas_fk on xxchk_captura_cheques (e_codigo);
