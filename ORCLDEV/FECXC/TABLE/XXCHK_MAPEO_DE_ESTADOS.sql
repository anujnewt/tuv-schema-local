-- dmap_object_gen_tag : type : table name : xxchk_mapeo_de_estados
set search_path = fecxc,oracle,dmap_extension,public;
create table "xxchk_mapeo_de_estados"  (
id_estado_cheque numeric(38),
id_tipo_operacion_set numeric(38) not null,
descripcion varchar(100) not null,
date_created timestamp(0) default statement_timestamp()
) ;
-- dmap_object_gen_tag : type : alter table name : xxchk_mapeo_de_estados
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_mapeo_de_estados alter column id_tipo_operacion_set set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_mapeo_de_estados
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_mapeo_de_estados alter column descripcion set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_mapeo_de_estados
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_mapeo_de_estados add constraint fk_xxchk_ma_mapeo_a_e_xxchk_ca foreign key (id_estado_cheque) references xxchk_cat_edos(id_estado_cheque) on delete no action not deferrable initially immediate;
