-- dmap_object_gen_tag : type : table name : xxlmk_platforms_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_platforms_tab"  (
id_platform numeric(38) not null,
nom_platform varchar(100) not null,
nom_short varchar(10)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_platforms_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_platforms_tab add constraint xxlmk_platforms_tab_pk primary key (id_platform);
-- dmap_object_gen_tag : type : alter table name : xxlmk_platforms_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_platforms_tab alter column id_platform set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_platforms_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_platforms_tab alter column nom_platform set not null;
