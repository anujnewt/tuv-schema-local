-- dmap_object_gen_tag : type : table name : xxmor_sistemas_finales_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxmor_sistemas_finales_tab"  (
id_sist numeric(3) not null,
desc_sist char(10) not null,
url_ws char(10) not null
) ;
-- dmap_object_gen_tag : type : alter table name : xxmor_sistemas_finales_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_sistemas_finales_tab add constraint xxmor_sistemas_finales_tab_pk primary key (id_sist);
-- dmap_object_gen_tag : type : alter table name : xxmor_sistemas_finales_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_sistemas_finales_tab alter column id_sist set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_sistemas_finales_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_sistemas_finales_tab alter column desc_sist set not null;
-- dmap_object_gen_tag : type : alter table name : xxmor_sistemas_finales_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxmor_sistemas_finales_tab alter column url_ws set not null;
