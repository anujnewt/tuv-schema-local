-- dmap_object_gen_tag : type : table name : eul4_exp_deps
set search_path = fecxc,oracle,dmap_extension,public;
create table "eul4_exp_deps"  (
ed_id numeric(10) not null,
ed_type varchar(10) not null,
pd_p_id numeric(10),
ped_exp_id numeric(10),
pfd_fun_id numeric(10),
psd_sq_id numeric(10),
cd_exp_id numeric(10),
cfd_fun_id numeric(10),
cid_exp_id numeric(10),
ed_element_state numeric(10) not null,
ed_created_by varchar(64) not null,
ed_created_date timestamp(0) not null,
ed_updated_by varchar(64),
ed_updated_date timestamp(0),
notm numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : eul4_exp_deps
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_exp_deps add constraint eul4_ed_uk_1 unique (psd_sq_id,pfd_fun_id,cd_exp_id,ped_exp_id,pd_p_id,cfd_fun_id,cid_exp_id);
-- dmap_object_gen_tag : type : alter table name : eul4_exp_deps
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_exp_deps add constraint eul4_ed_pk primary key (ed_id);
-- dmap_object_gen_tag : type : alter table name : eul4_exp_deps
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_exp_deps add constraint eul4_ed_check_1 check (    ed_type in ( 'PSD' , 'PFD' , 'CFD' , 'CID' , 'PED' ));
-- dmap_object_gen_tag : type : alter table name : eul4_exp_deps
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_exp_deps alter column ed_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_exp_deps
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_exp_deps alter column ed_type set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_exp_deps
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_exp_deps alter column ed_element_state set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_exp_deps
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_exp_deps alter column ed_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_exp_deps
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_exp_deps alter column ed_created_date set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_exp_deps
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_exp_deps add constraint eul4_cd_ci_fk foreign key (cd_exp_id) references eul4_expressions(exp_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_exp_deps
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_exp_deps add constraint eul4_cfd_fun_fk foreign key (cfd_fun_id) references eul4_functions(fun_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_exp_deps
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_exp_deps add constraint eul4_cid_it_fk foreign key (cid_exp_id) references eul4_expressions(exp_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_exp_deps
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_exp_deps add constraint eul4_pd_p_fk foreign key (pd_p_id) references eul4_expressions(exp_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_exp_deps
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_exp_deps add constraint eul4_ped_exp_fk foreign key (ped_exp_id) references eul4_expressions(exp_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_exp_deps
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_exp_deps add constraint eul4_pfd_fun_fk foreign key (pfd_fun_id) references eul4_functions(fun_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_exp_deps
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_exp_deps add constraint eul4_psd_sq_fk foreign key (psd_sq_id) references eul4_sub_queries(sq_id) on delete no action not deferrable initially immediate;
