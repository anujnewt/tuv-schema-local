-- dmap_object_gen_tag : type : table name : holoalem
set search_path = usrsiho,oracle,dmap_extension,public;
create table "holoalem"  (
ale_keyemp numeric(10) not null,
ale_marper varchar(1),
ale_fecnac timestamp(0),
ale_cranda numeric(10),
ale_calsin varchar(5),
ale_paisrs varchar(3),
ale_telem2 varchar(15),
ale_origen varchar(30),
ale_keytco numeric(10),
ale_cedula varchar(20),
ale_relpag numeric(5),
ale_keypr2 numeric(5),
ale_keyem2 numeric(10),
ale_arefis varchar(6),
ale_telem3 varchar(15),
ale_domemp varchar(60),
ale_status numeric(5),
ale_marrfc varchar(1),
ale_numint varchar(40),
ale_numext varchar(40)
) ;
-- dmap_object_gen_tag : type : alter table name : holoalem
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoalem add constraint pk_holoalem primary key (ale_keyemp);
-- dmap_object_gen_tag : type : alter table name : holoalem
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holoalem alter column ale_keyemp set not null;
