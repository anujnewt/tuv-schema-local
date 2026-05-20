-- dmap_object_gen_tag : type : table name : hf_job_parameter
set search_path = feci,oracle,dmap_extension,public;/* dmap converted statement start */
create table "hf_job_parameter"  (
id numeric(10) not null,
"name" varchar(40),
"value" text,
job_id numeric(10)
) ;/* dmap converted statement end */
-- dmap_object_gen_tag : type : alter table name : hf_job_parameter
set search_path = feci,oracle,dmap_extension,public;
alter table hf_job_parameter add primary key (id);
-- dmap_object_gen_tag : type : alter table name : hf_job_parameter
set search_path = feci,oracle,dmap_extension,public;
alter table hf_job_parameter add constraint fk_job_parameter_job foreign key (job_id) references hf_job(id) on delete cascade not deferrable initially immediate;
