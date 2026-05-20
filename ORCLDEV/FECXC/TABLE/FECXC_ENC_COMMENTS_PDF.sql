-- dmap_object_gen_tag : type : table name : fecxc_enc_comments_pdf
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxc_enc_comments_pdf"  (
id_formato_pdf varchar(20) not null,
id_usuario varchar(30) not null,
comentario varchar(100) not null,
comentario_corto varchar(10) not null,
estatus_comm varchar(1) not null
) ;
-- dmap_object_gen_tag : type : alter table name : fecxc_enc_comments_pdf
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_enc_comments_pdf add constraint pk_fecxc_enc_comments_pdf primary key (id_formato_pdf,id_usuario);
-- dmap_object_gen_tag : type : alter table name : fecxc_enc_comments_pdf
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_enc_comments_pdf add constraint ckc_estatus_comm_fecxc_en check (estatus_comm in ('A','I'));
-- dmap_object_gen_tag : type : alter table name : fecxc_enc_comments_pdf
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_enc_comments_pdf alter column id_formato_pdf set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_enc_comments_pdf
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_enc_comments_pdf alter column id_usuario set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_enc_comments_pdf
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_enc_comments_pdf alter column comentario set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_enc_comments_pdf
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_enc_comments_pdf alter column comentario_corto set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_enc_comments_pdf
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_enc_comments_pdf alter column estatus_comm set not null;
