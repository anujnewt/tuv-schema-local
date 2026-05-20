-- dmap_object_gen_tag : type : table name : datosgenerales
set search_path = labprod,oracle,dmap_extension,public;
create table "datosgenerales"  (
gen_recurp varchar(20) not null,
gen_keyemp numeric(10) not null,
gen_nomemp varchar(60) not null,
gen_apepat varchar(60),
gen_apemat varchar(60),
gen_keypro numeric(5),
gen_perpag varchar(1),
gen_cveban varchar(3),
gen_ctaban varchar(18),
gen_fecant timestamp(0),
gen_domemp varchar(100),
gen_colemp varchar(100),
gen_munemp varchar(6),
gen_entemp varchar(2),
gen_codemp varchar(5),
gen_telemp varchar(60),
gen_cidemp varchar(20),
gen_salmes decimal(12, 2) not null,
gen_keyloc varchar(16),
gen_forpag varchar(2),
gen_tpocon varchar(10),
gen_status numeric(5),
gen_numcte varchar(5),
gen_valida varchar(20)
) ;
-- dmap_object_gen_tag : type : alter table name : datosgenerales
set search_path = labprod,oracle,dmap_extension,public;
alter table datosgenerales alter column gen_recurp set not null;
-- dmap_object_gen_tag : type : alter table name : datosgenerales
set search_path = labprod,oracle,dmap_extension,public;
alter table datosgenerales alter column gen_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : datosgenerales
set search_path = labprod,oracle,dmap_extension,public;
alter table datosgenerales alter column gen_nomemp set not null;
-- dmap_object_gen_tag : type : alter table name : datosgenerales
set search_path = labprod,oracle,dmap_extension,public;
alter table datosgenerales alter column gen_salmes set not null;
