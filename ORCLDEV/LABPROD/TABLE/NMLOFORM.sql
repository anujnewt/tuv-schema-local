-- dmap_object_gen_tag : type : table name : nmloform
set search_path = labprod,oracle,dmap_extension,public;
create table "nmloform"  (
for_keyfor varchar(4) not null,
for_numins numeric(5),
for_opera1 varchar(16),
for_operad varchar(16),
for_opera2 varchar(16),
for_result varchar(16)
) ;
-- dmap_object_gen_tag : type : alter table name : nmloform
set search_path = labprod,oracle,dmap_extension,public;
alter table nmloform alter column for_keyfor set not null;
