-- dmap_object_gen_tag : type : table name : xxcofidi_empresa_ct_tab
set search_path = cofidi,oracle,dmap_extension,public;
create table "xxcofidi_empresa_ct_tab"  (
id_empresa_pk numeric(38) not null,
nom_empresa varchar(255) not null,
id_estado_fk numeric not null,
rfc varchar(13) not null,
cod_cia varchar(3)
) ;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_empresa_ct_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_empresa_ct_tab add constraint xxcofidi_empresa_pk_idx01 primary key (id_empresa_pk);
-- dmap_object_gen_tag : type : alter table name : xxcofidi_empresa_ct_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_empresa_ct_tab alter column id_empresa_pk set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_empresa_ct_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_empresa_ct_tab alter column nom_empresa set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_empresa_ct_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_empresa_ct_tab alter column id_estado_fk set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_empresa_ct_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_empresa_ct_tab alter column rfc set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_empresa_ct_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_empresa_ct_tab add constraint xxcofidi_empresa_estado_idx foreign key (id_estado_fk) references xxcofidi_estado_ct_tab(id_estado_pk) on delete no action not deferrable initially immediate;
