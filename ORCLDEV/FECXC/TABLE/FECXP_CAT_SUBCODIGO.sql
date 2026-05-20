-- dmap_object_gen_tag : type : table name : fecxp_cat_subcodigo
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_cat_subcodigo"  (
secuencia_cod_sub numeric(38),
no_empresa numeric(38) not null,
id_codigo varchar(2) not null,
id_subcodigo varchar(3) not null,
desc_subcodigo varchar(40),
cla_fe_id varchar(25),
estatus varchar(25) default ('ACTIVO'),
fecha_modificacion timestamp(0) default (statement_timestamp())
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_cat_subcodigo
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_cat_subcodigo add constraint pk_fecxp_cat_subcodigo primary key (no_empresa,id_codigo,id_subcodigo);
