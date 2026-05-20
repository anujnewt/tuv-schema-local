-- dmap_object_gen_tag : type : table name : holodettra
set search_path = usrsiho,oracle,dmap_extension,public;
create table "holodettra"  (
det_serial numeric(10) not null,
det_num_id numeric(10) not null,
det_keydep varchar(16) not null,
det_fecgra timestamp(0) not null,
det_keytco numeric(10),
det_sindkto varchar(15),
det_keyfol numeric(10),
det_keyemp numeric(10),
det_nomcor varchar(40),
det_person varchar(40),
det_keypue varchar(16),
det_keycon varchar(5),
det_noforo varchar(20),
det_hralla varchar(5),
det_hraent varchar(5),
det_hrasal varchar(5),
det_hrstra decimal(6, 2),
det_capgra varchar(60),
det_stsreg varchar(1),
det_stspag varchar(1),
det_keyaut varchar(15),
det_inanda varchar(1),
det_ultact timestamp(0),
det_fecpag timestamp(0),
det_keyrph numeric(10),
det_keynom numeric(5),
det_cdilla numeric(10),
det_capini numeric(5),
det_capfin numeric(5),
det_auxnu1 numeric(10),
det_auxnu2 numeric(10),
det_auxca1 varchar(150),
det_auxca2 varchar(20),
det_usuori varchar(15) not null,
det_fecori timestamp(0),
det_usufin varchar(15),
det_fecfin timestamp(0),
det_tipinc varchar(2),
det_cosuni decimal(12, 2),
det_numlla numeric(10),
det_honint numeric(5),
det_acomen numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : holodettra
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holodettra alter column det_serial set not null;
-- dmap_object_gen_tag : type : alter table name : holodettra
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holodettra alter column det_num_id set not null;
-- dmap_object_gen_tag : type : alter table name : holodettra
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holodettra alter column det_keydep set not null;
-- dmap_object_gen_tag : type : alter table name : holodettra
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holodettra alter column det_fecgra set not null;
-- dmap_object_gen_tag : type : alter table name : holodettra
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holodettra alter column det_usuori set not null;
