-- dmap_object_gen_tag : type : table name : fecxc_det_comm_seg_pdf
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxc_det_comm_seg_pdf"  (
id_formato_pdf varchar(20) not null,
id_usuario varchar(30) not null,
id_seg_pdf numeric(38) not null
) ;
-- dmap_object_gen_tag : type : alter table name : fecxc_det_comm_seg_pdf
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_det_comm_seg_pdf add constraint pk_fecxc_det_comm_seg_pdf primary key (id_formato_pdf,id_usuario,id_seg_pdf);
-- dmap_object_gen_tag : type : alter table name : fecxc_det_comm_seg_pdf
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_det_comm_seg_pdf alter column id_formato_pdf set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_det_comm_seg_pdf
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_det_comm_seg_pdf alter column id_usuario set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_det_comm_seg_pdf
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_det_comm_seg_pdf alter column id_seg_pdf set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_det_comm_seg_pdf
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_det_comm_seg_pdf add constraint fk_fecxc_de_fk_commse_fecxc_en foreign key (id_formato_pdf,id_usuario) references fecxc_enc_comments_pdf(id_formato_pdf,id_usuario) on delete no action not deferrable initially immediate;
