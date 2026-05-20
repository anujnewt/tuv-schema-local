-- dmap_object_gen_tag : type : table name : eocodecp
set search_path = labprod,oracle,dmap_extension,public;
create table "eocodecp"  (
dcp_keydep varchar(16),
dcp_keypue varchar(16),
dcp_keycon varchar(3),
dcp_keyper varchar(7),
dcp_import decimal(14, 2),
dcp_tippst varchar(1),
dcp_fecmov timestamp(0)
) ;
