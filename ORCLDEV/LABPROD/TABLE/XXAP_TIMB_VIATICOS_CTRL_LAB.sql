-- dmap_object_gen_tag : type : table name : xxap_timb_viaticos_ctrl_lab
set search_path = labprod,oracle,dmap_extension,public;
create table "xxap_timb_viaticos_ctrl_lab"  (
id_timbrado_viaticos numeric not null,
agrupador varchar(255),
identificador varchar(255),
monto_mo numeric,
monto_mn numeric,
impuesto_mo numeric,
impuesto_mn numeric,
distribucion varchar(255),
concepto varchar(255),
invoice_num varchar(255),
estatus varchar(255),
uuid varchar(255),
attribute1 varchar(255),
attribute2 varchar(255),
attribute3 varchar(255),
attribute4 varchar(255),
attribute5 varchar(255),
attribute6 varchar(255),
attribute7 varchar(255),
attribute8 varchar(255),
attribute9 varchar(255),
attribute10 varchar(255)
) ;
-- dmap_object_gen_tag : type : alter table name : xxap_timb_viaticos_ctrl_lab
set search_path = labprod,oracle,dmap_extension,public;
alter table xxap_timb_viaticos_ctrl_lab add constraint pk_id_timbrado_viaticos primary key (id_timbrado_viaticos);
