-- dmap_object_gen_tag : type : table name : admp_programa_memo_tab
set search_path = admp,oracle,dmap_extension,public;
create table "admp_programa_memo_tab"  (
id_programa_memo numeric not null,
id_memo_detalle numeric not null,
des_titulo varchar(600),
des_titulo_original varchar(600),
cod_afectacion varchar(1),
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
attribute_category varchar(150),
des_cambio varchar(400)
) ;
-- dmap_object_gen_tag : type : alter table name : admp_programa_memo_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_programa_memo_tab add constraint admp_programa_memo_pk primary key (id_programa_memo);
-- dmap_object_gen_tag : type : alter table name : admp_programa_memo_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_programa_memo_tab alter column id_programa_memo set not null;
-- dmap_object_gen_tag : type : alter table name : admp_programa_memo_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_programa_memo_tab alter column id_memo_detalle set not null;
-- dmap_object_gen_tag : type : alter table name : admp_programa_memo_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_programa_memo_tab alter column num_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : admp_programa_memo_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_programa_memo_tab alter column fec_creation_date set not null;
-- dmap_object_gen_tag : type : alter table name : admp_programa_memo_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_programa_memo_tab alter column num_last_update set not null;
-- dmap_object_gen_tag : type : alter table name : admp_programa_memo_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_programa_memo_tab alter column fec_last_update set not null;
-- dmap_object_gen_tag : type : alter table name : admp_programa_memo_tab
set search_path = admp,oracle,dmap_extension,public;
alter table admp_programa_memo_tab add constraint admp_programa_memo_fk_01 foreign key (id_memo_detalle) references admp_memo_detalle_tab(id_memo_detalle) on delete no action not deferrable initially immediate;
