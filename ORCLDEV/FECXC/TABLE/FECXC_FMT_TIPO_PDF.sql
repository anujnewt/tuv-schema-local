-- dmap_object_gen_tag : type : table name : fecxc_fmt_tipo_pdf
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxc_fmt_tipo_pdf"  (
id_session varchar(100) not null,
nombre_del_formato varchar(20) not null,
tipo_de_formato varchar(30) not null
) ;
-- dmap_object_gen_tag : type : alter table name : fecxc_fmt_tipo_pdf
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_fmt_tipo_pdf alter column id_session set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_fmt_tipo_pdf
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_fmt_tipo_pdf alter column nombre_del_formato set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_fmt_tipo_pdf
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_fmt_tipo_pdf alter column tipo_de_formato set not null;
