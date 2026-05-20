-- dmap_object_gen_tag : type : table name : nmlohico
set search_path = labprod,oracle,dmap_extension,public;
create table "nmlohico"  (
hic_keypro numeric(5) not null,
hic_keycon varchar(3) not null,
hic_numper varchar(7),
hic_keynom numeric(5),
hic_cantid decimal(16, 2),
hic_import decimal(16, 2),
hic_keycia varchar(2),
hic_totemp numeric(10),
hic_keydep varchar(16),
hic_codimp varchar(2),
hic_mesacu numeric(5)
) ;
-- dmap_object_gen_tag : type : alter table name : nmlohico
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlohico alter column hic_keypro set not null;
-- dmap_object_gen_tag : type : alter table name : nmlohico
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlohico alter column hic_keycon set not null;
