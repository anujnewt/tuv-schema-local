-- dmap_object_gen_tag : type : table name : nmlocanr
set search_path = labprod,oracle,dmap_extension,public;
create table "nmlocanr"  (
can_keyemp numeric(38) not null,
can_keypro numeric(5) not null,
can_perori varchar(7) not null,
can_percan varchar(7) not null,
can_fecreg timestamp(0),
can_horreg varchar(10),
can_keyusu numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : nmlocanr
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlocanr alter column can_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : nmlocanr
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlocanr alter column can_keypro set not null;
-- dmap_object_gen_tag : type : alter table name : nmlocanr
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlocanr alter column can_perori set not null;
-- dmap_object_gen_tag : type : alter table name : nmlocanr
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlocanr alter column can_percan set not null;
