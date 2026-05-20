-- dmap_object_gen_tag : type : table name : eul4_documents
set search_path = fecxc,oracle,dmap_extension,public;
create table "eul4_documents"  (
doc_id numeric(10) not null,
doc_name varchar(100) not null,
doc_developer_key varchar(100) not null,
doc_description varchar(240),
doc_eu_id numeric(10) not null,
doc_length numeric(22) not null,
doc_batch numeric(1) not null,
doc_content_type varchar(100) not null,
doc_document bytea,
doc_user_prop2 varchar(100),
doc_user_prop1 varchar(100),
doc_element_state numeric(10) not null,
doc_created_by varchar(64) not null,
doc_created_date timestamp(0) not null,
doc_updated_by varchar(64),
doc_updated_date timestamp(0),
notm numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : eul4_documents
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_documents add constraint eul4_doc_uk_1 unique (doc_developer_key,doc_batch);
-- dmap_object_gen_tag : type : alter table name : eul4_documents
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_documents add constraint eul4_doc_uk_2 unique (doc_eu_id,doc_name,doc_batch);
-- dmap_object_gen_tag : type : alter table name : eul4_documents
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_documents add constraint eul4_doc_pk primary key (doc_id);
-- dmap_object_gen_tag : type : alter table name : eul4_documents
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_documents add constraint eul4_doc_check_1 check (    doc_batch in ( 1 , 0 ));
-- dmap_object_gen_tag : type : alter table name : eul4_documents
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_documents alter column doc_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_documents
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_documents alter column doc_name set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_documents
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_documents alter column doc_developer_key set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_documents
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_documents alter column doc_eu_id set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_documents
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_documents alter column doc_length set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_documents
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_documents alter column doc_batch set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_documents
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_documents alter column doc_content_type set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_documents
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_documents alter column doc_element_state set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_documents
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_documents alter column doc_created_by set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_documents
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_documents alter column doc_created_date set not null;
-- dmap_object_gen_tag : type : alter table name : eul4_documents
set search_path = fecxc,oracle,dmap_extension,public;
alter table eul4_documents add constraint eul4_doc_eu_fk foreign key (doc_eu_id) references eul4_eul_users(eu_id) on delete no action not deferrable initially immediate;
