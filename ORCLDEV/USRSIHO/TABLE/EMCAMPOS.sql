-- dmap_object_gen_tag : type : table name : emcampos
set search_path = usrsiho,oracle,dmap_extension,public;
create table "emcampos"  (
cam_keycam numeric(10) not null,
cam_nombre varchar(10) not null,
cam_descri varchar(255) not null,
cam_keytab numeric(10) not null
) ;
-- dmap_object_gen_tag : type : alter table name : emcampos
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emcampos alter column cam_keycam set not null;
-- dmap_object_gen_tag : type : alter table name : emcampos
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emcampos alter column cam_nombre set not null;
-- dmap_object_gen_tag : type : alter table name : emcampos
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emcampos alter column cam_descri set not null;
-- dmap_object_gen_tag : type : alter table name : emcampos
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emcampos alter column cam_keytab set not null;
