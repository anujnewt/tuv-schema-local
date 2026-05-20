-- dmap_object_gen_tag : type : table name : hf_distributed_lock
set search_path = feci,oracle,dmap_extension,public;
create table "hf_distributed_lock"  (
resource varchar(100),
created_at timestamp
) ;
