-- dmap_object_gen_tag : type : table name : nmlofone
set search_path = labprod,oracle,dmap_extension,public;
create table "nmlofone"  (
fon_keyfon numeric(10) not null,
fon_keypro numeric(3) not null,
fon_feccar timestamp(0) not null,
fon_horcar varchar(8) not null,
fon_nomarc varchar(200) not null,
fon_keyusu numeric(5) not null,
fon_numani numeric(4) not null,
fon_nummes numeric(2) not null,
fon_actual numeric(1) not null
) ;
-- dmap_object_gen_tag : type : alter table name : nmlofone
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlofone alter column fon_keyfon set not null;
-- dmap_object_gen_tag : type : alter table name : nmlofone
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlofone alter column fon_keypro set not null;
-- dmap_object_gen_tag : type : alter table name : nmlofone
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlofone alter column fon_feccar set not null;
-- dmap_object_gen_tag : type : alter table name : nmlofone
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlofone alter column fon_horcar set not null;
-- dmap_object_gen_tag : type : alter table name : nmlofone
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlofone alter column fon_nomarc set not null;
-- dmap_object_gen_tag : type : alter table name : nmlofone
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlofone alter column fon_keyusu set not null;
-- dmap_object_gen_tag : type : alter table name : nmlofone
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlofone alter column fon_numani set not null;
-- dmap_object_gen_tag : type : alter table name : nmlofone
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlofone alter column fon_nummes set not null;
-- dmap_object_gen_tag : type : alter table name : nmlofone
set search_path = labprod,oracle,dmap_extension,public;
alter table nmlofone alter column fon_actual set not null;
