-- dmap_object_gen_tag : type : table name : fecxp_b_det_clasificacion_fe
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_b_det_clasificacion_fe"  (
version_id numeric(38) not null,
cla_fe_id varchar(25) not null,
cla_fe_des varchar(50),
cla_atributo1 varchar(250),
cla_atributo2 varchar(250),
cla_atributo3 varchar(250),
cla_atributo4 varchar(50),
cla_atributo5 varchar(50),
cla_atributo6 varchar(50),
genera_saldo numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_b_det_clasificacion_fe
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_b_det_clasificacion_fe add constraint pkfecxp_b_det_clasificacion_fe primary key (version_id,cla_fe_id);
-- dmap_object_gen_tag : type : alter table name : fecxp_b_det_clasificacion_fe
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_b_det_clasificacion_fe alter column version_id set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_b_det_clasificacion_fe
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_b_det_clasificacion_fe alter column cla_fe_id set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_b_det_clasificacion_fe
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_b_det_clasificacion_fe add constraint fkfecxp_b_det_clasificacion_fe foreign key (version_id) references fecxp_b_enc_clasificacion_fe(version_id) on delete no action not deferrable initially immediate;
