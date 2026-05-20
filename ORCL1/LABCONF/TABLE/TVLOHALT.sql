-- dmap_object_gen_tag : type : table name : tvlohalt
set search_path = labconf,oracle,dmap_extension,public;
create table "tvlohalt"  (
hal_keypro numeric(38) not null,
hal_keyper varchar(7) not null,
hal_keynom numeric(38) not null,
hal_keydep varchar(16),
hal_keycen varchar(16),
hal_refcon varchar(9),
hal_tpoemp varchar(6),
hal_keyemp numeric(38),
hal_vicrh varchar(10),
hal_viccon varchar(10),
hal_keyplz numeric(38),
hal_salmes decimal(12, 2),
hal_status numeric(38),
hal_fecaum timestamp(0)
) ;
-- dmap_object_gen_tag : type : alter table name : tvlohalt
set search_path = labconf,oracle,dmap_extension,public;
alter table tvlohalt alter column hal_keypro set not null;
-- dmap_object_gen_tag : type : alter table name : tvlohalt
set search_path = labconf,oracle,dmap_extension,public;
alter table tvlohalt alter column hal_keyper set not null;
-- dmap_object_gen_tag : type : alter table name : tvlohalt
set search_path = labconf,oracle,dmap_extension,public;
alter table tvlohalt alter column hal_keynom set not null;
