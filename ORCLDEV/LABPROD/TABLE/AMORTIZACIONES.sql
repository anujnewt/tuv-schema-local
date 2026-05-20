-- dmap_object_gen_tag : type : table name : amortizaciones
set search_path = labprod,oracle,dmap_extension,public;
create table "amortizaciones"  (
amo_recurp varchar(20) not null,
amo_keyemp numeric(10) not null,
amo_refere varchar(20),
amo_cantid decimal(12, 2),
amo_import decimal(12, 2),
amo_keyper varchar(7),
amo_keypro numeric(5),
amo_keycon varchar(3),
amo_valida varchar(100),
amo_fecmov timestamp(0),
amo_status numeric
) ;
-- dmap_object_gen_tag : type : alter table name : amortizaciones
set search_path = labprod,oracle,dmap_extension,public;
alter table amortizaciones alter column amo_recurp set not null;
-- dmap_object_gen_tag : type : alter table name : amortizaciones
set search_path = labprod,oracle,dmap_extension,public;
alter table amortizaciones alter column amo_keyemp set not null;
