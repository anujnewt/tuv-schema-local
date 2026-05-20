-- dmap_object_gen_tag : type : table name : xxmor_solicitudes_orig_enc_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxmor_solicitudes_orig_enc_tab"  (
id_request numeric not null,
id_archivo_sol numeric,
id_seg_neg numeric,
proc_por_linea varchar(2),
garantizado varchar(2),
advid varchar(12),
mcontid varchar(20),
mcontid_cutin varchar(20),
email varchar(80),
agyestnum varchar(25),
accthdrid varchar(50),
rtcrddscr varchar(40),
rtcrddscr_cutin varchar(50),
comentarios varchar(252),
secnum varchar(3),
plataforma_canal varchar(70),
prdid_desc varchar(50),
total_spots varchar(5),
total_sin_desc varchar(15),
total_con_desc varchar(15),
tipo_facturacion varchar(20),
descuento varchar(20),
target varchar(50),
aux1 varchar(15),
aux2 varchar(15),
aux3 varchar(15),
aux4 varchar(15),
aux5 varchar(15),
created_by varchar(20) not null,
created_date timestamp(0) not null default statement_timestamp()
) ;
-- dmap_object_gen_tag : type : alter table name : xxmor_solicitudes_orig_enc_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_solicitudes_orig_enc_tab add constraint xxmor_solicitudes_orig_enc_pk primary key (id_request);
-- dmap_object_gen_tag : type : alter table name : xxmor_solicitudes_orig_enc_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_solicitudes_orig_enc_tab alter column id_request set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_solicitudes_orig_enc_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_solicitudes_orig_enc_tab alter column created_by set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_solicitudes_orig_enc_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_solicitudes_orig_enc_tab alter column created_date set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_solicitudes_orig_enc_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_solicitudes_orig_enc_tab add constraint fk_xxmor_so_fk_fzas_v_xxmor_se foreign key (id_seg_neg) references xxmor_segm_neg_tab(id_seg_neg) on delete no action not deferrable initially immediate;
