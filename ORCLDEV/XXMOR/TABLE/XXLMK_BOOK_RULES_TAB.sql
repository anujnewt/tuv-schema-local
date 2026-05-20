-- dmap_object_gen_tag : type : table name : xxlmk_book_rules_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_book_rules_tab"  (
id_rule numeric(38) not null,
nom_rule varchar(200)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_book_rules_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_book_rules_tab add constraint xxlmk_book_rules_tab_pk primary key (id_rule);
-- dmap_object_gen_tag : type : alter table name : xxlmk_book_rules_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_book_rules_tab alter column id_rule set not null;
