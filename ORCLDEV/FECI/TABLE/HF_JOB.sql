-- dmap_object_gen_tag : type : table name : hf_job
set search_path = feci,oracle,dmap_extension,public;
create table "hf_job"  (
id numeric(10) not null,
state_id numeric(10),
state_name varchar(20),
invocation_data text,
arguments text,
created_at timestamp,
expire_at timestamp
) ;
-- dmap_object_gen_tag : type : alter table name : hf_job
set search_path = feci,oracle,dmap_extension,public;
alter table hf_job add primary key (id);
