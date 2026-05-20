-- dmap_object_gen_tag : type : index name : idx_usuario
set search_path = fecxc,oracle,dmap_extension,public;
create index idx_usuario on fecxc_conciliacion_det_rep (usuario);
