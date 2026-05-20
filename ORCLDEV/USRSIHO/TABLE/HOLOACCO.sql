-- dmap_object_gen_tag : type : table name : holoacco
set search_path = usrsiho,oracle,dmap_extension,public;
create table "holoacco"  (
acc_keytco numeric(10) not null,
acc_keyapr varchar(6) not null,
acc_keypue varchar(16) not null
) ;
-- dmap_object_gen_tag : type : alter table name : holoacco
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoacco alter column acc_keytco set not null;
-- dmap_object_gen_tag : type : alter table name : holoacco
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoacco alter column acc_keyapr set not null;
-- dmap_object_gen_tag : type : alter table name : holoacco
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoacco alter column acc_keypue set not null;
