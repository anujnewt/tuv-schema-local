-- dmap_object_gen_tag : type : table name : eul4_sum_bitmaps
set search_path = fecxc,oracle,dmap_extension,public;
create table "eul4_sum_bitmaps"  (
sb_id numeric(10) not null,
sb_bitmap bytea not null,
sb_sequence numeric(22) not null,
sb_exp_id numeric(10),
sb_key_id numeric(10),
sb_fun_id numeric(10),
sb_element_state numeric(10) not null,
sb_created_by varchar(64) not null,
sb_created_date timestamp(0) not null,
sb_updated_date timestamp(0),
sb_updated_by varchar(64),
notm numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : eul4_sum_bitmaps
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sum_bitmaps add constraint eul4_sb_uk_1 unique (sb_exp_id,sb_key_id,sb_fun_id,sb_sequence);
-- dmap_object_gen_tag : type : alter table name : eul4_sum_bitmaps
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sum_bitmaps add constraint eul4_sb_pk primary key (sb_id);
-- dmap_object_gen_tag : type : alter table name : eul4_sum_bitmaps
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sum_bitmaps add constraint eul4_sb_check_1 check (    (sb_key_id is not null and sb_fun_id is null and sb_exp_id is null) or (sb_key_id is null and sb_fun_id is not null and sb_exp_id is null) or (sb_key_id is null and sb_fun_id is not null and sb_exp_id is not    null) or (sb_key_id is null and sb_fun_id is null and sb_exp_id is not null));
-- dmap_object_gen_tag : type : alter table name : eul4_sum_bitmaps
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sum_bitmaps alter column sb_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_sum_bitmaps
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sum_bitmaps alter column sb_bitmap set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_sum_bitmaps
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sum_bitmaps alter column sb_sequence set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_sum_bitmaps
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sum_bitmaps alter column sb_element_state set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_sum_bitmaps
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sum_bitmaps alter column sb_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_sum_bitmaps
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sum_bitmaps alter column sb_created_date set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_sum_bitmaps
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sum_bitmaps add constraint eul4_sb_fk_fk foreign key (sb_key_id) references eul4_key_cons(key_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_sum_bitmaps
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sum_bitmaps add constraint eul4_sb_fun_fk foreign key (sb_fun_id) references eul4_functions(fun_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_sum_bitmaps
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sum_bitmaps add constraint eul4_sb_it_fk foreign key (sb_exp_id) references eul4_expressions(exp_id) on delete no action not deferrable initially immediate;
