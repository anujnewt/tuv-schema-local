-- dmap_object_gen_tag : type : table name : inlomoeq
set search_path = labconf,oracle,dmap_extension,public;
create table "inlomoeq"  (
moe_keyequ varchar(16),
moe_fecsol timestamp(0),
moe_keydep varchar(16),
moe_keyloc varchar(16),
moe_keycen varchar(16),
moe_obspre varchar(60),
moe_status varchar(2),
moe_fecpro timestamp(0),
moe_fecdev timestamp(0),
moe_emprec numeric(5),
moe_empres numeric(5),
moe_obsdev varchar(60)
) ;
