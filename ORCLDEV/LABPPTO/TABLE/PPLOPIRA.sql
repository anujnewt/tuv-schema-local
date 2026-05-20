-- dmap_object_gen_tag : type : table name : pplopira
set search_path = labppto,oracle,dmap_extension,public;
create table "pplopira"  (
pir_keycia varchar(4) not null,
pir_keyver numeric(38) not null,
pir_importe decimal(20, 2) not null,
pir_313 decimal(20, 2) not null,
pir_353 decimal(20, 2) not null,
pir_325 decimal(20, 2) not null,
pir_103 decimal(20, 2) not null,
pir_105 decimal(20, 2) not null,
pir_225 decimal(20, 2) not null
) ;
-- dmap_object_gen_tag : type : alter table name : pplopira
set search_path = labppto,oracle,dmap_extension,public;
alter table pplopira alter column pir_keycia set not null;
-- dmap_object_gen_tag : type : alter table name : pplopira
set search_path = labppto,oracle,dmap_extension,public;
alter table pplopira alter column pir_keyver set not null;
-- dmap_object_gen_tag : type : alter table name : pplopira
set search_path = labppto,oracle,dmap_extension,public;
alter table pplopira alter column pir_importe set not null;
-- dmap_object_gen_tag : type : alter table name : pplopira
set search_path = labppto,oracle,dmap_extension,public;
alter table pplopira alter column pir_313 set not null;
-- dmap_object_gen_tag : type : alter table name : pplopira
set search_path = labppto,oracle,dmap_extension,public;
alter table pplopira alter column pir_353 set not null;
-- dmap_object_gen_tag : type : alter table name : pplopira
set search_path = labppto,oracle,dmap_extension,public;
alter table pplopira alter column pir_325 set not null;
-- dmap_object_gen_tag : type : alter table name : pplopira
set search_path = labppto,oracle,dmap_extension,public;
alter table pplopira alter column pir_103 set not null;
-- dmap_object_gen_tag : type : alter table name : pplopira
set search_path = labppto,oracle,dmap_extension,public;
alter table pplopira alter column pir_105 set not null;
-- dmap_object_gen_tag : type : alter table name : pplopira
set search_path = labppto,oracle,dmap_extension,public;
alter table pplopira alter column pir_225 set not null;
