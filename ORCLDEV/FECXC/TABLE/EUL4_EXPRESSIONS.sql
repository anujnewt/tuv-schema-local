-- dmap_object_gen_tag : type : table name : eul4_expressions
set search_path = fecxc,oracle,dmap_extension,public;
create table "eul4_expressions"  (
exp_id numeric(10) not null,
exp_type varchar(10) not null,
exp_name varchar(100) not null,
exp_developer_key varchar(100) not null,
exp_description varchar(240),
exp_formula1 varchar(250),
exp_data_type numeric(2) not null,
exp_sequence numeric(22),
it_dom_id numeric(10),
it_obj_id numeric(10),
it_doc_id numeric(10),
it_format_mask varchar(100),
it_max_data_width numeric,
it_max_disp_width numeric,
it_alignment numeric(2),
it_word_wrap numeric(1),
it_disp_null_val varchar(100),
it_fun_id numeric(10),
it_heading varchar(240),
it_hidden numeric(1),
it_placement numeric(2),
it_user_def_fmt varchar(100),
it_case_storage numeric(2),
it_case_display numeric(2),
it_ext_column varchar(64),
ci_it_id numeric(10),
ci_runtime_item numeric(1),
par_multiple_vals numeric(1),
co_nullable numeric(1),
p_case_sensitive numeric(1),
jp_key_id numeric(10),
fil_obj_id numeric(10),
fil_doc_id numeric(10),
fil_runtime_filter numeric(1),
fil_app_type numeric(2),
fil_ext_filter varchar(64),
exp_user_prop2 varchar(100),
exp_user_prop1 varchar(100),
exp_element_state numeric(10) not null,
exp_created_by varchar(64) not null,
exp_created_date timestamp(0) not null,
exp_updated_by varchar(64),
exp_updated_date timestamp(0),
notm numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : eul4_expressions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_expressions add constraint eul4_exp_uk_1 unique (it_obj_id,fil_obj_id,jp_key_id,exp_developer_key,it_doc_id,fil_doc_id);
-- dmap_object_gen_tag : type : alter table name : eul4_expressions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_expressions add constraint eul4_exp_uk_2 unique (it_obj_id,fil_obj_id,jp_key_id,exp_name,it_doc_id,fil_doc_id);
-- dmap_object_gen_tag : type : alter table name : eul4_expressions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_expressions add constraint eul4_exp_pk primary key (exp_id);
-- dmap_object_gen_tag : type : alter table name : eul4_expressions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_expressions add constraint eul4_exp_check_1 check (    exp_type in ( 'CI' , 'CO' , 'JP' , 'FIL' , 'PAR' ));
-- dmap_object_gen_tag : type : alter table name : eul4_expressions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_expressions add constraint eul4_exp_check_10 check (    it_case_display in ( 1 , 2 , 3 , 4 ));
-- dmap_object_gen_tag : type : alter table name : eul4_expressions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_expressions add constraint eul4_exp_check_11 check (    co_nullable in ( 1 , 0 ));
-- dmap_object_gen_tag : type : alter table name : eul4_expressions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_expressions add constraint eul4_exp_check_12 check (    p_case_sensitive in ( 1 , 0 ));
-- dmap_object_gen_tag : type : alter table name : eul4_expressions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_expressions add constraint eul4_exp_check_13 check (    fil_runtime_filter in ( 1 , 0 ));
-- dmap_object_gen_tag : type : alter table name : eul4_expressions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_expressions add constraint eul4_exp_check_14 check (    ci_runtime_item in (1,0));
-- dmap_object_gen_tag : type : alter table name : eul4_expressions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_expressions add constraint eul4_exp_check_15 check (    fil_app_type in (0,1,2));
-- dmap_object_gen_tag : type : alter table name : eul4_expressions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_expressions add constraint eul4_exp_check_2 check (    exp_data_type in (0,1,2,3,4,5,6,7,8,9,10,11,12,13));
-- dmap_object_gen_tag : type : alter table name : eul4_expressions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_expressions add constraint eul4_exp_check_3 check (    it_alignment in ( 1 , 2 , 3 , 4 ));
-- dmap_object_gen_tag : type : alter table name : eul4_expressions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_expressions add constraint eul4_exp_check_4 check (    it_word_wrap in ( 1 , 0 ));
-- dmap_object_gen_tag : type : alter table name : eul4_expressions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_expressions add constraint eul4_exp_check_5 check (    par_multiple_vals in ( 1 , 0 ));
-- dmap_object_gen_tag : type : alter table name : eul4_expressions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_expressions add constraint eul4_exp_check_6 check (    it_hidden in ( 1 , 0 ));
-- dmap_object_gen_tag : type : alter table name : eul4_expressions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_expressions add constraint eul4_exp_check_8 check (    it_placement in ( 0 , 1 , 2 , 3 , 4 , 5 ));
-- dmap_object_gen_tag : type : alter table name : eul4_expressions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_expressions add constraint eul4_exp_check_9 check (    it_case_storage in ( 0 , 1 , 2 , 3 ));
-- dmap_object_gen_tag : type : alter table name : eul4_expressions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_expressions alter column exp_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_expressions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_expressions alter column exp_type set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_expressions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_expressions alter column exp_name set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_expressions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_expressions alter column exp_developer_key set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_expressions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_expressions alter column exp_data_type set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_expressions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_expressions alter column exp_element_state set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_expressions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_expressions alter column exp_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_expressions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_expressions alter column exp_created_date set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_expressions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_expressions add constraint eul4_ci_it_fk foreign key (ci_it_id) references eul4_expressions(exp_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_expressions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_expressions add constraint eul4_fil_doc_fk foreign key (fil_doc_id) references eul4_documents(doc_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_expressions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_expressions add constraint eul4_fil_obj_fk foreign key (fil_obj_id) references eul4_objs(obj_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_expressions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_expressions add constraint eul4_it_doc_fk foreign key (it_doc_id) references eul4_documents(doc_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_expressions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_expressions add constraint eul4_it_dom_fk foreign key (it_dom_id) references eul4_domains(dom_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_expressions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_expressions add constraint eul4_it_fun_fk foreign key (it_fun_id) references eul4_functions(fun_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_expressions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_expressions add constraint eul4_it_obj_fk foreign key (it_obj_id) references eul4_objs(obj_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_expressions
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_expressions add constraint eul4_jp_fk_fk foreign key (jp_key_id) references eul4_key_cons(key_id) on delete no action not deferrable initially immediate;
