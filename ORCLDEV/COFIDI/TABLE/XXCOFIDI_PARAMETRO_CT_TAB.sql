-- dmap_object_gen_tag : type : table name : xxcofidi_parametro_ct_tab
set search_path = cofidi,oracle,dmap_extension,public;
create table "xxcofidi_parametro_ct_tab"  (
id_parametro_pk numeric(38) not null,
valor varchar(255) not null,
des_parametro varchar(255),
orden numeric(2)
) ;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_parametro_ct_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_parametro_ct_tab add constraint xxcofidi_parametro_pk_idx01 primary key (id_parametro_pk);
-- dmap_object_gen_tag : type : alter table name : xxcofidi_parametro_ct_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_parametro_ct_tab alter column id_parametro_pk set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_parametro_ct_tab
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_parametro_ct_tab alter column valor set not null;
