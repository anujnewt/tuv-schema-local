-- dmap_object_gen_tag : type : table name : tvgascar
set search_path = labprod,oracle,dmap_extension,public;
create table "tvgascar"  (
car_keycar numeric(38) not null,
car_keyusu numeric(38) not null,
car_feccar timestamp(0),
car_horcar varchar(8),
car_nomarc varchar(60),
car_anio numeric(38),
car_nummes numeric(38),
car_status numeric(38),
car_totfil numeric,
car_totimp decimal(14, 2)
) ;
-- dmap_object_gen_tag : type : alter table name : tvgascar
set search_path = labprod,oracle,dmap_extension,public;
alter table tvgascar add constraint tvgascar_pk primary key (car_keycar);
-- dmap_object_gen_tag : type : alter table name : tvgascar
set search_path = labprod,oracle,dmap_extension,public;
alter table tvgascar alter column car_keycar set not null;
-- dmap_object_gen_tag : type : alter table name : tvgascar
set search_path = labprod,oracle,dmap_extension,public;
alter table tvgascar alter column car_keyusu set not null;
