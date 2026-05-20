-- dmap_object_gen_tag : type : table name : holoagcp
set search_path = usrsiho,oracle,dmap_extension,public;
create table "holoagcp"  (
agc_keyagr numeric(5) not null,
agc_keycon varchar(3) not null
) ;
-- dmap_object_gen_tag : type : alter table name : holoagcp
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoagcp add constraint pk_hagcp primary key (agc_keyagr,agc_keycon);
-- dmap_object_gen_tag : type : alter table name : holoagcp
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoagcp alter column agc_keyagr set not null;
-- dmap_object_gen_tag : type : alter table name : holoagcp
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoagcp alter column agc_keycon set not null;
