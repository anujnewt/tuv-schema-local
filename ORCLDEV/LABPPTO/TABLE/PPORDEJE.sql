-- dmap_object_gen_tag : type : table name : ppordeje
set search_path = labppto,oracle,dmap_extension,public;
create table "ppordeje"  (
eje_keycia varchar(4) not null,
eje_keyver numeric(38) not null,
eje_keycon varchar(3) not null,
eje_feceje timestamp(0),
eje_status numeric(38),
eje_ordeje numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : ppordeje
set search_path = labppto,oracle,dmap_extension,public;
alter table ppordeje alter column eje_keycia set not null;
-- dmap_object_gen_tag : type : alter table name : ppordeje
set search_path = labppto,oracle,dmap_extension,public;
alter table ppordeje alter column eje_keyver set not null;
-- dmap_object_gen_tag : type : alter table name : ppordeje
set search_path = labppto,oracle,dmap_extension,public;
alter table ppordeje alter column eje_keycon set not null;
