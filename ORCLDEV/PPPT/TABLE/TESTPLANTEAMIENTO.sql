-- dmap_object_gen_tag : type : table name : testplanteamiento
set search_path = pppt,oracle,dmap_extension,public;
create table "testplanteamiento"  (
idplanteamiento numeric(38) not null,
planteamiento varchar(4000)
) ;
-- dmap_object_gen_tag : type : alter table name : testplanteamiento
set search_path = pppt,oracle,dmap_extension,public;
alter table testplanteamiento alter column idplanteamiento set not null;
