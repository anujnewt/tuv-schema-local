-- dmap_object_gen_tag : type : table name : nmcodeps
set search_path = labppto,oracle,dmap_extension,public;
create table "nmcodeps"  (
dep_keydep varchar(16) not null,
dep_desdep varchar(40) not null,
dep_refcon varchar(52),
dep_keycen varchar(16),
dep_tipdep varchar(1),
dep_nu1aux varchar(10),
dep_nu2aux varchar(10),
dep_nu3aux varchar(10),
dep_nu4aux varchar(10),
dep_nu5aux varchar(10),
dep_ca1aux varchar(10),
dep_ca2aux varchar(10),
dep_ca3aux varchar(10),
dep_ca4aux varchar(10),
dep_ca5aux varchar(10)
) ;
-- dmap_object_gen_tag : type : alter table name : nmcodeps
set search_path = labppto,oracle,dmap_extension,public;
alter table nmcodeps add constraint nmdeps01 unique (dep_keydep);
-- dmap_object_gen_tag : type : alter table name : nmcodeps
set search_path = labppto,oracle,dmap_extension,public;
alter table nmcodeps alter column dep_keydep set not null;
-- dmap_object_gen_tag : type : alter table name : nmcodeps
set search_path = labppto,oracle,dmap_extension,public;
alter table nmcodeps alter column dep_desdep set not null;
