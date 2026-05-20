-- dmap_object_gen_tag : type : table name : holodella
set search_path = usrsiho,oracle,dmap_extension,public;
create table "holodella"  (
del_keydep varchar(16) not null,
del_feclla timestamp(0) not null,
del_keytco numeric(10),
del_sindkto varchar(8),
del_keyfol numeric(10),
del_keyemp numeric(10),
del_nomcor varchar(40),
del_person varchar(40),
del_clasif varchar(40),
del_noforo varchar(20),
del_hralla varchar(10),
del_hraent varchar(10),
del_hrasal varchar(10),
del_hratra varchar(10),
del_capgra varchar(60),
del_status varchar(4),
del_stspag varchar(1),
del_keyaut varchar(15),
del_inanda varchar(1),
del_ultact timestamp(0),
del_fecpag timestamp(0),
del_keyrph numeric(10),
del_keynom numeric(5),
del_cdilla numeric(10),
del_capini numeric(10),
del_capfin numeric(10),
del_auxnu1 numeric(10),
del_auxnu2 numeric(10),
del_auxca1 varchar(150),
del_auxca2 varchar(20),
del_usuori varchar(15) not null,
del_fecori timestamp(0) not null,
del_usufin varchar(15),
del_fecfin timestamp(0),
del_numfol numeric(10) not null
) ;
-- dmap_object_gen_tag : type : alter table name : holodella
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holodella alter column del_keydep set not null;
-- dmap_object_gen_tag : type : alter table name : holodella
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holodella alter column del_feclla set not null;
-- dmap_object_gen_tag : type : alter table name : holodella
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holodella alter column del_usuori set not null;
-- dmap_object_gen_tag : type : alter table name : holodella
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holodella alter column del_fecori set not null;
-- dmap_object_gen_tag : type : alter table name : holodella
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holodella alter column del_numfol set not null;
