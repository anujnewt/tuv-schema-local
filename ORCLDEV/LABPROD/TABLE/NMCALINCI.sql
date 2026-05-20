-- dmap_object_gen_tag : type : table name : nmcalinci
set search_path = labprod,oracle,dmap_extension,public;
create table "nmcalinci"  (
inc_keyper varchar(7),
inc_feclun timestamp(0),
inc_fecmar timestamp(0),
inc_fecmie timestamp(0),
inc_fecjue timestamp(0),
inc_fecvie timestamp(0),
inc_fecsab timestamp(0),
inc_fecdom timestamp(0)
) ;
-- dmap_object_gen_tag : type : alter table name : nmcalinci
set search_path = labprod,oracle,dmap_extension,public;
alter table nmcalinci add constraint nmcalinci01 unique (inc_keyper);
