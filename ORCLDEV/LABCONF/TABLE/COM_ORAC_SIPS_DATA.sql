-- dmap_object_gen_tag : type : table name : com_orac_sips_data
set search_path = labconf,oracle,dmap_extension,public;
create table "com_orac_sips_data"  (
ora_noctvo numeric(38) not null,
dat_keyemp numeric(38),
dat_keypar varchar(2),
dat_valpar varchar(30),
ora_status varchar(2)
) ;
-- dmap_object_gen_tag : type : alter table name : com_orac_sips_data
set search_path = labconf,oracle,dmap_extension,public;
alter table com_orac_sips_data alter column ora_noctvo set not null;
