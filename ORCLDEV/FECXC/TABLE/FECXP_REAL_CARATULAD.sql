-- dmap_object_gen_tag : type : table name : fecxp_real_caratulad
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_real_caratulad"  (
e_codigo numeric(38) not null,
des_empresa varchar(100) not null,
id_sesion_rc varchar(256) not null,
fecha timestamp(0),
moneda varchar(3),
tipo_cambio decimal(20, 11),
cla_fe_id varchar(25) not null,
cla_fe_des varchar(100) not null,
importe_linea decimal(38, 4),
estatus varchar(25) default ('EXTRAIDO')
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_real_caratulad
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_real_caratulad alter column e_codigo set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_real_caratulad
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_real_caratulad alter column des_empresa set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_real_caratulad
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_real_caratulad alter column id_sesion_rc set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_real_caratulad
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_real_caratulad alter column cla_fe_id set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_real_caratulad
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_real_caratulad alter column cla_fe_des set not null;
