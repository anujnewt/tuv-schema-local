-- dmap_object_gen_tag : type : table name : tvloface
set search_path = labprod,oracle,dmap_extension,public;
create table "tvloface"  (
fen_keypro numeric(5) not null,
fen_keyper varchar(7) not null,
fen_keyfac varchar(30) not null,
fen_fecpol timestamp(0) not null,
fen_keyban varchar(30),
fen_status varchar(1) not null,
fen_keyemp numeric(10) not null,
fen_descri varchar(100) not null,
fen_totreg numeric(38) not null,
fen_import decimal(16, 2) not null,
fen_fecfon timestamp(0) not null,
fen_tipfac varchar(1) not null,
fen_refcon varchar(30)
) ;
-- dmap_object_gen_tag : type : alter table name : tvloface
set search_path = labprod,oracle,dmap_extension,public;
alter table tvloface alter column fen_keypro set not null;
-- dmap_object_gen_tag : type : alter table name : tvloface
set search_path = labprod,oracle,dmap_extension,public;
alter table tvloface alter column fen_keyper set not null;
-- dmap_object_gen_tag : type : alter table name : tvloface
set search_path = labprod,oracle,dmap_extension,public;
alter table tvloface alter column fen_keyfac set not null;
-- dmap_object_gen_tag : type : alter table name : tvloface
set search_path = labprod,oracle,dmap_extension,public;
alter table tvloface alter column fen_fecpol set not null;
-- dmap_object_gen_tag : type : alter table name : tvloface
set search_path = labprod,oracle,dmap_extension,public;
alter table tvloface alter column fen_status set not null;
-- dmap_object_gen_tag : type : alter table name : tvloface
set search_path = labprod,oracle,dmap_extension,public;
alter table tvloface alter column fen_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : tvloface
set search_path = labprod,oracle,dmap_extension,public;
alter table tvloface alter column fen_descri set not null;
-- dmap_object_gen_tag : type : alter table name : tvloface
set search_path = labprod,oracle,dmap_extension,public;
alter table tvloface alter column fen_totreg set not null;
-- dmap_object_gen_tag : type : alter table name : tvloface
set search_path = labprod,oracle,dmap_extension,public;
alter table tvloface alter column fen_import set not null;
-- dmap_object_gen_tag : type : alter table name : tvloface
set search_path = labprod,oracle,dmap_extension,public;
alter table tvloface alter column fen_fecfon set not null;
-- dmap_object_gen_tag : type : alter table name : tvloface
set search_path = labprod,oracle,dmap_extension,public;
alter table tvloface alter column fen_tipfac set not null;
