-- dmap_object_gen_tag : type : index name : fk_xxgl_estacheques_fk
set search_path = fecxc,oracle,dmap_extension,public;
create index fk_xxgl_estacheques_fk on xxchk_gl_interface_chk (id_estado_cheque);
