-- dmap_object_gen_tag : type : table name : holoapco2
set search_path = usrsiho,oracle,dmap_extension,public;
create table "holoapco2"  (
apc_keypro numeric(5) not null,
apc_keyapr varchar(6),
apc_keynom numeric(5) not null,
apc_keycon varchar(3) not null,
apc_keytfo varchar(1) not null,
apc_cia varchar(3),
apc_neg varchar(2),
apc_cta varchar(3),
apc_scta varchar(6),
apc_cc varchar(8),
apc_icia varchar(3),
apc_top varchar(1),
apc_c_cia varchar(3),
apc_c_neg varchar(2),
apc_c_cta varchar(3),
apc_c_scta varchar(6),
apc_c_cc varchar(8),
apc_c_icia varchar(3),
apc_c_top varchar(1)
) ;
-- dmap_object_gen_tag : type : alter table name : holoapco2
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoapco2 alter column apc_keypro set not null;
-- dmap_object_gen_tag : type : alter table name : holoapco2
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoapco2 alter column apc_keynom set not null;
-- dmap_object_gen_tag : type : alter table name : holoapco2
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoapco2 alter column apc_keycon set not null;
-- dmap_object_gen_tag : type : alter table name : holoapco2
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoapco2 alter column apc_keytfo set not null;
