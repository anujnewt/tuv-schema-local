-- dmap_object_gen_tag : type : table name : glcoactc
set search_path = usrsiho,oracle,dmap_extension,public;
create table "glcoactc"  (
act_keytco varchar(6) not null,
act_keyusu numeric(10) not null
) ;
-- dmap_object_gen_tag : type : alter table name : glcoactc
set search_path = usrsiho,oracle,dmap_extension,public;
alter table glcoactc add constraint pk_gactc primary key (act_keytco,act_keyusu);
-- dmap_object_gen_tag : type : alter table name : glcoactc
set search_path = usrsiho,oracle,dmap_extension,public;
alter table glcoactc alter column act_keytco set not null;
-- dmap_object_gen_tag : type : alter table name : glcoactc
set search_path = usrsiho,oracle,dmap_extension,public;
alter table glcoactc alter column act_keyusu set not null;
