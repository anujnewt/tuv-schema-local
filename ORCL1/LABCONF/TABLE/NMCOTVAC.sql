-- dmap_object_gen_tag : type : table name : nmcotvac
set search_path = labconf,oracle,dmap_extension,public;
create table "nmcotvac"  (
ant_keypro varchar(1) not null,
ant_antigu numeric(38) not null,
ant_diavac numeric(38),
ant_facvac decimal(10, 2)
) ;
-- dmap_object_gen_tag : type : alter table name : nmcotvac
set search_path = labconf,oracle,dmap_extension,public;
alter table nmcotvac alter column ant_keypro set not null;
-- dmap_object_gen_tag : type : alter table name : nmcotvac
set search_path = labconf,oracle,dmap_extension,public;
alter table nmcotvac alter column ant_antigu set not null;
