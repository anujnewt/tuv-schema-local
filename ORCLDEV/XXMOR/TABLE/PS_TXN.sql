-- dmap_object_gen_tag : type : table name : ps_txn
set search_path = xxmor,oracle,dmap_extension,public;
create table "ps_txn"  (
id numeric(20) not null,
parentid numeric(20),
collid numeric(10) not null,
content bytea,
creation_date timestamp(0) default statement_timestamp()
) ;
-- dmap_object_gen_tag : type : alter table name : ps_txn
set search_path = xxmor,oracle,dmap_extension,public;
alter table ps_txn add constraint ps_txn_pk primary key (collid,id);
