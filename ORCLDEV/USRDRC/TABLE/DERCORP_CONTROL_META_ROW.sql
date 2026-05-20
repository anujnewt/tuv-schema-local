-- dmap_object_gen_tag : type : table name : dercorp_control_meta_row
set search_path = usrdrc,oracle,dmap_extension,public;
create table "dercorp_control_meta_row"  (
id_user numeric(38) default 0,
id_empresa numeric(38) default 0,
id_meta_row numeric(38) default 0
) ;
