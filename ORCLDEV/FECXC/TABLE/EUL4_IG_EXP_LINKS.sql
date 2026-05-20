-- dmap_object_gen_tag : type : table name : eul4_ig_exp_links
set search_path = fecxc,oracle,dmap_extension,public;
create table "eul4_ig_exp_links"  (
iel_id numeric(10) not null,
iel_type varchar(10) not null,
hil_exp_id numeric(10),
hil_hn_id numeric(10),
kil_exp_id numeric(10),
kil_key_id numeric(10),
kil_sequence numeric(22),
iel_element_state numeric(10) not null,
iel_created_by varchar(64) not null,
iel_created_date timestamp(0) not null,
iel_updated_by varchar(64),
iel_updated_date timestamp(0),
notm numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : eul4_ig_exp_links
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_ig_exp_links add constraint eul4_iel_pk primary key (iel_id);
-- dmap_object_gen_tag : type : alter table name : eul4_ig_exp_links
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_ig_exp_links add constraint eul4_iel_uk_1 unique (kil_exp_id,kil_key_id,hil_exp_id,hil_hn_id);
-- dmap_object_gen_tag : type : alter table name : eul4_ig_exp_links
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_ig_exp_links add constraint eul4_iel_check_1 check (    iel_type in ('HIL', 'KIL'));
-- dmap_object_gen_tag : type : alter table name : eul4_ig_exp_links
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_ig_exp_links alter column iel_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_ig_exp_links
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_ig_exp_links alter column iel_type set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_ig_exp_links
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_ig_exp_links alter column iel_element_state set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_ig_exp_links
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_ig_exp_links alter column iel_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_ig_exp_links
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_ig_exp_links alter column iel_created_date set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_ig_exp_links
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_ig_exp_links add constraint eul4_hil_hn_fk foreign key (hil_hn_id) references eul4_hi_nodes(hn_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_ig_exp_links
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_ig_exp_links add constraint eul4_hil_it_fk foreign key (hil_exp_id) references eul4_expressions(exp_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_ig_exp_links
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_ig_exp_links add constraint eul4_kil_it_fk foreign key (kil_exp_id) references eul4_expressions(exp_id) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : eul4_ig_exp_links
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_ig_exp_links add constraint eul4_kil_key_fk foreign key (kil_key_id) references eul4_key_cons(key_id) on delete no action not deferrable initially immediate;
