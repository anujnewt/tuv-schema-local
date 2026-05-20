-- dmap_object_gen_tag : type : table name : holoapco
set search_path = usrsiho,oracle,dmap_extension,public;
create table "holoapco"  (
apc_keypro numeric(5) not null,
apc_keyapr varchar(6) not null,
apc_keynom numeric(5) not null,
apc_keycon varchar(3) not null,
apc_keytfo varchar(1) not null,
apc_keycom varchar(40),
apc_keycmc varchar(40),
apc_keycdf varchar(40),
apc_keycgt varchar(40)
) ;
-- dmap_object_gen_tag : type : alter table name : holoapco
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoapco add constraint pk_hapco primary key (apc_keypro,apc_keyapr,apc_keynom,apc_keycon,apc_keytfo);
-- dmap_object_gen_tag : type : alter table name : holoapco
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoapco alter column apc_keypro set not null;
-- dmap_object_gen_tag : type : alter table name : holoapco
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoapco alter column apc_keynom set not null;
-- dmap_object_gen_tag : type : alter table name : holoapco
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoapco alter column apc_keycon set not null;
-- dmap_object_gen_tag : type : alter table name : holoapco
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoapco alter column apc_keytfo set not null;
