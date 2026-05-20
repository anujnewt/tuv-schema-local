-- dmap_object_gen_tag : type : table name : tvgasdet
set search_path = labprod,oracle,dmap_extension,public;
create table "tvgasdet"  (
det_keydet numeric(38) not null,
det_keycar numeric(38) not null,
det_nummes numeric(38),
det_keycia varchar(3),
det_tipmov varchar(20),
det_tipo varchar(20),
del_tipcta varchar(20),
det_cia varchar(3),
det_neg varchar(2),
det_cta varchar(3),
det_scta varchar(6),
det_cc varchar(8),
det_icia varchar(3),
det_top varchar(1),
det_impcar decimal(16, 2),
det_impabo decimal(16, 2),
det_total decimal(16, 2),
det_keypol varchar(10),
det_cia2 varchar(3),
det_neg2 varchar(2),
det_keycon varchar(20),
det_despol varchar(100)
) ;
-- dmap_object_gen_tag : type : alter table name : tvgasdet
set search_path = labprod,oracle,dmap_extension,public;
alter table tvgasdet add constraint tvgasdet_pk primary key (det_keydet);
-- dmap_object_gen_tag : type : alter table name : tvgasdet
set search_path = labprod,oracle,dmap_extension,public;
alter table tvgasdet alter column det_keydet set not null;
-- dmap_object_gen_tag : type : alter table name : tvgasdet
set search_path = labprod,oracle,dmap_extension,public;
alter table tvgasdet alter column det_keycar set not null;
-- dmap_object_gen_tag : type : alter table name : tvgasdet
set search_path = labprod,oracle,dmap_extension,public;
alter table tvgasdet add constraint tvgasdet_foreing_key foreign key (det_keycar) references tvgascar(car_keycar) on delete no action not deferrable initially immediate;
