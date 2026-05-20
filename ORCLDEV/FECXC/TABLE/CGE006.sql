-- dmap_object_gen_tag : type : table name : cge006
set search_path = fecxc,oracle,dmap_extension,public;
create table "cge006"  (
pr1cod numeric(38) not null,
pr1nom varchar(50) not null,
timestamp timestamp
) ;
-- dmap_object_gen_tag : type : alter table name : cge006
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge006 add primary key (pr1cod);
-- dmap_object_gen_tag : type : alter table name : cge006
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge006 alter column pr1cod set not null;
-- dmap_object_gen_tag : type : alter table name : cge006
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge006 alter column pr1nom set not null;
