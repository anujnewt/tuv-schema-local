-- dmap_object_gen_tag : type : table name : fecxp_b_enc_politicas_soin
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_b_enc_politicas_soin"  (
version_id numeric(38) not null,
usuario_id varchar(30),
fecha_creacion timestamp(0)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_b_enc_politicas_soin
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_b_enc_politicas_soin add constraint pkfecxp_b_enc_politicas_soin primary key (version_id);
-- dmap_object_gen_tag : type : alter table name : fecxp_b_enc_politicas_soin
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_b_enc_politicas_soin alter column version_id set not null;
