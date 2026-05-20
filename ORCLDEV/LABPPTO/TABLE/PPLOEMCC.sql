-- dmap_object_gen_tag : type : table name : pploemcc
set search_path = labppto,oracle,dmap_extension,public;
create table "pploemcc"  (
emc_keycia varchar(2) not null,
emc_keyemp numeric(38) not null,
emc_keyame numeric(38),
emc_cen varchar(16)
) ;
-- dmap_object_gen_tag : type : alter table name : pploemcc
set search_path = labppto,oracle,dmap_extension,public;
alter table pploemcc alter column emc_keycia set not null;
-- dmap_object_gen_tag : type : alter table name : pploemcc
set search_path = labppto,oracle,dmap_extension,public;
alter table pploemcc alter column emc_keyemp set not null;
