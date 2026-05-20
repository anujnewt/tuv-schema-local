-- dmap_object_gen_tag : type : table name : holopoli1
set search_path = usrsiho,oracle,dmap_extension,public;
create table "holopoli1"  (
pol_keypol numeric(10) not null,
pol_ctvpol numeric(5) not null,
pol_keypro numeric(5),
pol_keyapr varchar(6) not null,
pol_keynom numeric(5),
pol_numemi numeric(5) not null,
pol_keyrec numeric(10) not null,
pol_keyemp numeric(10) not null,
pol_regrfc varchar(18),
pol_emipag varchar(10),
pol_tippol varchar(1) not null,
pol_stspol varchar(1) not null,
pol_cvepol varchar(50),
pol_fecpol timestamp(0) not null,
pol_percon varchar(10) not null,
pol_numrem numeric(10),
pol_remrec numeric(10),
pol_totcar decimal(16, 6) not null,
pol_totabo decimal(16, 6) not null,
pol_carpas decimal(16, 6),
pol_abopas decimal(16, 6),
pol_usugen numeric(10),
pol_fecgen timestamp(0),
pol_usurem numeric(10),
pol_fecrem timestamp(0),
pol_usuaut numeric(10),
pol_fecaut timestamp(0),
pol_contra varchar(40),
pol_semana numeric(5),
pol_tipcta numeric(5),
pol_keymad numeric(10),
pol_ctvmad numeric(5),
pol_regfis varchar(4),
pol_forpag numeric(5),
pol_tipcam decimal(16, 6),
pol_fpafin numeric(10),
pol_tcafin decimal(16, 6),
pol_auxnu1 numeric(10),
pol_auxca1 varchar(20)
) ;
-- dmap_object_gen_tag : type : alter table name : holopoli1
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holopoli1 add constraint pk_hpoli1 primary key (pol_keypol,pol_ctvpol);
-- dmap_object_gen_tag : type : alter table name : holopoli1
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holopoli1 alter column pol_keypol set not null;
-- dmap_object_gen_tag : type : alter table name : holopoli1
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holopoli1 alter column pol_ctvpol set not null;
-- dmap_object_gen_tag : type : alter table name : holopoli1
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holopoli1 alter column pol_keyapr set not null;
-- dmap_object_gen_tag : type : alter table name : holopoli1
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holopoli1 alter column pol_numemi set not null;
-- dmap_object_gen_tag : type : alter table name : holopoli1
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holopoli1 alter column pol_keyrec set not null;
-- dmap_object_gen_tag : type : alter table name : holopoli1
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holopoli1 alter column pol_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : holopoli1
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holopoli1 alter column pol_tippol set not null;
-- dmap_object_gen_tag : type : alter table name : holopoli1
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holopoli1 alter column pol_stspol set not null;
-- dmap_object_gen_tag : type : alter table name : holopoli1
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holopoli1 alter column pol_fecpol set not null;
-- dmap_object_gen_tag : type : alter table name : holopoli1
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holopoli1 alter column pol_percon set not null;
-- dmap_object_gen_tag : type : alter table name : holopoli1
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holopoli1 alter column pol_totcar set not null;
-- dmap_object_gen_tag : type : alter table name : holopoli1
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holopoli1 alter column pol_totabo set not null;
