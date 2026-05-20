-- dmap_object_gen_tag : type : table name : hf_job_queue
set search_path = feci,oracle,dmap_extension,public;
create table "hf_job_queue"  (
id numeric(10) not null,
job_id numeric(10),
queue varchar(50),
fetched_at timestamp,
fetch_token varchar(36)
) ;
-- dmap_object_gen_tag : type : alter table name : hf_job_queue
set search_path = feci,oracle,dmap_extension,public;
alter table hf_job_queue add primary key (id);
-- dmap_object_gen_tag : type : alter table name : hf_job_queue
set search_path = feci,oracle,dmap_extension,public;
alter table hf_job_queue add constraint fk_job_queue_job foreign key (job_id) references hf_job(id) on delete cascade not deferrable initially immediate;
