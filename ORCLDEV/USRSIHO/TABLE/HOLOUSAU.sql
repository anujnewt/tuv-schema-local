-- dmap_object_gen_tag : type : table name : holousau
set search_path = usrsiho,oracle,dmap_extension,public;
create table "holousau"  (
usa_keypro numeric(5) not null,
usa_keyapr varchar(6) not null,
usa_keyusu numeric(10) not null,
usa_passwd varchar(20) not null
) ;
-- dmap_object_gen_tag : type : alter table name : holousau
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holousau add constraint pk_husau primary key (usa_keypro,usa_keyapr,usa_keyusu);
-- dmap_object_gen_tag : type : alter table name : holousau
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holousau alter column usa_keypro set not null;
-- dmap_object_gen_tag : type : alter table name : holousau
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holousau alter column usa_keyapr set not null;
-- dmap_object_gen_tag : type : alter table name : holousau
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holousau alter column usa_keyusu set not null;
-- dmap_object_gen_tag : type : alter table name : holousau
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holousau alter column usa_passwd set not null;
