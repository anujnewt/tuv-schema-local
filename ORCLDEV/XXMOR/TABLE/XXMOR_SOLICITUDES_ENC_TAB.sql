-- dmap_object_gen_tag : type : table name : xxmor_solicitudes_enc_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxmor_solicitudes_enc_tab"  (
id_solicitud numeric not null,
id_request numeric,
id_seg_neg numeric,
id_fza_ventas numeric,
id_solicitud_hna numeric,
proc_por_linea varchar(2),
garantizado varchar(2),
advid varchar(12),
mcontid varchar(20),
mcontid_cutin varchar(20),
email varchar(80),
agyestnum varchar(25),
accthdrid varchar(50),
rtcrddscr varchar(40),
rtcrd varchar(50),
rtcrddscr_cutin varchar(50),
rtcrd_cutin varchar(50),
comentarios varchar(250),
secnum varchar(3),
plataforma_canal varchar(70),
agrupador varchar(10),
prdid_desc varchar(50),
prdid varchar(50),
total_spots varchar(5),
total_sin_desc varchar(15),
total_con_desc varchar(15),
tipo_facturacion varchar(20),
descuento varchar(20),
target varchar(50),
created_date timestamp(0) default statement_timestamp(),
created_by varchar(20),
updated_date timestamp(0),
updated_by varchar(20),
orden_estatus varchar(2),
fecha_concom varchar(35),
tracking_id_concom varchar(50),
aux1 varchar(15),
aux2 varchar(15),
aux3 varchar(15),
motivo_ar_cc numeric,
coment_ar_cc varchar(240),
rechazo_gestor varchar(1)
) ;
-- dmap_object_gen_tag : type : alter table name : xxmor_solicitudes_enc_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_solicitudes_enc_tab add constraint xxmor_solicitudes_enc_tab_pk primary key (id_solicitud);
-- dmap_object_gen_tag : type : alter table name : xxmor_solicitudes_enc_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_solicitudes_enc_tab alter column id_solicitud set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_solicitudes_enc_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_solicitudes_enc_tab add constraint fk_fza_vtas_sol_enc foreign key (id_seg_neg,id_fza_ventas) references xxmor_fzas_vtas_tab(id_seg_neg,id_fza_ventas) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : xxmor_solicitudes_enc_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_solicitudes_enc_tab add constraint fk_sol_orig_enc_sol_enc foreign key (id_request) references xxmor_solicitudes_orig_enc_tab(id_request) on delete no action not deferrable initially immediate;
