-- dmap_object_gen_tag : type : table name : hf_list
set search_path = feci,oracle,dmap_extension,public;/* dmap converted statement start */
create table "hf_list"  (
id numeric(10) not null,
"key" varchar(255),
"value" text,
expire_at timestamp
) ;/* dmap converted statement end */
-- dmap_object_gen_tag : type : alter table name : hf_list
set search_path = feci,oracle,dmap_extension,public;
alter table hf_list add primary key (id);
