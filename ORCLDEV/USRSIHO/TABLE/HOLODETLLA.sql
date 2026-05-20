-- dmap_object_gen_tag : type : table name : holodetlla
set search_path = usrsiho,oracle,dmap_extension,public;
create table "holodetlla"  (
det_serial numeric(10) not null,
det_num_id numeric(10) not null,
det_keydep varchar(16),
det_feclla timestamp(0) not null,
det_keytco numeric(10),
det_sindkto varchar(15),
det_keyfol numeric(10),
det_keyemp numeric(10),
det_nomcor varchar(40),
det_person varchar(40),
det_keypue varchar(16),
det_noforo varchar(20),
det_hralla varchar(10),
det_ultact timestamp(0),
det_auxnu1 numeric(10),
det_auxnu2 numeric(10),
det_auxca1 varchar(150),
det_auxca2 varchar(20),
det_usuori varchar(15) not null,
det_tipinc varchar(2),
det_stslla varchar(1),
det_cdilla numeric(10),
det_cosuni decimal(12, 2),
det_solscc numeric(10),
det_regsol numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : holodetlla
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holodetlla alter column det_serial set not null;
-- dmap_object_gen_tag : type : alter table name : holodetlla
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holodetlla alter column det_num_id set not null;
-- dmap_object_gen_tag : type : alter table name : holodetlla
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holodetlla alter column det_feclla set not null;
-- dmap_object_gen_tag : type : alter table name : holodetlla
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holodetlla alter column det_usuori set not null;
