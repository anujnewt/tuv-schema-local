-- dmap_object_gen_tag : type : table name : fecxp_ppto_caratula_impns
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_ppto_caratula_impns"  (
e_codigo numeric not null,
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
id_version varchar(100),
utilizar_reporte varchar(1),
id_linea varchar(240),
procesado numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_caratula_impns
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_caratula_impns alter column e_codigo set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_caratula_impns
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_caratula_impns alter column des_empresa set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_caratula_impns
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_caratula_impns alter column id_sesion_pc set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_caratula_impns
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_caratula_impns alter column cla_fe_id set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_ppto_caratula_impns
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_ppto_caratula_impns alter column cla_fe_des set not null;
