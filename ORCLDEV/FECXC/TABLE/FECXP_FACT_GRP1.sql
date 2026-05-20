-- dmap_object_gen_tag : type : table name : fecxp_fact_grp1
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_fact_grp1"  (
no_empresa numeric(38) not null,
no_folio_det numeric(38) not null,
fec_valor timestamp(0),
id_status_mov varchar(1),
id_tipo_operacion_set numeric(38),
fecha_actualizacion timestamp(0),
secuencia_dep_especiales numeric(38) not null,
id_divisa varchar(3),
importe decimal(20, 2),
code_combination numeric(38) not null,
oracle_segmento1 varchar(25),
oracle_segmento2 varchar(25),
oracle_segmento3 varchar(25),
oracle_segmento4 varchar(25),
oracle_segmento5 varchar(25),
oracle_segmento6 varchar(25),
oracle_segmento7 varchar(25),
es_repetido numeric(38) default 0
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_fact_grp1
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_fact_grp1 add constraint pk_fecxp_fact_grp1 primary key (secuencia_dep_especiales,code_combination);
-- dmap_object_gen_tag : type : alter table name : fecxp_fact_grp1
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_fact_grp1 alter column no_empresa set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_fact_grp1
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_fact_grp1 alter column no_folio_det set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_fact_grp1
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_fact_grp1 alter column secuencia_dep_especiales set not null;
