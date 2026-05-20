-- dmap_object_gen_tag : type : table name : dercorp_apoderados_new_tab
set search_path = usrdrc,oracle,dmap_extension,public;
create table "dercorp_apoderados_new_tab"  (
id_apoderado numeric,
id_poder numeric not null,
id_grupo_apoderado numeric,
nom_apoderado varchar(1000),
des_vigencia varchar(256),
des_tiempo varchar(256),
fec_fecha_inicio varchar(256),
fec_vencimiento varchar(256),
des_escritura_const varchar(256),
num_termino_por numeric,
fec_de_fecha varchar(256),
des_doc_documentum varchar(256),
des_caracteristicas varchar(3000),
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
-- dmap_object_gen_tag : type : alter table name : dercorp_apoderados_new_tab
set search_path = usrdrc,oracle,dmap_extension,public;
alter table dercorp_apoderados_new_tab alter column id_poder set not null;
-- dmap_object_gen_tag : type : alter table name : dercorp_apoderados_new_tab
set search_path = usrdrc,oracle,dmap_extension,public;
alter table dercorp_apoderados_new_tab add constraint dercorp_apoderados_new_tab_fk foreign key (id_poder) references dercorp_poderes_tab(id_poder) on delete no action not deferrable initially immediate;
