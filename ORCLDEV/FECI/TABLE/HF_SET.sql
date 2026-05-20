-- dmap_object_gen_tag : type : table name : hf_set
set search_path = feci,oracle,dmap_extension,public;/* dmap converted statement start */
create table "hf_set"  (
id numeric(10) not null,
"key" varchar(255),
"value" varchar(255),
score numeric,
expire_at timestamp
) ;/* dmap converted statement end */
-- dmap_object_gen_tag : type : alter table name : hf_set
set search_path = feci,oracle,dmap_extension,public;
alter table hf_set add primary key (id);
-- dmap_object_gen_tag : type : alter table name : hf_set
set search_path = feci,oracle,dmap_extension,public;
alter table hf_set add unique ("key",value);
