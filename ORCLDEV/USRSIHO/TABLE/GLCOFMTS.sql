-- dmap_object_gen_tag : type : table name : glcofmts
set search_path = usrsiho,oracle,dmap_extension,public;
create table "glcofmts"  (
fmt_keyfmt varchar(10),
fmt_des001 varchar(40),
fmt_des002 varchar(40),
fmt_des003 varchar(40),
fmt_keytab varchar(18),
fmt_key001 varchar(18),
fmt_key002 varchar(18),
ftm_despl1 varchar(18),
fmt_despl2 varchar(18),
fmt_cam001 varchar(18),
fmt_val001 varchar(16),
fmt_cam002 varchar(18),
fmt_val002 varchar(16),
fmt_keycia varchar(2),
fmt_fecact timestamp(0),
fmt_keyusu numeric(10),
fmt_horact varchar(8),
fmt_idepcc varchar(15)
) ;
