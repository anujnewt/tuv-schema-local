-- dmap_object_gen_tag : type : table name : comparacionpuestotxt
set search_path = pppt,oracle,dmap_extension,public;
create table "comparacionpuestotxt"  (
idcomparacion numeric(38) not null,
puesto1 varchar(50),
puesto2 varchar(50),
puesto3 varchar(50),
puesto4 varchar(50),
puesto5 varchar(50),
puesto6 varchar(50),
puesto7 varchar(50),
puesto8 varchar(50),
puesto9 varchar(50),
puesto10 varchar(50)
) ;
-- dmap_object_gen_tag : type : alter table name : comparacionpuestotxt
set search_path = pppt,oracle,dmap_extension,public;
alter table comparacionpuestotxt alter column idcomparacion set not null;
