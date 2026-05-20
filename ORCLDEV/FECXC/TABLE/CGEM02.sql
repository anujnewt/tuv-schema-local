-- dmap_object_gen_tag : type : table name : cgem02
set search_path = fecxc,oracle,dmap_extension,public;
create table "cgem02"  (
cgexori char(2) not null,
cgedori varchar(40) not null,
timestamp timestamp
) ;
-- dmap_object_gen_tag : type : alter table name : cgem02
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgem02 add primary key (cgexori);
-- dmap_object_gen_tag : type : alter table name : cgem02
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgem02 alter column cgexori set not null;
-- dmap_object_gen_tag : type : alter table name : cgem02
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgem02 alter column cgedori set not null;
