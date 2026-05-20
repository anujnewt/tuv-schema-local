-- dmap_object_gen_tag : type : table name : feci_segmento_cat
set search_path = fecxc,oracle,dmap_extension,public;
create table "feci_segmento_cat"  (
id_segmento  bigint generated always as identity  (start with 14 increment by 1  maxvalue 999999999999999999 minvalue 1 no cycle cache 20 ),
cod_segmento varchar(20) not null,
des_segmento varchar(250) not null,
cod_moneda varchar(20) not null,
ind_cps numeric not null,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) ;
-- dmap_object_gen_tag : type : alter table name : feci_segmento_cat
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_segmento_cat add constraint segmento_pk primary key (id_segmento);
-- dmap_object_gen_tag : type : alter table name : feci_segmento_cat
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_segmento_cat alter column id_segmento set not null;
-- dmap_object_gen_tag : type : alter table name : feci_segmento_cat
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_segmento_cat alter column cod_segmento set not null;
-- dmap_object_gen_tag : type : alter table name : feci_segmento_cat
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_segmento_cat alter column des_segmento set not null;
-- dmap_object_gen_tag : type : alter table name : feci_segmento_cat
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_segmento_cat alter column cod_moneda set not null;
-- dmap_object_gen_tag : type : alter table name : feci_segmento_cat
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_segmento_cat alter column ind_cps set not null;
-- dmap_object_gen_tag : type : alter table name : feci_segmento_cat
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_segmento_cat alter column fec_creacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_segmento_cat
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_segmento_cat alter column fec_ult_modificacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_segmento_cat
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_segmento_cat alter column id_usuario_creacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_segmento_cat
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_segmento_cat alter column id_usuario_ult_modif set not null;
-- dmap_object_gen_tag : type : alter table name : feci_segmento_cat
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_segmento_cat alter column ind_estado set not null;
