-- dmap_object_gen_tag : type : table name : xxmor_cat_agrupador_mult_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxmor_cat_agrupador_mult_tab"  (
agrupador_multiple varchar(15) not null,
prefijo_canal varchar(5) not null,
pivote char(1),
rtcrd_substr varchar(15),
ca_rtcrd_substr varchar(15),
ca_rtcrd_aux varchar(15)
) ;
-- dmap_object_gen_tag : type : alter table name : xxmor_cat_agrupador_mult_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_cat_agrupador_mult_tab add constraint xxmor_cat_agrupador_mult_pk primary key (agrupador_multiple,prefijo_canal);
-- dmap_object_gen_tag : type : alter table name : xxmor_cat_agrupador_mult_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_cat_agrupador_mult_tab alter column agrupador_multiple set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_cat_agrupador_mult_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_cat_agrupador_mult_tab alter column prefijo_canal set not null;
