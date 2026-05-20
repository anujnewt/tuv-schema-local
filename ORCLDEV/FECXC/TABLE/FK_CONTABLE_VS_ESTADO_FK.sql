-- dmap_object_gen_tag : type : index name : fk_contable_vs_estado_fk
set search_path = fecxc,oracle,dmap_extension,public;
create index fk_contable_vs_estado_fk on xxchk_cat_edo_cheque (id_estado_cheque);
