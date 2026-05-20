-- dmap_object_gen_tag : type : table name : fecxp_mov_comple_soin
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_mov_comple_soin"  (
secuencia_mov_comple_soin numeric(38) not null,
e_codigo numeric(38) not null,
periodo numeric(38) not null,
mescod numeric(38) not null,
cg5con numeric(38) not null,
cgbbat numeric(38) not null,
cgbfec timestamp(0) not null,
cg17va numeric(38) not null,
ctam01 varchar(3) not null,
ctam02 varchar(3) not null,
ctam03 varchar(3) not null,
cgtmon decimal(20, 4) not null,
cgtmoe decimal(20, 4) not null,
moneda varchar(3) not null,
cgttip varchar(1) not null,
tipo_cambio decimal(20, 11) not null,
mov_estatus varchar(20) not null default 'E'
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_mov_comple_soin
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_mov_comple_soin add constraint pk_fecxp_mov_comple_soin primary key (e_codigo,secuencia_mov_comple_soin);
-- dmap_object_gen_tag : type : alter table name : fecxp_mov_comple_soin
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_mov_comple_soin alter column secuencia_mov_comple_soin set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_mov_comple_soin
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_mov_comple_soin alter column e_codigo set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_mov_comple_soin
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_mov_comple_soin alter column periodo set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_mov_comple_soin
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_mov_comple_soin alter column mescod set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_mov_comple_soin
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_mov_comple_soin alter column cg5con set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_mov_comple_soin
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_mov_comple_soin alter column cgbbat set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_mov_comple_soin
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_mov_comple_soin alter column cgbfec set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_mov_comple_soin
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_mov_comple_soin alter column cg17va set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_mov_comple_soin
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_mov_comple_soin alter column ctam01 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_mov_comple_soin
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_mov_comple_soin alter column ctam02 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_mov_comple_soin
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_mov_comple_soin alter column ctam03 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_mov_comple_soin
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_mov_comple_soin alter column cgtmon set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_mov_comple_soin
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_mov_comple_soin alter column cgtmoe set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_mov_comple_soin
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_mov_comple_soin alter column moneda set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_mov_comple_soin
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_mov_comple_soin alter column cgttip set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_mov_comple_soin
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_mov_comple_soin alter column tipo_cambio set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_mov_comple_soin
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_mov_comple_soin alter column mov_estatus set not null;
