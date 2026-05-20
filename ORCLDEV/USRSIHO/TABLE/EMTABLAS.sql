-- dmap_object_gen_tag : type : table name : emtablas
set search_path = usrsiho,oracle,dmap_extension,public;
create table "emtablas"  (
tab_keytab numeric(10) not null,
tab_nombre varchar(50) not null,
tab_descri varchar(60) not null,
tab_aliast varchar(5) not null,
tab_restri varchar(255),
tab_keymod numeric(10)
) ;
-- dmap_object_gen_tag : type : alter table name : emtablas
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emtablas alter column tab_keytab set not null;
-- dmap_object_gen_tag : type : alter table name : emtablas
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emtablas alter column tab_nombre set not null;
-- dmap_object_gen_tag : type : alter table name : emtablas
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emtablas alter column tab_descri set not null;
-- dmap_object_gen_tag : type : alter table name : emtablas
set search_path = usrsiho,oracle,dmap_extension,public;
alter table emtablas alter column tab_aliast set not null;
