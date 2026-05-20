-- dmap_object_gen_tag : type : table name : bmb1_regiones
set search_path = pppt,oracle,dmap_extension,public;
create table "bmb1_regiones"  (
idregion numeric(38) not null default 0,
region varchar(50)
) ;
-- dmap_object_gen_tag : type : alter table name : bmb1_regiones
set search_path = pppt,oracle,dmap_extension,public;
alter table bmb1_regiones alter column idregion set not null;
