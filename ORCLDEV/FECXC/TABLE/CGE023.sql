-- dmap_object_gen_tag : type : table name : cge023
set search_path = fecxc,oracle,dmap_extension,public;
create table "cge023"  (
cge11cod numeric(38) not null,
cge1cod char(5) not null,
ts_rversion timestamp
) ;
-- dmap_object_gen_tag : type : alter table name : cge023
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge023 add primary key (cge11cod,cge1cod);
-- dmap_object_gen_tag : type : alter table name : cge023
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge023 alter column cge11cod set not null;
-- dmap_object_gen_tag : type : alter table name : cge023
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge023 alter column cge1cod set not null;
-- dmap_object_gen_tag : type : alter table name : cge023
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge023 add constraint fk_cge023_cge001 foreign key (cge1cod) references cge001(cge1cod) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : cge023
set search_path = fecxc,oracle,dmap_extension,public;
alter table cge023 add constraint fk_cge023_cge011 foreign key (cge11cod) references cge011(cge11cod) on delete no action not deferrable initially immediate;
