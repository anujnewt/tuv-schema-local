-- dmap_object_gen_tag : type : table name : holorepo
set search_path = usrsiho,oracle,dmap_extension,public;
create table "holorepo"  (
rep_keyrep numeric(10) not null,
rep_desrep varchar(60),
rep_proyec varchar(20),
rep_keyusu numeric(5) not null,
rep_fechag timestamp(0),
rep_rutarp varchar(60),
rep_status varchar(1) default 'T'
) ;
-- dmap_object_gen_tag : type : alter table name : holorepo
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holorepo add constraint pk_holorepo primary key (rep_keyrep);
-- dmap_object_gen_tag : type : alter table name : holorepo
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holorepo alter column rep_keyrep set not null;
-- dmap_object_gen_tag : type : alter table name : holorepo
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holorepo alter column rep_keyusu set not null;
