-- dmap_object_gen_tag : type : table name : holoagcp02
set search_path = usrsiho,oracle,dmap_extension,public;
create table "holoagcp02"  (
agc_keyagr numeric(5) not null,
agc_keycon varchar(3) not null
) ;
-- dmap_object_gen_tag : type : alter table name : holoagcp02
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoagcp02 alter column agc_keyagr set not null;
-- dmap_object_gen_tag : type : alter table name : holoagcp02
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoagcp02 alter column agc_keycon set not null;
