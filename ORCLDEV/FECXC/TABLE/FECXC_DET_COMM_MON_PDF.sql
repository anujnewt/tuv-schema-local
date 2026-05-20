-- dmap_object_gen_tag : type : table name : fecxc_det_comm_mon_pdf
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxc_det_comm_mon_pdf"  (
id_formato_pdf varchar(20) not null,
id_usuario varchar(30) not null,
id_moneda varchar(3) not null,
tipo_empresa varchar(2) not null
) ;
-- dmap_object_gen_tag : type : alter table name : fecxc_det_comm_mon_pdf
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_det_comm_mon_pdf add constraint pk_fecxc_det_comm_mon_pdf primary key (id_formato_pdf,id_usuario,id_moneda,tipo_empresa);
-- dmap_object_gen_tag : type : alter table name : fecxc_det_comm_mon_pdf
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_det_comm_mon_pdf add constraint ckc_tipo_empresa_fecxc_de check (tipo_empresa in ('GE','NG'));
-- dmap_object_gen_tag : type : alter table name : fecxc_det_comm_mon_pdf
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_det_comm_mon_pdf alter column id_formato_pdf set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_det_comm_mon_pdf
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_det_comm_mon_pdf alter column id_usuario set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_det_comm_mon_pdf
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_det_comm_mon_pdf alter column id_moneda set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_det_comm_mon_pdf
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_det_comm_mon_pdf alter column tipo_empresa set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_det_comm_mon_pdf
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_det_comm_mon_pdf add constraint fk_fecxc_de_fk_commmo_fecxc_en foreign key (id_formato_pdf,id_usuario) references fecxc_enc_comments_pdf(id_formato_pdf,id_usuario) on delete no action not deferrable initially immediate;
