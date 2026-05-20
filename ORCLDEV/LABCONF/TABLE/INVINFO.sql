-- dmap_object_gen_tag : type : table name : invinfo
set search_path = labconf,oracle,dmap_extension,public;
create table "invinfo"  (
fund_id numeric,
inv varchar(40),
info varchar(500)
) ;
