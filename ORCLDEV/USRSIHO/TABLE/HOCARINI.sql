-- dmap_object_gen_tag : type : table name : hocarini
set search_path = usrsiho,oracle,dmap_extension,public;
create table "hocarini"  (
car_ejerci numeric(10) not null,
car_keyemp numeric(10) not null,
car_nomben varchar(60),
car_keyapr varchar(6),
car_keynom numeric(5) not null,
car_numemi numeric(10) not null,
car_cvefac varchar(30),
car_stsrec numeric(5) not null,
car_import decimal(16, 2),
car_fecpag timestamp(0),
car_feccob timestamp(0)
) ;
-- dmap_object_gen_tag : type : alter table name : hocarini
set search_path = usrsiho,oracle,dmap_extension,public;
alter table hocarini alter column car_ejerci set not null;
-- dmap_object_gen_tag : type : alter table name : hocarini
set search_path = usrsiho,oracle,dmap_extension,public;
alter table hocarini alter column car_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : hocarini
set search_path = usrsiho,oracle,dmap_extension,public;
alter table hocarini alter column car_keynom set not null;
-- dmap_object_gen_tag : type : alter table name : hocarini
set search_path = usrsiho,oracle,dmap_extension,public;
alter table hocarini alter column car_numemi set not null;
-- dmap_object_gen_tag : type : alter table name : hocarini
set search_path = usrsiho,oracle,dmap_extension,public;
alter table hocarini alter column car_stsrec set not null;
