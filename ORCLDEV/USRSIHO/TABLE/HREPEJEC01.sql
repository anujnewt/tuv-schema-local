-- dmap_object_gen_tag : type : table name : hrepejec01
set search_path = usrsiho,oracle,dmap_extension,public;
create table "hrepejec01"  (
eje_keynom numeric(5) not null,
eje_numemi varchar(6) not null,
eje_keyapr varchar(6) not null,
eje_nummes numeric(5) not null,
eje_numcap numeric(5),
eje_keyemp numeric(10) not null,
eje_keytpr varchar(6),
eje_keydep varchar(16) not null,
eje_keypue varchar(16) not null,
eje_regfis varchar(6),
eje_plazas numeric(5),
eje_person numeric(5),
eje_grupos varchar(6),
eje_tipfol varchar(6),
eje_tipcam varchar(6),
eje_ssctas varchar(10),
eje_basess decimal(16, 2),
eje_otring decimal(16, 2),
eje_tiextr decimal(16, 2),
eje_prevso decimal(16, 2),
eje_sindic decimal(16, 2),
eje_ivaacr decimal(16, 2),
eje_ivapen decimal(16, 2),
eje_ispttt decimal(16, 2),
eje_isrnac decimal(16, 2),
eje_isrext decimal(16, 2),
eje_pensio decimal(16, 2),
eje_otrdes decimal(16, 2),
eje_cuocen decimal(16, 2),
eje_secci1 decimal(16, 2),
eje_secci6 decimal(16, 2),
eje_secc10 decimal(16, 2),
eje_secc12 decimal(16, 2),
eje_cuomus decimal(16, 2),
eje_ivaret decimal(16, 2),
eje_stspag varchar(3),
eje_fecpag timestamp(0),
eje_fecgen timestamp(0),
eje_keypro numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : hrepejec01
set search_path = usrsiho,oracle,dmap_extension,public;
alter table hrepejec01 alter column eje_keynom set not null;
-- dmap_object_gen_tag : type : alter table name : hrepejec01
set search_path = usrsiho,oracle,dmap_extension,public;
alter table hrepejec01 alter column eje_numemi set not null;
-- dmap_object_gen_tag : type : alter table name : hrepejec01
set search_path = usrsiho,oracle,dmap_extension,public;
alter table hrepejec01 alter column eje_keyapr set not null;
-- dmap_object_gen_tag : type : alter table name : hrepejec01
set search_path = usrsiho,oracle,dmap_extension,public;
alter table hrepejec01 alter column eje_nummes set not null;
-- dmap_object_gen_tag : type : alter table name : hrepejec01
set search_path = usrsiho,oracle,dmap_extension,public;
alter table hrepejec01 alter column eje_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : hrepejec01
set search_path = usrsiho,oracle,dmap_extension,public;
alter table hrepejec01 alter column eje_keydep set not null;
-- dmap_object_gen_tag : type : alter table name : hrepejec01
set search_path = usrsiho,oracle,dmap_extension,public;
alter table hrepejec01 alter column eje_keypue set not null;
