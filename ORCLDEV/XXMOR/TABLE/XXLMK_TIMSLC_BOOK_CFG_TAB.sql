-- dmap_object_gen_tag : type : table name : xxlmk_timslc_book_cfg_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_timslc_book_cfg_tab"  (
id_config numeric(38) not null,
id_franja varchar(5) not null,
ind_selected numeric(38),
num_start_time varchar(4),
num_end_time varchar(4)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_timslc_book_cfg_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_timslc_book_cfg_tab add constraint xxlmk_timslc_book_cfg_tab_pk primary key (id_config,id_franja);
-- dmap_object_gen_tag : type : alter table name : xxlmk_timslc_book_cfg_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_timslc_book_cfg_tab alter column id_config set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_timslc_book_cfg_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_timslc_book_cfg_tab alter column id_franja set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_timslc_book_cfg_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_timslc_book_cfg_tab add constraint xxlmk_timslc_book_cfg_tab_xxlmk_book_rule_config_tab_fk foreign key (id_config) references xxlmk_book_rule_config_tab(id_config) on delete no action not deferrable initially immediate;
