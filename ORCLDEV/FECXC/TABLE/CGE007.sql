-- dmap_object_gen_tag : type : table name : cge007
set search_path = fecxc,oracle,dmap_extension,public;
create table "cge007"  (
cge7cod numeric(38) not null,
cge7des varchar(40) not null,
cge7fis varchar(30) not null,
cge7res char(1) not null,
cge15cod char(4) not null,
ts_rversion timestamp
) ;
-- dmap_object_gen_tag : type : alter table name : cge007
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge007 add primary key (cge7cod);
-- dmap_object_gen_tag : type : alter table name : cge007
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge007 alter column cge7cod set not null;
-- dmap_object_gen_tag : type : alter table name : cge007
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge007 alter column cge7des set not null;
-- dmap_object_gen_tag : type : alter table name : cge007
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge007 alter column cge7fis set not null;
-- dmap_object_gen_tag : type : alter table name : cge007
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge007 alter column cge7res set not null;
-- dmap_object_gen_tag : type : alter table name : cge007
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge007 alter column cge15cod set not null;
-- dmap_object_gen_tag : type : alter table name : cge007
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge007 add constraint fk_cge007_cge015 foreign key (cge15cod) references cge015(cge15cod) on delete no action not deferrable initially immediate;
