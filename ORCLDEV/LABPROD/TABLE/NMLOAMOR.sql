-- dmap_object_gen_tag : type : table name : nmloamor
set search_path = labprod,oracle,dmap_extension,public;
create table "nmloamor"  (
amo_keyemp numeric(10),
amo_keycon varchar(3),
amo_keypre decimal(16, 6) not null,
amo_refere varchar(20),
amo_keypro numeric(5),
amo_keydep varchar(16),
amo_keypue varchar(16),
amo_keycat varchar(16),
amo_keyubi varchar(16),
amo_keyper varchar(7),
amo_keynom numeric(5),
amo_numpag numeric(5),
amo_tiptra varchar(2),
amo_refpag varchar(10),
amo_fecpag timestamp(0),
amo_imppag decimal(12, 2),
amo_unipag decimal(12, 2),
amo_intpag decimal(12, 2),
amo_porint decimal(6, 4),
amo_conpro varchar(3),
amo_fecnom timestamp(0),
amo_ctreve varchar(16),
amo_ca1aux varchar(10),
amo_ca2aux varchar(10),
amo_uniope numeric(5)
) ;
-- dmap_object_gen_tag : type : alter table name : nmloamor
set search_path = labprod,oracle,dmap_extension,public;
alter table nmloamor alter column amo_keypre set not null;
