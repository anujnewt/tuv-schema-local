-- dmap_object_gen_tag : type : table name : holoreme
set search_path = usrsiho,oracle,dmap_extension,public;
create table "holoreme"  (
rem_keypro numeric(5) not null,
rem_keyapr varchar(6) not null,
rem_keytir varchar(1) not null,
rem_keyrem numeric(10) not null,
rem_stsrem varchar(6) not null,
rem_keyusr numeric(5) not null,
rem_fecrem timestamp(0) not null,
rem_keyusa numeric(5),
rem_fecaut timestamp(0)
) ;
-- dmap_object_gen_tag : type : alter table name : holoreme
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoreme add constraint pk_hreme primary key (rem_keypro,rem_keyapr,rem_keytir,rem_keyrem);
-- dmap_object_gen_tag : type : alter table name : holoreme
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoreme alter column rem_keypro set not null;
-- dmap_object_gen_tag : type : alter table name : holoreme
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoreme alter column rem_keyapr set not null;
-- dmap_object_gen_tag : type : alter table name : holoreme
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoreme alter column rem_keytir set not null;
-- dmap_object_gen_tag : type : alter table name : holoreme
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoreme alter column rem_keyrem set not null;
-- dmap_object_gen_tag : type : alter table name : holoreme
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoreme alter column rem_stsrem set not null;
-- dmap_object_gen_tag : type : alter table name : holoreme
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoreme alter column rem_keyusr set not null;
-- dmap_object_gen_tag : type : alter table name : holoreme
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoreme alter column rem_fecrem set not null;
