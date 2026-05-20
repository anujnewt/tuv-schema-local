-- dmap_object_gen_tag : type : table name : xxap_timb_viati_ctrl_dist_lab
set search_path = labconf,oracle,dmap_extension,public;
create table "xxap_timb_viati_ctrl_dist_lab"  (
idregistro varchar(255) not null,
monto_mo numeric,
monto_mn numeric,
impuesto_mo numeric,
impuesto_mn numeric,
anticipo varchar(255),
distribucion varchar(255),
remanente varchar(255),
estatusanticipo varchar(255),
estatususuario varchar(255),
estatusdistribucion varchar(255),
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
-- dmap_object_gen_tag : type : alter table name : xxap_timb_viati_ctrl_dist_lab
set search_path = labconf,oracle,dmap_extension,public;
alter table xxap_timb_viati_ctrl_dist_lab add constraint pk_idregistro primary key (idregistro);
