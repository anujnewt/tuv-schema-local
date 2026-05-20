-- dmap_object_gen_tag : type : table name : emmencat
set search_path = usrsiho,oracle,dmap_extension,public;
create table "emmencat"  (
men_keyobj numeric(10) not null,
men_padre numeric(5) not null,
men_orden numeric(5) not null,
men_tipmen varchar(1) not null,
men_tipobj varchar(4) not null,
men_descor varchar(30) not null,
men_deslar varchar(60),
men_icono varchar(20),
men_hotkey varchar(10),
men_clase varchar(30)
) ;
-- dmap_object_gen_tag : type : alter table name : emmencat
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emmencat alter column men_keyobj set not null;
-- dmap_object_gen_tag : type : alter table name : emmencat
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emmencat alter column men_padre set not null;
-- dmap_object_gen_tag : type : alter table name : emmencat
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emmencat alter column men_orden set not null;
-- dmap_object_gen_tag : type : alter table name : emmencat
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emmencat alter column men_tipmen set not null;
-- dmap_object_gen_tag : type : alter table name : emmencat
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emmencat alter column men_tipobj set not null;
-- dmap_object_gen_tag : type : alter table name : emmencat
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emmencat alter column men_descor set not null;
