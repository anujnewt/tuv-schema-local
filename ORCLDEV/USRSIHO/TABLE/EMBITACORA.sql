-- dmap_object_gen_tag : type : table name : embitacora
set search_path = usrsiho,oracle,dmap_extension,public;
create table "embitacora"  (
bit_keybit numeric(10) not null,
bit_keyusu numeric(10) not null,
bit_idepcc varchar(30) not null,
bit_clase varchar(30) not null,
bit_fecmov timestamp(0) not null,
bit_hormov varchar(8) not null,
bit_tipmov numeric(10) not null,
bit_tabla varchar(20) not null,
bit_campo1 varchar(20) not null,
bit_valor1 varchar(20),
bit_campo2 varchar(20),
bit_valor2 varchar(20),
bit_campo3 varchar(20),
bit_valor3 varchar(20),
bit_campo4 varchar(20),
bit_valor4 varchar(20)
) ;
-- dmap_object_gen_tag : type : alter table name : embitacora
set search_path = usrsiho,oracle,dmap_extension,public;
alter table embitacora alter column bit_keybit set not null;
-- dmap_object_gen_tag : type : alter table name : embitacora
set search_path = usrsiho,oracle,dmap_extension,public;
alter table embitacora alter column bit_keyusu set not null;
-- dmap_object_gen_tag : type : alter table name : embitacora
set search_path = usrsiho,oracle,dmap_extension,public;
alter table embitacora alter column bit_idepcc set not null;
-- dmap_object_gen_tag : type : alter table name : embitacora
set search_path = usrsiho,oracle,dmap_extension,public;
alter table embitacora alter column bit_clase set not null;
-- dmap_object_gen_tag : type : alter table name : embitacora
set search_path = usrsiho,oracle,dmap_extension,public;
alter table embitacora alter column bit_fecmov set not null;
-- dmap_object_gen_tag : type : alter table name : embitacora
set search_path = usrsiho,oracle,dmap_extension,public;
alter table embitacora alter column bit_hormov set not null;
-- dmap_object_gen_tag : type : alter table name : embitacora
set search_path = usrsiho,oracle,dmap_extension,public;
alter table embitacora alter column bit_tipmov set not null;
-- dmap_object_gen_tag : type : alter table name : embitacora
set search_path = usrsiho,oracle,dmap_extension,public;
alter table embitacora alter column bit_tabla set not null;
-- dmap_object_gen_tag : type : alter table name : embitacora
set search_path = usrsiho,oracle,dmap_extension,public;
alter table embitacora alter column bit_campo1 set not null;
