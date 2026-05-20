-- dmap_object_gen_tag : type : table name : pplovac
set search_path = labppto,oracle,dmap_extension,public;
create table "pplovac"  (
vac_keycia varchar(4) not null,
vac_aantig numeric(38) not null,
vac_dias numeric(38) not null,
vac_keypro numeric(38),
vac_tipemp varchar(6)
) ;
-- dmap_object_gen_tag : type : alter table name : pplovac
set search_path = labppto,oracle,dmap_extension,public;
alter table pplovac alter column vac_keycia set not null;
-- dmap_object_gen_tag : type : alter table name : pplovac
set search_path = labppto,oracle,dmap_extension,public;
alter table pplovac alter column vac_aantig set not null;
-- dmap_object_gen_tag : type : alter table name : pplovac
set search_path = labppto,oracle,dmap_extension,public;
alter table pplovac alter column vac_dias set not null;
