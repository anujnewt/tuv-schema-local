-- dmap_object_gen_tag : type : table name : nmexeninci
set search_path = labconf,oracle,dmap_extension,public;
create table "nmexeninci"  (
inc_keyemp numeric(38) not null,
inc_semana numeric(38) not null,
inc_keypro numeric(38) not null,
inc_keycon varchar(12) not null,
inc_exento decimal(12, 2)
) ;
-- dmap_object_gen_tag : type : alter table name : nmexeninci
set search_path = labconf,oracle,dmap_extension,public;
alter table nmexeninci alter column inc_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : nmexeninci
set search_path = labconf,oracle,dmap_extension,public;
alter table nmexeninci alter column inc_semana set not null;
-- dmap_object_gen_tag : type : alter table name : nmexeninci
set search_path = labconf,oracle,dmap_extension,public;
alter table nmexeninci alter column inc_keypro set not null;
-- dmap_object_gen_tag : type : alter table name : nmexeninci
set search_path = labconf,oracle,dmap_extension,public;
alter table nmexeninci alter column inc_keycon set not null;
