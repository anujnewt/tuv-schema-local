-- dmap_object_gen_tag : type : table name : svtempsc
set search_path = labprod,oracle,dmap_extension,public;
create table "svtempsc"  (
id_ope numeric default 0,
num_emp numeric,
num_dia decimal(15, 5) not null,
tipo_sol char(1) not null,
sta_sol char(1) not null,
dia_ini timestamp(0) not null,
dia_fin timestamp(0) not null,
per_vac char(10),
ant_emp numeric,
fec_sol timestamp(0),
con_emp numeric
) ;
-- dmap_object_gen_tag : type : alter table name : svtempsc
set search_path = labprod,oracle,dmap_extension,public;
alter table svtempsc alter column num_dia set not null;
-- dmap_object_gen_tag : type : alter table name : svtempsc
set search_path = labprod,oracle,dmap_extension,public;
alter table svtempsc alter column tipo_sol set not null;
-- dmap_object_gen_tag : type : alter table name : svtempsc
set search_path = labprod,oracle,dmap_extension,public;
alter table svtempsc alter column sta_sol set not null;
-- dmap_object_gen_tag : type : alter table name : svtempsc
set search_path = labprod,oracle,dmap_extension,public;
alter table svtempsc alter column dia_ini set not null;
-- dmap_object_gen_tag : type : alter table name : svtempsc
set search_path = labprod,oracle,dmap_extension,public;
alter table svtempsc alter column dia_fin set not null;
