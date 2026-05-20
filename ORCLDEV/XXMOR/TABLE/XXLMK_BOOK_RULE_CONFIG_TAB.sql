-- dmap_object_gen_tag : type : table name : xxlmk_book_rule_config_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_book_rule_config_tab"  (
id_config numeric(38) not null,
nom_config varchar(100),
id_platform numeric(38),
id_round varchar(2),
num_perc_aleatory1 numeric(38) default 0,
num_perc_aleatory2 numeric(38) default 0
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_book_rule_config_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_book_rule_config_tab add constraint xxlmk_book_rule_config_tab_pk primary key (id_config);
-- dmap_object_gen_tag : type : alter table name : xxlmk_book_rule_config_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_book_rule_config_tab alter column id_config set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_book_rule_config_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_book_rule_config_tab add constraint xxlmk_book_rule_config_tab_xxlmk_platforms_tab_fk foreign key (id_platform) references xxlmk_platforms_tab(id_platform) on delete no action not deferrable initially immediate;
