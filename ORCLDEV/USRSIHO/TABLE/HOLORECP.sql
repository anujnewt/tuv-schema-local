-- dmap_object_gen_tag : type : table name : holorecp
set search_path = usrsiho,oracle,dmap_extension,public;
create table "holorecp"  (
rec_numsec numeric(10),
rec_keypro numeric(5),
rec_keyper varchar(7),
rec_keyemp numeric(10),
rec_import decimal(16, 2),
rec_descia varchar(60),
rec_implet varchar(100),
rec_nomemp varchar(100),
rec_porcen decimal(16, 2),
rec_oficio varchar(20),
rec_fecofc timestamp(0),
rec_autori varchar(80),
rec_numex varchar(10),
rec_banco varchar(20),
rec_cuenta varchar(20),
rec_nomben varchar(60),
rec_fecpag timestamp(0),
rec_keyare varchar(4),
rec_emision varchar(5),
rec_keyben numeric(5),
rec_ejerci numeric(5) not null
) ;
-- dmap_object_gen_tag : type : alter table name : holorecp
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holorecp alter column rec_ejerci set not null;
