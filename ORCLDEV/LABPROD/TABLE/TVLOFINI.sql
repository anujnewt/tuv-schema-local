-- dmap_object_gen_tag : type : table name : tvlofini
set search_path = labprod,oracle,dmap_extension,public;
create table "tvlofini"  (
fin_keyfin numeric(38) not null,
fin_keyemp numeric(38) not null,
fin_fecing timestamp(0) not null,
fin_fecbaj timestamp(0) not null,
fin_cvebaj varchar(6) not null,
fin_cencos varchar(16) not null,
fin_saldia decimal(12, 6) not null,
fin_status numeric not null,
fin_keypro numeric(38),
fin_keyper varchar(7),
fin_keynom numeric(38),
fin_keydep varchar(16),
fin_keypue varchar(16),
fin_fecpag timestamp(0),
fin_etq001 decimal(12, 6),
fin_etq002 decimal(12, 6),
fin_etq003 decimal(12, 6),
fin_folio decimal(12, 6),
fin_antigu varchar(20)
) ;
-- dmap_object_gen_tag : type : alter table name : tvlofini
set search_path = labprod,oracle,dmap_extension,public;
alter table tvlofini alter column fin_keyfin set not null;
-- dmap_object_gen_tag : type : alter table name : tvlofini
set search_path = labprod,oracle,dmap_extension,public;
alter table tvlofini alter column fin_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : tvlofini
set search_path = labprod,oracle,dmap_extension,public;
alter table tvlofini alter column fin_fecing set not null;
-- dmap_object_gen_tag : type : alter table name : tvlofini
set search_path = labprod,oracle,dmap_extension,public;
alter table tvlofini alter column fin_fecbaj set not null;
-- dmap_object_gen_tag : type : alter table name : tvlofini
set search_path = labprod,oracle,dmap_extension,public;
alter table tvlofini alter column fin_cvebaj set not null;
-- dmap_object_gen_tag : type : alter table name : tvlofini
set search_path = labprod,oracle,dmap_extension,public;
alter table tvlofini alter column fin_cencos set not null;
-- dmap_object_gen_tag : type : alter table name : tvlofini
set search_path = labprod,oracle,dmap_extension,public;
alter table tvlofini alter column fin_saldia set not null;
-- dmap_object_gen_tag : type : alter table name : tvlofini
set search_path = labprod,oracle,dmap_extension,public;
alter table tvlofini alter column fin_status set not null;
