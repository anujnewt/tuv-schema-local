-- dmap_object_gen_tag : type : table name : cgem03
set search_path = fecxc,oracle,dmap_extension,public;
create table "cgem03"  (
cgexori char(2) not null,
cgexsub char(2) not null,
cgedsub varchar(40) not null,
cgexest char(1) not null,
timestamp timestamp
) ;
-- dmap_object_gen_tag : type : alter table name : cgem03
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgem03 add primary key (cgexori,cgexsub);
-- dmap_object_gen_tag : type : alter table name : cgem03
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgem03 alter column cgexori set not null;
-- dmap_object_gen_tag : type : alter table name : cgem03
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgem03 alter column cgexsub set not null;
-- dmap_object_gen_tag : type : alter table name : cgem03
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgem03 alter column cgedsub set not null;
-- dmap_object_gen_tag : type : alter table name : cgem03
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgem03 alter column cgexest set not null;
-- dmap_object_gen_tag : type : alter table name : cgem03
set search_path = fecxc,oracle,dmap_extension,public;
alter table cgem03 add constraint fk_cgem03_cgem02 foreign key (cgexori) references cgem02(cgexori) on delete no action not deferrable initially immediate;
