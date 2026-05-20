-- dmap_object_gen_tag : type : table name : eocoencp
set search_path = labprod,oracle,dmap_extension,public;
create table "eocoencp"  (
ecp_keydep varchar(16),
ecp_keypue varchar(16),
ecp_keycon varchar(3),
ecp_autori decimal(14, 2),
ecp_modifi decimal(14, 2),
ecp_compro decimal(14, 2),
ecp_reserv decimal(14, 2),
ecp_ejerci decimal(14, 2),
ecp_dispon decimal(14, 2),
ecp_fecini timestamp(0),
ecp_fecfin timestamp(0)
) ;
