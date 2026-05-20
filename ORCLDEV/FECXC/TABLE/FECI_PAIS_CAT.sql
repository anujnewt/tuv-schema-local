-- dmap_object_gen_tag : type : table name : feci_pais_cat
set search_path = fecxc,oracle,dmap_extension,public;
create table "feci_pais_cat"  (
id_pais  bigint generated always as identity  (start with 42 increment by 1  maxvalue 999999999999999999 minvalue 1 no cycle cache 20 ),
id_region numeric not null,
cod_pais varchar(20) not null,
des_pais varchar(250) not null,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) ;
-- dmap_object_gen_tag : type : alter table name : feci_pais_cat
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_pais_cat add constraint pais_pk primary key (id_pais);
-- dmap_object_gen_tag : type : alter table name : feci_pais_cat
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_pais_cat alter column id_pais set not null;
-- dmap_object_gen_tag : type : alter table name : feci_pais_cat
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_pais_cat alter column id_region set not null;
-- dmap_object_gen_tag : type : alter table name : feci_pais_cat
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_pais_cat alter column cod_pais set not null;
-- dmap_object_gen_tag : type : alter table name : feci_pais_cat
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_pais_cat alter column des_pais set not null;
-- dmap_object_gen_tag : type : alter table name : feci_pais_cat
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_pais_cat alter column fec_creacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_pais_cat
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_pais_cat alter column fec_ult_modificacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_pais_cat
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_pais_cat alter column id_usuario_creacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_pais_cat
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_pais_cat alter column id_usuario_ult_modif set not null;
-- dmap_object_gen_tag : type : alter table name : feci_pais_cat
set search_path = fecxc,oracle,dmap_extension,public;
alter table feci_pais_cat alter column ind_estado set not null;
