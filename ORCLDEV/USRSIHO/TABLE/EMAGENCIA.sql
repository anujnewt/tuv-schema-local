-- dmap_object_gen_tag : type : table name : emagencia
set search_path = usrsiho,oracle,dmap_extension,public;
create table "emagencia"  (
age_numage numeric(10) not null,
age_cvsiho numeric(10),
age_nombre varchar(60) not null,
age_razsoc varchar(30) not null,
age_contel varchar(30),
age_cvecla varchar(6) not null,
age_rfc varchar(20) not null,
age_calle varchar(30) not null,
age_coloni varchar(30) not null,
age_cvedel numeric(5) not null,
age_numext varchar(20) not null,
age_numint varchar(20),
age_codpos numeric(5) not null,
age_cveent numeric(10) not null,
age_pais varchar(30) not null,
age_telef1 varchar(15) not null,
age_telef2 varchar(15),
age_observ varchar(250)
) ;
-- dmap_object_gen_tag : type : alter table name : emagencia
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emagencia alter column age_numage set not null;
-- dmap_object_gen_tag : type : alter table name : emagencia
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emagencia alter column age_nombre set not null;
-- dmap_object_gen_tag : type : alter table name : emagencia
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emagencia alter column age_razsoc set not null;
-- dmap_object_gen_tag : type : alter table name : emagencia
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emagencia alter column age_cvecla set not null;
-- dmap_object_gen_tag : type : alter table name : emagencia
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emagencia alter column age_rfc set not null;
-- dmap_object_gen_tag : type : alter table name : emagencia
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emagencia alter column age_calle set not null;
-- dmap_object_gen_tag : type : alter table name : emagencia
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emagencia alter column age_coloni set not null;
-- dmap_object_gen_tag : type : alter table name : emagencia
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emagencia alter column age_cvedel set not null;
-- dmap_object_gen_tag : type : alter table name : emagencia
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emagencia alter column age_numext set not null;
-- dmap_object_gen_tag : type : alter table name : emagencia
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emagencia alter column age_codpos set not null;
-- dmap_object_gen_tag : type : alter table name : emagencia
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emagencia alter column age_cveent set not null;
-- dmap_object_gen_tag : type : alter table name : emagencia
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emagencia alter column age_pais set not null;
-- dmap_object_gen_tag : type : alter table name : emagencia
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emagencia alter column age_telef1 set not null;
