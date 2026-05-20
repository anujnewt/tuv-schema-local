-- dmap_object_gen_tag : type : table name : pcusuarios
set search_path = usrsiho,oracle,dmap_extension,public;
create table "pcusuarios"  (
usuidnumerousuario numeric(10) not null,
usupassword varchar(10) not null,
usulogin varchar(10) not null,
usunombre varchar(60),
usuacceso numeric(10) not null,
usuestado numeric(10) not null
) ;
-- dmap_object_gen_tag : type : alter table name : pcusuarios
set search_path = usrsiho,oracle,dmap_extension,public;
alter table pcusuarios add constraint ct_pcusuarios2 primary key (usuidnumerousuario);
-- dmap_object_gen_tag : type : alter table name : pcusuarios
set search_path = usrsiho,oracle,dmap_extension,public;
alter table pcusuarios alter column usuidnumerousuario set not null;
-- dmap_object_gen_tag : type : alter table name : pcusuarios
set search_path = usrsiho,oracle,dmap_extension,public;
alter table pcusuarios alter column usupassword set not null;
-- dmap_object_gen_tag : type : alter table name : pcusuarios
set search_path = usrsiho,oracle,dmap_extension,public;
alter table pcusuarios alter column usulogin set not null;
-- dmap_object_gen_tag : type : alter table name : pcusuarios
set search_path = usrsiho,oracle,dmap_extension,public;
alter table pcusuarios alter column usuacceso set not null;
-- dmap_object_gen_tag : type : alter table name : pcusuarios
set search_path = usrsiho,oracle,dmap_extension,public;
alter table pcusuarios alter column usuestado set not null;
