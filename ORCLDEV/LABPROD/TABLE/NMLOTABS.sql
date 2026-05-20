-- dmap_object_gen_tag : type : table name : nmlotabs
set search_path = labprod,oracle,dmap_extension,public;
create table "nmlotabs"  (
tab_keysue varchar(4),
tab_cobert varchar(2),
tab_tiptab varchar(2),
tab_sueniv numeric(10),
tab_subniv numeric(10),
tab_feccad timestamp(0),
tab_suemin decimal(12, 2),
tab_sue1qa decimal(12, 2),
tab_suemed decimal(12, 2),
tab_sue3qa decimal(12, 2),
tab_suemax decimal(12, 2)
) ;
