-- dmap_object_gen_tag : type : table name : emimagen
set search_path = usrsiho,oracle,dmap_extension,public;
create table "emimagen"  (
ima_keyim1 varchar(10) not null,
ima_keyim2 varchar(10),
ima_keyim3 varchar(10),
ima_imagen bytea not null,
ima_tipima varchar(15) not null
) ;
-- dmap_object_gen_tag : type : alter table name : emimagen
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emimagen alter column ima_keyim1 set not null;
-- dmap_object_gen_tag : type : alter table name : emimagen
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emimagen alter column ima_imagen set not null;
-- dmap_object_gen_tag : type : alter table name : emimagen
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emimagen alter column ima_tipima set not null;
