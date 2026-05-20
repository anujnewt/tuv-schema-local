-- dmap_object_gen_tag : type : table name : hf_job_state
set search_path = feci,oracle,dmap_extension,public;/* dmap converted statement start */
create table "hf_job_state"  (
id numeric(10) not null,
job_id numeric(10),
"name" varchar(20),
reason varchar(100),
created_at timestamp,
data text
) ;/* dmap converted statement end */
-- dmap_object_gen_tag : type : alter table name : hf_job_state
set search_path = feci,oracle,dmap_extension,public;
alter table hf_job_state add primary key (id);
-- dmap_object_gen_tag : type : alter table name : hf_job_state
set search_path = feci,oracle,dmap_extension,public;
alter table hf_job_state add constraint fk_job_state_job foreign key (job_id) references hf_job(id) on delete cascade not deferrable initially immediate;
