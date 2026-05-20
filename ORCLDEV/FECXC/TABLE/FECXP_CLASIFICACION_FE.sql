-- dmap_object_gen_tag : type : table name : fecxp_clasificacion_fe
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_clasificacion_fe"  (
cla_fe_id varchar(25) not null,
cla_fe_des varchar(50),
cla_atributo1 varchar(250),
cla_atributo2 varchar(250),
cla_atributo3 varchar(250),
cla_atributo4 varchar(50),
cla_atributo5 varchar(50),
cla_atributo6 varchar(50),
genera_saldo numeric(38),
version_id numeric(38) default (0)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_clasificacion_fe
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_clasificacion_fe add constraint pk_fecxp_clasificacion_fe primary key (cla_fe_id);
-- dmap_object_gen_tag : type : alter table name : fecxp_clasificacion_fe
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_clasificacion_fe alter column cla_fe_id set not null;
