-- dmap_object_gen_tag : type : table name : nmproche
set search_path = labprod,oracle,dmap_extension,public;
create table "nmproche"  (
che_keypro numeric(5) not null,
che_keyper varchar(7) not null,
che_keyemp numeric(10) not null,
che_perpro varchar(7),
che_fecins timestamp(0),
che_keyusu numeric(10),
che_perpag varchar(7),
che_status varchar(1),
id numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : nmproche
set search_path = labprod,oracle,dmap_extension,public;
alter table nmproche add constraint nmproche_pk primary key (che_keypro,che_keyper,che_keyemp);
