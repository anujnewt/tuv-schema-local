-- dmap_object_gen_tag : type : table name : tvpervac
set search_path = labconf,oracle,dmap_extension,public;
create table "tvpervac"  (
pva_keyemp numeric(38) not null,
pva_fecini timestamp(0),
pva_fecfin timestamp(0),
pva_dia decimal(3,2)
) ;
-- dmap_object_gen_tag : type : alter table name : tvpervac
set search_path = labconf,oracle,dmap_extension,public;
alter table tvpervac alter column pva_keyemp set not null;
