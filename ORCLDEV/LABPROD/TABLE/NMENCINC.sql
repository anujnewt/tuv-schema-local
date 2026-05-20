-- dmap_object_gen_tag : type : table name : nmencinc
set search_path = labprod,oracle,dmap_extension,public;
create table "nmencinc"  (
inc_keyusu numeric(38),
inc_keyemp numeric(38),
inc_keysem numeric(38),
inc_keyjor numeric(38),
inc_keycco varchar(16),
inc_feccap timestamp(0),
inc_ddesc1 varchar(2),
inc_ddesc2 varchar(2),
inc_keypro numeric(38),
inc_keyper varchar(7)
) ;
