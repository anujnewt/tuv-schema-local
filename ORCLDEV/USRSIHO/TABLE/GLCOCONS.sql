-- dmap_object_gen_tag : type : table name : glcocons
set search_path = usrsiho,oracle,dmap_extension,public;
create table "glcocons"  (
con_keycvc numeric(10) not null,
con_keyemp numeric(10) not null,
con_keypro numeric(5),
con_keyapr numeric(5),
con_fecalt timestamp(0)
) ;
-- dmap_object_gen_tag : type : alter table name : glcocons
set search_path = usrsiho,oracle,dmap_extension,public;
alter table glcocons alter column con_keycvc set not null;
-- dmap_object_gen_tag : type : alter table name : glcocons
set search_path = usrsiho,oracle,dmap_extension,public;
alter table glcocons alter column con_keyemp set not null;
