-- dmap_object_gen_tag : type : index name : idx_monedas_pdf
set search_path = fecxc,oracle,dmap_extension,public;
create index idx_monedas_pdf on fecxc_fmt_monedas_pdf (id_session, nombre_del_formato, codmoneda);
