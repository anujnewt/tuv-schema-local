-- dmap_object_gen_tag : type : table name : api_movimientosper
set search_path = labprod,oracle,dmap_extension,public;
create table "api_movimientosper"  (
id_transaccion varchar(30) not null,
id_origen varchar(30) not null,
emp_keyemp numeric(10) not null,
emp_keydep varchar(16) not null,
emp_keypue varchar(16) not null,
emp_keycen varchar(16) not null,
emp_keyloc varchar(16) not null,
emp_apepat varchar(90),
emp_apemat varchar(90),
emp_nombre varchar(90),
emp_domemp varchar(100),
emp_numext varchar(10),
emp_numint varchar(10),
emp_colemp varchar(100),
emp_cidemp varchar(255),
emp_munemp varchar(6),
emp_entemp varchar(2),
emp_codemp varchar(5),
emp_telemp varchar(60),
emp_regrfc varchar(13),
emp_recurp varchar(18),
emp_regims varchar(12),
emp_cvesex varchar(1),
emp_keyims varchar(16) not null,
emp_cvezon numeric(10),
emp_keypro numeric(10),
emp_tipemp varchar(6),
emp_tipsal varchar(1),
emp_status numeric(10) not null,
emp_salhor decimal(18, 6),
emp_saldia decimal(18, 6),
emp_salmes decimal(18, 6),
emp_forpag varchar(2),
emp_ctaban varchar(18),
emp_cvebaj varchar(4),
emp_fecaux timestamp(0),
emp_jorlab varchar(1),
emp_unijor numeric,
emp_ca2aux varchar(10),
emp_fecven timestamp(0),
emp_fecpla timestamp(0),
emp_ca1aux varchar(10),
emp_fecha_mov timestamp(0) not null,
emp_fecha_imss timestamp(0),
emp_tipmov varchar(2) not null,
emp_submov varchar(6) not null,
fecha_insert timestamp(0),
fecha_proc timestamp(0),
emp_salint decimal(18, 6),
keyper varchar(7),
estatus numeric(10),
code varchar(150),
message varchar(150),
emp_salivc numeric(12),
emp_salinf numeric(12),
emp_intsin numeric(12),
emp_infsin numeric(12),
emp_keyplz numeric(38) not null
) ;
-- dmap_object_gen_tag : type : alter table name : api_movimientosper
set search_path = labprod,oracle,dmap_extension,public;
alter table api_movimientosper alter column id_transaccion set not null;
-- dmap_object_gen_tag : type : alter table name : api_movimientosper
set search_path = labprod,oracle,dmap_extension,public;
alter table api_movimientosper alter column id_origen set not null;
-- dmap_object_gen_tag : type : alter table name : api_movimientosper
set search_path = labprod,oracle,dmap_extension,public;
alter table api_movimientosper alter column emp_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : api_movimientosper
set search_path = labprod,oracle,dmap_extension,public;
alter table api_movimientosper alter column emp_keydep set not null;
-- dmap_object_gen_tag : type : alter table name : api_movimientosper
set search_path = labprod,oracle,dmap_extension,public;
alter table api_movimientosper alter column emp_keypue set not null;
-- dmap_object_gen_tag : type : alter table name : api_movimientosper
set search_path = labprod,oracle,dmap_extension,public;
alter table api_movimientosper alter column emp_keycen set not null;
-- dmap_object_gen_tag : type : alter table name : api_movimientosper
set search_path = labprod,oracle,dmap_extension,public;
alter table api_movimientosper alter column emp_keyloc set not null;
-- dmap_object_gen_tag : type : alter table name : api_movimientosper
set search_path = labprod,oracle,dmap_extension,public;
alter table api_movimientosper alter column emp_keyims set not null;
-- dmap_object_gen_tag : type : alter table name : api_movimientosper
set search_path = labprod,oracle,dmap_extension,public;
alter table api_movimientosper alter column emp_status set not null;
-- dmap_object_gen_tag : type : alter table name : api_movimientosper
set search_path = labprod,oracle,dmap_extension,public;
alter table api_movimientosper alter column emp_fecha_mov set not null;
-- dmap_object_gen_tag : type : alter table name : api_movimientosper
set search_path = labprod,oracle,dmap_extension,public;
alter table api_movimientosper alter column emp_tipmov set not null;
-- dmap_object_gen_tag : type : alter table name : api_movimientosper
set search_path = labprod,oracle,dmap_extension,public;
alter table api_movimientosper alter column emp_submov set not null;
-- dmap_object_gen_tag : type : alter table name : api_movimientosper
set search_path = labprod,oracle,dmap_extension,public;
alter table api_movimientosper alter column emp_keyplz set not null;
