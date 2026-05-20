-- dmap_object_gen_tag : type : index name : idx_tipo_pdf
set search_path = fecxc,oracle,dmap_extension,public;
create index idx_tipo_pdf on fecxc_fmt_tipo_pdf (id_session, nombre_del_formato, tipo_de_formato);
