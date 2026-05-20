-- dmap_object_gen_tag : type : table name : empercomple
set search_path = usrsiho,oracle,dmap_extension,public;
create table "empercomple"  (
per_keyper numeric(10) not null,
per_keyemp numeric(10) not null,
per_keypue numeric(10),
per_altura numeric,
per_keycom numeric(5),
per_pesokg numeric,
per_keytez numeric(5),
per_keytoj numeric(5),
per_keycoj numeric(5),
per_keycab numeric(5),
per_keynar numeric(5),
per_lugnac varchar(60),
per_keyedc numeric(5),
per_keyboc numeric(5),
per_estatu varchar(1),
per_keyfol numeric
) ;
-- dmap_object_gen_tag : type : alter table name : empercomple
set search_path = usrsiho,oracle,dmap_extension,public;
alter table empercomple alter column per_keyper set not null;
-- dmap_object_gen_tag : type : alter table name : empercomple
set search_path = usrsiho,oracle,dmap_extension,public;
alter table empercomple alter column per_keyemp set not null;
