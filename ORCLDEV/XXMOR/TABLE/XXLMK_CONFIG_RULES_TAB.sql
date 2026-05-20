-- dmap_object_gen_tag : type : table name : xxlmk_config_rules_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_config_rules_tab"  (
id_config numeric(38) not null,
id_rule numeric(38) not null,
num_orden numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_config_rules_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_config_rules_tab add constraint xxlmk_config_rules_tab_pk primary key (id_config,id_rule);
-- dmap_object_gen_tag : type : alter table name : xxlmk_config_rules_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_config_rules_tab alter column id_config set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_config_rules_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_config_rules_tab alter column id_rule set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_config_rules_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_config_rules_tab add constraint xxlmk_config_rules_tab_xxlmk_book_rules_tab_fk foreign key (id_rule) references xxlmk_book_rules_tab(id_rule) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : xxlmk_config_rules_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_config_rules_tab add constraint xxlmk_config_rules_tab_xxlmk_book_rule_config_tab_fk foreign key (id_config) references xxlmk_book_rule_config_tab(id_config) on delete no action not deferrable initially immediate;
