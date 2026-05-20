-- dmap_object_gen_tag : type : table name : xxfnc_debug_tbl_tmp
set search_path = fecxc,oracle,dmap_extension,public;
create table "xxfnc_debug_tbl_tmp"  (
consecutivo numeric,
fecha_registro timestamp(0),
l_place varchar(100),
l_calling_module varchar(100),
l_msg varchar(500)
) ;
