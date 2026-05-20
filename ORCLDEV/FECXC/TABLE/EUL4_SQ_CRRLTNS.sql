-- dmap_object_gen_tag : type : table name : eul4_sq_crrltns
set search_path = fecxc,oracle,dmap_extension,public;
create table "eul4_sq_crrltns"  (
sqc_id numeric(10) not null,
sqc_sq_id numeric(10) not null,
sqc_it_inner_id numeric(10) not null,
sqc_it_outer_id numeric(10) not null,
sqc_element_state numeric(10) not null,
sqc_created_by varchar(64) not null,
sqc_created_date timestamp(0) not null,
sqc_updated_by varchar(64),
sqc_updated_date timestamp(0),
notm numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : eul4_sq_crrltns
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sq_crrltns add constraint eul4_sqc_uk_1 unique (sqc_sq_id,sqc_it_inner_id,sqc_it_outer_id);
-- dmap_object_gen_tag : type : alter table name : eul4_sq_crrltns
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sq_crrltns add constraint eul4_sqc_pk primary key (sqc_id);
-- dmap_object_gen_tag : type : alter table name : eul4_sq_crrltns
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sq_crrltns alter column sqc_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_sq_crrltns
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sq_crrltns alter column sqc_sq_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_sq_crrltns
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sq_crrltns alter column sqc_it_inner_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_sq_crrltns
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sq_crrltns alter column sqc_it_outer_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_sq_crrltns
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sq_crrltns alter column sqc_element_state set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_sq_crrltns
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sq_crrltns alter column sqc_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_sq_crrltns
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sq_crrltns alter column sqc_created_date set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_sq_crrltns
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sq_crrltns add constraint eul4_sqc_it_i_fk foreign key (sqc_it_inner_id) references eul4_expressions(exp_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_sq_crrltns
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sq_crrltns add constraint eul4_sqc_it_o_fk foreign key (sqc_it_outer_id) references eul4_expressions(exp_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_sq_crrltns
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_sq_crrltns add constraint eul4_sqc_sq_fk foreign key (sqc_sq_id) references eul4_sub_queries(sq_id) on delete no action not deferrable initially immediate;
