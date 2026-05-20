-- dmap_object_gen_tag : type : table name : xxlmk_rtc_spttype_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_rtc_spttype_tab"  (
id_rtc numeric(38) not null,
nom_rtc varchar(100) not null,
des_spttype varchar(10) not null
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_rtc_spttype_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_rtc_spttype_tab add primary key (id_rtc);
-- dmap_object_gen_tag : type : alter table name : xxlmk_rtc_spttype_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_rtc_spttype_tab alter column id_rtc set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_rtc_spttype_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_rtc_spttype_tab alter column nom_rtc set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_rtc_spttype_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_rtc_spttype_tab alter column des_spttype set not null;
