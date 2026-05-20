-- dmap_object_gen_tag : type : index name : fk_cambios_edo_edos_fk
set search_path = fecxc,oracle,dmap_extension,public;
create index fk_cambios_edo_edos_fk on xxchk_cat_cambios_estado (id_estado_cheque);
