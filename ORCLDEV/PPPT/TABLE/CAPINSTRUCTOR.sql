-- dmap_object_gen_tag : type : table name : capinstructor
set search_path = pppt,oracle,dmap_extension,public;
create table "capinstructor"  (
idinstructor numeric(38) not null default 0,
instructor varchar(100) not null,
telefonos varchar(100),
email varchar(100),
titulo varchar(100),
idempresa numeric(38) not null default 0
) ;
-- dmap_object_gen_tag : type : alter table name : capinstructor
set search_path = pppt,oracle,dmap_extension,public;
alter table capinstructor alter column idinstructor set not null;
-- dmap_object_gen_tag : type : alter table name : capinstructor
set search_path = pppt,oracle,dmap_extension,public;
alter table capinstructor alter column instructor set not null;
-- dmap_object_gen_tag : type : alter table name : capinstructor
set search_path = pppt,oracle,dmap_extension,public;
alter table capinstructor alter column idempresa set not null;
