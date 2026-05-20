-- dmap_object_gen_tag : type : index name : rk_xxgl_cheque_fk
set search_path = fecxc,oracle,dmap_extension,public;
create index rk_xxgl_cheque_fk on xxchk_gl_interface_chk (id_sec_cheque);
