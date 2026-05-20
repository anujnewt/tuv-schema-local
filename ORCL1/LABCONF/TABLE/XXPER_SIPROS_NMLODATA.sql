-- dmap_object_gen_tag : type : table name : xxper_sipros_nmlodata
set search_path = labconf,oracle,dmap_extension,public;
create table "xxper_sipros_nmlodata"  (
dat_keyemp varchar(150) not null,
dat_keypar varchar(2) not null,
dat_valpar varchar(100),
ora_system varchar(30),
ora_transaction varchar(30),
ora_date timestamp(0),
ora_secuencia numeric,
ora_status varchar(2)
) ;
-- dmap_object_gen_tag : type : alter table name : xxper_sipros_nmlodata
set search_path = labconf,oracle,dmap_extension,public;
alter table xxper_sipros_nmlodata alter column dat_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : xxper_sipros_nmlodata
set search_path = labconf,oracle,dmap_extension,public;
alter table xxper_sipros_nmlodata alter column dat_keypar set not null;
