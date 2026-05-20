-- dmap_object_gen_tag : type : table name : datosgenerales_errsaf
set search_path = labprod,oracle,dmap_extension,public;
create table "datosgenerales_errsaf"  (
empleado numeric(10) not null default 0,
tipo varchar(10) not null,
fecha timestamp(0) not null,
query varchar(300)
) ;
-- dmap_object_gen_tag : type : alter table name : datosgenerales_errsaf
set search_path = labprod,oracle,dmap_extension,public;
alter table datosgenerales_errsaf alter column empleado set not null;
-- dmap_object_gen_tag : type : alter table name : datosgenerales_errsaf
set search_path = labprod,oracle,dmap_extension,public;
alter table datosgenerales_errsaf alter column tipo set not null;
-- dmap_object_gen_tag : type : alter table name : datosgenerales_errsaf
set search_path = labprod,oracle,dmap_extension,public;
alter table datosgenerales_errsaf alter column fecha set not null;
