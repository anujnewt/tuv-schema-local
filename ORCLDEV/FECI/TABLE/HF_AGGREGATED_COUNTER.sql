-- dmap_object_gen_tag : type : table name : hf_aggregated_counter
set search_path = feci,oracle,dmap_extension,public;/* dmap converted statement start */
create table "hf_aggregated_counter"  (
id numeric(10) not null,
"key" varchar(255),
"value" numeric(10),
expire_at timestamp
) ;/* dmap converted statement end */
-- dmap_object_gen_tag : type : alter table name : hf_aggregated_counter
set search_path = feci,oracle,dmap_extension,public;
alter table hf_aggregated_counter add unique ("key");
-- dmap_object_gen_tag : type : alter table name : hf_aggregated_counter
set search_path = feci,oracle,dmap_extension,public;
alter table hf_aggregated_counter add primary key (id);
