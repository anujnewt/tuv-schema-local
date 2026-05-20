-- dmap_object_gen_tag : type : table name : cge009
set search_path = fecxc,oracle,dmap_extension,public;
create table "cge009"  (
cge9cod numeric(38) not null,
cge9des varchar(40) not null,
cge9loc varchar(40) not null,
cge9usr varchar(30) not null,
cge9pas varchar(30) not null,
cge9dip varchar(30) not null,
cge9pip varchar(30) not null,
cge13cod numeric(38) not null,
ts_rversion timestamp
) ;
-- dmap_object_gen_tag : type : alter table name : cge009
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge009 add primary key (cge9cod);
-- dmap_object_gen_tag : type : alter table name : cge009
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge009 alter column cge9cod set not null;
-- dmap_object_gen_tag : type : alter table name : cge009
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge009 alter column cge9des set not null;
-- dmap_object_gen_tag : type : alter table name : cge009
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge009 alter column cge9loc set not null;
-- dmap_object_gen_tag : type : alter table name : cge009
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge009 alter column cge9usr set not null;
-- dmap_object_gen_tag : type : alter table name : cge009
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge009 alter column cge9pas set not null;
-- dmap_object_gen_tag : type : alter table name : cge009
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge009 alter column cge9dip set not null;
-- dmap_object_gen_tag : type : alter table name : cge009
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge009 alter column cge9pip set not null;
-- dmap_object_gen_tag : type : alter table name : cge009
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge009 alter column cge13cod set not null;
-- dmap_object_gen_tag : type : alter table name : cge009
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge009 add constraint fk_cge009_cge013 foreign key (cge13cod) references cge013(cge13cod) on delete no action not deferrable initially immediate;
