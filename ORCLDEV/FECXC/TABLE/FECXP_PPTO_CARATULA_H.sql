-- dmap_object_gen_tag : type : table name : fecxp_ppto_caratula_h
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_ppto_caratula_h"  (
e_codigo numeric(38) not null,
des_empresa varchar(100) not null,
id_sesion_pc varchar(256) not null,
periodo numeric(38),
mes numeric(38),
moneda varchar(3),
tipo_cambio decimal(20, 11),
cla_fe_id varchar(25) not null,
cla_fe_des varchar(25) not null,
importe_linea decimal(20, 4),
estatus varchar(25) default ('EXTRAIDO'),
id_version numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_caratula_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_caratula_h alter column e_codigo set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_caratula_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_caratula_h alter column des_empresa set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_caratula_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_caratula_h alter column id_sesion_pc set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_caratula_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_caratula_h alter column cla_fe_id set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_caratula_h
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_caratula_h alter column cla_fe_des set not null;
