-- dmap_object_gen_tag : type : table name : admp_sub_genero_tab
set search_path = admp,oracle,dmap_extension,public;
create table "admp_sub_genero_tab"  (
id_sub_genero numeric not null,
id_genero numeric not null,
des_sub_genero varchar(100) not null,
id_estado numeric not null,
num_created_by numeric(15) not null,
fec_creation_date timestamp(0) not null,
num_last_update numeric(15) not null,
fec_last_update timestamp(0) not null,
num_last_update_login numeric(15),
atributo1 varchar(150),
atributo2 varchar(150),
atributo3 varchar(150),
atributo4 varchar(150),
atributo5 varchar(150),
atributo6 varchar(150),
atributo7 varchar(150),
atributo8 varchar(150),
atributo9 varchar(150),
atributo10 varchar(150),
atributo11 varchar(150),
atributo12 varchar(150),
atributo13 varchar(150),
atributo14 varchar(150),
atributo15 varchar(150),
attribute_category varchar(150)
) ;
-- dmap_object_gen_tag : type : alter table name : admp_sub_genero_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_sub_genero_tab add constraint admp_sub_genero_pk primary key (id_sub_genero);
-- dmap_object_gen_tag : type : alter table name : admp_sub_genero_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_sub_genero_tab alter column id_sub_genero set not null;
-- dmap_object_gen_tag : type : alter table name : admp_sub_genero_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_sub_genero_tab alter column id_genero set not null;
-- dmap_object_gen_tag : type : alter table name : admp_sub_genero_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_sub_genero_tab alter column des_sub_genero set not null;
-- dmap_object_gen_tag : type : alter table name : admp_sub_genero_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_sub_genero_tab alter column id_estado set not null;
-- dmap_object_gen_tag : type : alter table name : admp_sub_genero_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_sub_genero_tab alter column num_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : admp_sub_genero_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_sub_genero_tab alter column fec_creation_date set not null;
-- dmap_object_gen_tag : type : alter table name : admp_sub_genero_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_sub_genero_tab alter column num_last_update set not null;
-- dmap_object_gen_tag : type : alter table name : admp_sub_genero_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_sub_genero_tab alter column fec_last_update set not null;
-- dmap_object_gen_tag : type : alter table name : admp_sub_genero_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_sub_genero_tab add constraint admp_sub_genero_fk_01 foreign key (id_genero) references admp_genero_tab(id_genero) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : admp_sub_genero_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_sub_genero_tab add constraint admp_sub_genero_fk_02 foreign key (id_estado) references admp_estado_tab(id_estado) on delete no action not deferrable initially immediate;
