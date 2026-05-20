-- dmap_object_gen_tag : type : table name : svtempdia
set search_path = labprod,oracle,dmap_extension,public;
create table "svtempdia"  (
num_emp numeric,
num_dia timestamp(0) not null,
is_medio numeric(38) not null,
per_vac char(10) not null
) ;
-- dmap_object_gen_tag : type : alter table name : svtempdia
set search_path = labprod,oracle,dmap_extension,public;
alter table svtempdia alter column num_dia set not null;
-- dmap_object_gen_tag : type : alter table name : svtempdia
set search_path = labprod,oracle,dmap_extension,public;
alter table svtempdia alter column is_medio set not null;
-- dmap_object_gen_tag : type : alter table name : svtempdia
set search_path = labprod,oracle,dmap_extension,public;
alter table svtempdia alter column per_vac set not null;
