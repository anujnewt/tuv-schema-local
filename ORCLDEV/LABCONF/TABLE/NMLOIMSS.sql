-- dmap_object_gen_tag : type : table name : nmloimss
set search_path = labconf,oracle,dmap_extension,public;
create table "nmloimss"  (
ims_keyims varchar(5) not null,
ims_rfcims varchar(14),
ims_razsoc varchar(46),
ims_dirloc varchar(40),
ims_numext varchar(6),
ims_numint varchar(6),
ims_colloc varchar(20),
ims_codpos varchar(5),
ims_munloc varchar(6),
ims_entloc varchar(2),
ims_numban varchar(20),
ims_pririe decimal(12, 6),
ims_tiprie varchar(12),
ims_luggui numeric(10),
ims_actloc varchar(24),
ims_keyban varchar(7),
ims_numcot numeric(5),
ims_bascal numeric(5),
ims_totpag numeric(5),
ims_keycia varchar(5),
ims_cveedi varchar(16),
ims_ca1aux varchar(30),
ims_ca2aux varchar(20),
ims_ca3aux varchar(20),
ims_ca4aux varchar(20),
ims_franum varchar(8)
) ;
-- dmap_object_gen_tag : type : alter table name : nmloimss
set search_path = labconf,oracle,dmap_extension,public;
alter table nmloimss add constraint nmimss01 unique (ims_keyims);
-- dmap_object_gen_tag : type : alter table name : nmloimss
set search_path = labconf,oracle,dmap_extension,public;
alter table nmloimss alter column ims_keyims set not null;
