-- dmap_object_gen_tag : type : table name : hf_server
set search_path = feci,oracle,dmap_extension,public;
create table "hf_server"  (
id varchar(100) not null,
data text,
last_heart_beat timestamp
) ;
-- dmap_object_gen_tag : type : alter table name : hf_server
set search_path = feci,oracle,dmap_extension,public;
alter table hf_server add primary key (id);
