-- dmap_object_gen_tag : type : table name : holopoli
set search_path = usrsiho,oracle,dmap_extension,public;
create table "holopoli"  (
pol_keypol numeric(10) not null,
pol_ctvpol numeric(5) not null,
pol_keypro numeric(5),
pol_keyapr varchar(6) not null,
pol_keynom numeric(5),
pol_numemi numeric(5) not null,
pol_tippol varchar(1) not null,
pol_stspol varchar(1) not null,
pol_cvepol varchar(30),
pol_fecpol timestamp(0) not null,
pol_percon varchar(10) not null,
pol_numrem numeric(10),
pol_remrec numeric(10),
pol_totcar decimal(16, 2) not null,
pol_totabo decimal(16, 2) not null,
pol_carpas decimal(16, 2),
pol_abopas decimal(16, 2),
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
pol_ctvmad numeric(5)
) ;
-- dmap_object_gen_tag : type : alter table name : holopoli
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holopoli add constraint pk_hpoli primary key (pol_keypol,pol_ctvpol);
-- dmap_object_gen_tag : type : alter table name : holopoli
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holopoli alter column pol_keypol set not null;
-- dmap_object_gen_tag : type : alter table name : holopoli
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holopoli alter column pol_ctvpol set not null;
-- dmap_object_gen_tag : type : alter table name : holopoli
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holopoli alter column pol_keyapr set not null;
-- dmap_object_gen_tag : type : alter table name : holopoli
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holopoli alter column pol_numemi set not null;
-- dmap_object_gen_tag : type : alter table name : holopoli
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holopoli alter column pol_tippol set not null;
-- dmap_object_gen_tag : type : alter table name : holopoli
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holopoli alter column pol_stspol set not null;
-- dmap_object_gen_tag : type : alter table name : holopoli
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holopoli alter column pol_fecpol set not null;
-- dmap_object_gen_tag : type : alter table name : holopoli
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holopoli alter column pol_percon set not null;
-- dmap_object_gen_tag : type : alter table name : holopoli
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holopoli alter column pol_totcar set not null;
-- dmap_object_gen_tag : type : alter table name : holopoli
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holopoli alter column pol_totabo set not null;
