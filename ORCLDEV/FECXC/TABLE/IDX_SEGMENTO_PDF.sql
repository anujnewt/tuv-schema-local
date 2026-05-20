-- dmap_object_gen_tag : type : index name : idx_segmento_pdf
set search_path = fecxc,oracle,dmap_extension,public;
create index idx_segmento_pdf on fecxc_fmt_segmentos_pdf (id_session, nombre_del_formato, id_segmento_pdf);
