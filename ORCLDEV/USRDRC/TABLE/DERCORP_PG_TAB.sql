-- dmap_object_gen_tag : type : table name : dercorp_pg_tab
set search_path = usrdrc,oracle,dmap_extension,public;
create table "dercorp_pg_tab"  (
id_poder_general numeric not null,
id_poder numeric not null,
num_orden numeric,
id_apoderado numeric,
id_catalogo numeric,
num_created_by numeric,
fec_creation_date timestamp(0),
num_last_updated_by numeric,
fec_last_update_date timestamp(0),
num_last_update_login numeric,
atributo1 varchar(250),
atributo2 varchar(250),
atributo3 varchar(250),
atributo4 varchar(250),
atributo5 varchar(250),
atributo6 varchar(250),
atributo7 varchar(250),
atributo8 varchar(250),
atributo9 varchar(250),
atributo10 varchar(250),
atributo11 varchar(250),
atributo12 varchar(250),
atributo13 varchar(250),
atributo14 varchar(250),
atributo15 varchar(250),
attribute_category varchar(250)
) ;
-- dmap_object_gen_tag : type : alter table name : dercorp_pg_tab
set search_path = usrdrc,oracle,dmap_extension,public;
alter table dercorp_pg_tab add constraint dercorp_pg_tab_pk primary key (id_poder_general);
-- dmap_object_gen_tag : type : alter table name : dercorp_pg_tab
set search_path = usrdrc,oracle,dmap_extension,public;
alter table dercorp_pg_tab alter column id_poder_general set not null;
-- dmap_object_gen_tag : type : alter table name : dercorp_pg_tab
set search_path = usrdrc,oracle,dmap_extension,public;
alter table dercorp_pg_tab alter column id_poder set not null;
-- dmap_object_gen_tag : type : alter table name : dercorp_pg_tab
set search_path = usrdrc,oracle,dmap_extension,public;
alter table dercorp_pg_tab add constraint dercorp_pg_tab_fk foreign key (id_poder) references dercorp_poderes_tab(id_poder) on delete no action not deferrable initially immediate;
