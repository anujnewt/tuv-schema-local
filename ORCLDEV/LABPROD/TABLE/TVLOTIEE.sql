-- dmap_object_gen_tag : type : table name : tvlotiee
set search_path = labprod,oracle,dmap_extension,public;
create table "tvlotiee"  (
tie_keytie numeric(38),
tie_keyemp numeric(38) not null,
tie_keypro numeric(38) not null,
tie_keyper varchar(7) not null,
tie_keysem varchar(6) not null,
tie_keycon varchar(3) not null,
tie_uni001 decimal(6, 2) not null,
tie_uni002 decimal(6, 2) not null,
tie_uni003 decimal(6, 2) not null,
tie_uni004 decimal(6, 2) not null,
tie_uni005 decimal(6, 2) not null,
tie_uni006 decimal(6, 2) not null,
tie_uni007 decimal(6, 2) not null,
tie_hordob decimal(6, 2) not null,
tie_hortri decimal(6, 2) not null,
tie_impdob decimal(12, 2) not null,
tie_imptri decimal(12, 2) not null,
tie_impgra decimal(12, 2) not null,
tie_impexe decimal(12, 2) not null,
tie_salhor decimal(12, 2) not null,
tie_incdob decimal(16, 6),
tie_inctri decimal(16, 6),
tie_keyusu numeric(38) not null,
tie_fecmod timestamp(0) not null,
tie_hormod varchar(10) not null
) ;
-- dmap_object_gen_tag : type : alter table name : tvlotiee
set search_path = labprod,oracle,dmap_extension,public;
alter table tvlotiee alter column tie_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : tvlotiee
set search_path = labprod,oracle,dmap_extension,public;
alter table tvlotiee alter column tie_keypro set not null;
-- dmap_object_gen_tag : type : alter table name : tvlotiee
set search_path = labprod,oracle,dmap_extension,public;
alter table tvlotiee alter column tie_keyper set not null;
-- dmap_object_gen_tag : type : alter table name : tvlotiee
set search_path = labprod,oracle,dmap_extension,public;
alter table tvlotiee alter column tie_keysem set not null;
-- dmap_object_gen_tag : type : alter table name : tvlotiee
set search_path = labprod,oracle,dmap_extension,public;
alter table tvlotiee alter column tie_keycon set not null;
-- dmap_object_gen_tag : type : alter table name : tvlotiee
set search_path = labprod,oracle,dmap_extension,public;
alter table tvlotiee alter column tie_uni001 set not null;
-- dmap_object_gen_tag : type : alter table name : tvlotiee
set search_path = labprod,oracle,dmap_extension,public;
alter table tvlotiee alter column tie_uni002 set not null;
-- dmap_object_gen_tag : type : alter table name : tvlotiee
set search_path = labprod,oracle,dmap_extension,public;
alter table tvlotiee alter column tie_uni003 set not null;
-- dmap_object_gen_tag : type : alter table name : tvlotiee
set search_path = labprod,oracle,dmap_extension,public;
alter table tvlotiee alter column tie_uni004 set not null;
-- dmap_object_gen_tag : type : alter table name : tvlotiee
set search_path = labprod,oracle,dmap_extension,public;
alter table tvlotiee alter column tie_uni005 set not null;
-- dmap_object_gen_tag : type : alter table name : tvlotiee
set search_path = labprod,oracle,dmap_extension,public;
alter table tvlotiee alter column tie_uni006 set not null;
-- dmap_object_gen_tag : type : alter table name : tvlotiee
set search_path = labprod,oracle,dmap_extension,public;
alter table tvlotiee alter column tie_uni007 set not null;
-- dmap_object_gen_tag : type : alter table name : tvlotiee
set search_path = labprod,oracle,dmap_extension,public;
alter table tvlotiee alter column tie_hordob set not null;
-- dmap_object_gen_tag : type : alter table name : tvlotiee
set search_path = labprod,oracle,dmap_extension,public;
alter table tvlotiee alter column tie_hortri set not null;
-- dmap_object_gen_tag : type : alter table name : tvlotiee
set search_path = labprod,oracle,dmap_extension,public;
alter table tvlotiee alter column tie_impdob set not null;
-- dmap_object_gen_tag : type : alter table name : tvlotiee
set search_path = labprod,oracle,dmap_extension,public;
alter table tvlotiee alter column tie_imptri set not null;
-- dmap_object_gen_tag : type : alter table name : tvlotiee
set search_path = labprod,oracle,dmap_extension,public;
alter table tvlotiee alter column tie_impgra set not null;
-- dmap_object_gen_tag : type : alter table name : tvlotiee
set search_path = labprod,oracle,dmap_extension,public;
alter table tvlotiee alter column tie_impexe set not null;
-- dmap_object_gen_tag : type : alter table name : tvlotiee
set search_path = labprod,oracle,dmap_extension,public;
alter table tvlotiee alter column tie_salhor set not null;
-- dmap_object_gen_tag : type : alter table name : tvlotiee
set search_path = labprod,oracle,dmap_extension,public;
alter table tvlotiee alter column tie_keyusu set not null;
-- dmap_object_gen_tag : type : alter table name : tvlotiee
set search_path = labprod,oracle,dmap_extension,public;
alter table tvlotiee alter column tie_fecmod set not null;
-- dmap_object_gen_tag : type : alter table name : tvlotiee
set search_path = labprod,oracle,dmap_extension,public;
alter table tvlotiee alter column tie_hormod set not null;
