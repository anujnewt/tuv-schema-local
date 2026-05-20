-- dmap_object_gen_tag : type : table name : fecxc_fmt_segmentos_pdf
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxc_fmt_segmentos_pdf"  (
id_session varchar(100) not null,
nombre_del_formato varchar(20) not null,
id_segmento_pdf numeric(38) not null,
id_titulo_1 numeric,
id_titulo_2 numeric,
id_titulo_combinado numeric
) ;
-- dmap_object_gen_tag : type : alter table name : fecxc_fmt_segmentos_pdf
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_fmt_segmentos_pdf alter column id_session set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_fmt_segmentos_pdf
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_fmt_segmentos_pdf alter column nombre_del_formato set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_fmt_segmentos_pdf
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_fmt_segmentos_pdf alter column id_segmento_pdf set not null;
