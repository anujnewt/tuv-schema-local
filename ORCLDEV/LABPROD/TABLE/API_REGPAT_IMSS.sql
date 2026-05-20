-- dmap_object_gen_tag : type : table name : api_regpat_imss
set search_path = labprod,oracle,dmap_extension,public;
create table "api_regpat_imss"  (
id_transaccion varchar(30) not null,
ims_keyims varchar(14) not null,
ims_rfcims varchar(14) not null,
ims_razsoc varchar(40) not null,
ims_dirloc varchar(40),
ims_numext varchar(6),
ims_numint varchar(6),
ims_colloc varchar(20),
ims_codpos varchar(5),
ims_munloc varchar(6),
ims_entloc varchar(2),
ims_numban varchar(20),
ims_pririe numeric,
ims_tiprie varchar(12),
ims_luggui numeric,
ims_actloc varchar(24),
ims_keyban varchar(7),
ims_numcot numeric,
ims_bascal numeric,
ims_totpag numeric,
ims_keycia varchar(2),
ims_cveedi varchar(16),
ims_ca1aux varchar(30),
ims_ca2aux varchar(20),
ims_ca3aux varchar(20),
ims_ca4aux varchar(20),
ims_franum varchar(8),
status varchar(20),
code varchar(150),
message varchar(150),
fecha timestamp(0),
fecha_insert timestamp(0),
fecha_proc timestamp(0)
) ;
-- dmap_object_gen_tag : type : alter table name : api_regpat_imss
set search_path = labprod,oracle,dmap_extension,public;
alter table api_regpat_imss alter column id_transaccion set not null;
-- dmap_object_gen_tag : type : alter table name : api_regpat_imss
set search_path = labprod,oracle,dmap_extension,public;
alter table api_regpat_imss alter column ims_keyims set not null;
-- dmap_object_gen_tag : type : alter table name : api_regpat_imss
set search_path = labprod,oracle,dmap_extension,public;
alter table api_regpat_imss alter column ims_rfcims set not null;
-- dmap_object_gen_tag : type : alter table name : api_regpat_imss
set search_path = labprod,oracle,dmap_extension,public;
alter table api_regpat_imss alter column ims_razsoc set not null;
