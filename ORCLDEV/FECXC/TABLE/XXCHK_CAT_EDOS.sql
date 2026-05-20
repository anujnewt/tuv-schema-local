-- dmap_object_gen_tag : type : table name : xxchk_cat_edos
set search_path = fecxc,oracle,dmap_extension,public;
create table "xxchk_cat_edos"  (
id_estado_cheque numeric(38) not null,
descripcion varchar(100) not null,
tipo_operacion varchar(20) default 'ENFIRME',
date_created timestamp(0) default statement_timestamp()
) ;
-- dmap_object_gen_tag : type : alter table name : xxchk_cat_edos
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_cat_edos add constraint pk_xxchk_cat_edos primary key (id_estado_cheque);
-- dmap_object_gen_tag : type : alter table name : xxchk_cat_edos
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_cat_edos add constraint ckc_tipo_operacion_xxchk_ca check (tipo_operacion is null or ( tipo_operacion in ('ENFIRME','SBC','RECHAZADO') ));
-- dmap_object_gen_tag : type : alter table name : xxchk_cat_edos
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_cat_edos alter column id_estado_cheque set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_cat_edos
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_cat_edos alter column descripcion set not null;
