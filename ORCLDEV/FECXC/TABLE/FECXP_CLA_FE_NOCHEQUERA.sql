-- dmap_object_gen_tag : type : table name : fecxp_cla_fe_nochequera
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_cla_fe_nochequera"  (
cla_fe_id varchar(25) not null,
cla_fe_des varchar(50),
cla_atributo1 varchar(250),
cla_atributo2 varchar(250),
cla_atributo3 varchar(250),
cla_atributo4 varchar(50),
cla_atributo5 varchar(50),
cla_atributo6 varchar(50),
genera_saldo numeric(38),
version_id numeric(38) default (0),
tipo_operacion numeric(38) not null,
id_tipo_movto varchar(1) not null,
tipo_clave varchar(2) not null
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_cla_fe_nochequera
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_cla_fe_nochequera add constraint pk_fecxp_cl_fe_nochequera primary key (cla_fe_id,tipo_operacion,id_tipo_movto,tipo_clave);
-- dmap_object_gen_tag : type : alter table name : fecxp_cla_fe_nochequera
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_cla_fe_nochequera alter column cla_fe_id set not null;
