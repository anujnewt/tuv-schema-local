-- dmap_object_gen_tag : type : table name : hf_hash
set search_path = feci,oracle,dmap_extension,public;/* dmap converted statement start */
create table "hf_hash"  (
id numeric(10) not null,
"key" varchar(255),
"value" text,
expire_at timestamp,
field varchar(40)
) ;/* dmap converted statement end */
-- dmap_object_gen_tag : type : alter table name : hf_hash
set search_path = feci,oracle,dmap_extension,public;
alter table hf_hash add unique ("key",field);
-- dmap_object_gen_tag : type : alter table name : hf_hash
set search_path = feci,oracle,dmap_extension,public;
alter table hf_hash add primary key (id);
