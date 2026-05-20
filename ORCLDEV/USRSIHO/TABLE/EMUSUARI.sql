-- dmap_object_gen_tag : type : table name : emusuari
set search_path = usrsiho,oracle,dmap_extension,public;
create table "emusuari"  (
usu_keyusu numeric(10) not null,
usu_pass varchar(10) not null,
usu_nombre varchar(15) not null,
usu_apepat varchar(15) not null,
usu_apemat varchar(15) not null,
usu_fecalt timestamp(0) not null,
usu_puesto varchar(15) not null,
usu_status numeric(5) not null
) ;
-- dmap_object_gen_tag : type : alter table name : emusuari
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emusuari alter column usu_keyusu set not null;
-- dmap_object_gen_tag : type : alter table name : emusuari
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emusuari alter column usu_pass set not null;
-- dmap_object_gen_tag : type : alter table name : emusuari
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emusuari alter column usu_nombre set not null;
-- dmap_object_gen_tag : type : alter table name : emusuari
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emusuari alter column usu_apepat set not null;
-- dmap_object_gen_tag : type : alter table name : emusuari
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emusuari alter column usu_apemat set not null;
-- dmap_object_gen_tag : type : alter table name : emusuari
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emusuari alter column usu_fecalt set not null;
-- dmap_object_gen_tag : type : alter table name : emusuari
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emusuari alter column usu_puesto set not null;
-- dmap_object_gen_tag : type : alter table name : emusuari
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emusuari alter column usu_status set not null;
