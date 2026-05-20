-- dmap_object_gen_tag : type : table name : xxcofidi_usuario_ldap_tab_bk
set search_path = cofidi,oracle,dmap_extension,public;
create table "xxcofidi_usuario_ldap_tab_bk"  (
id_usuario_ldap_pk numeric not null,
nom_usuario_ldap varchar(50) not null,
cve_usuario_ldap varchar(50) not null,
puerto varchar(10) not null,
host varchar(50) not null,
dominio varchar(50) not null,
tipo_autenticacion varchar(50) not null,
dc1 varchar(20),
dc2 varchar(20),
dc3 varchar(20),
dc4 varchar(20)
) ;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_usuario_ldap_tab_bk
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_usuario_ldap_tab_bk alter column id_usuario_ldap_pk set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_usuario_ldap_tab_bk
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_usuario_ldap_tab_bk alter column nom_usuario_ldap set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_usuario_ldap_tab_bk
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_usuario_ldap_tab_bk alter column cve_usuario_ldap set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_usuario_ldap_tab_bk
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_usuario_ldap_tab_bk alter column puerto set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_usuario_ldap_tab_bk
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_usuario_ldap_tab_bk alter column host set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_usuario_ldap_tab_bk
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_usuario_ldap_tab_bk alter column dominio set not null;
-- dmap_object_gen_tag : type : alter table name : xxcofidi_usuario_ldap_tab_bk
set search_path = cofidi,oracle,dmap_extension,public;
alter table xxcofidi_usuario_ldap_tab_bk alter column tipo_autenticacion set not null;
