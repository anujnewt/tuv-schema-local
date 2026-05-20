-- dmap_object_gen_tag : type : table name : app_temp_log
set search_path = usrdrc,oracle,dmap_extension,public;
create table "app_temp_log"  (
log_id numeric,
text varchar(500),
id_row numeric,
id_parent numeric
) ;
