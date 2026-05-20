-- dmap_object_gen_tag : type : table name : holoequi
set search_path = usrsiho,oracle,dmap_extension,public;
create table "holoequi"  (
equ_keypro numeric(5) not null,
equ_keynom numeric(5) not null,
equ_keyapr numeric(5) not null,
equ_equiva varchar(16) not null
) ;
-- dmap_object_gen_tag : type : alter table name : holoequi
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoequi alter column equ_keypro set not null;
-- dmap_object_gen_tag : type : alter table name : holoequi
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoequi alter column equ_keynom set not null;
-- dmap_object_gen_tag : type : alter table name : holoequi
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoequi alter column equ_keyapr set not null;
-- dmap_object_gen_tag : type : alter table name : holoequi
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoequi alter column equ_equiva set not null;
