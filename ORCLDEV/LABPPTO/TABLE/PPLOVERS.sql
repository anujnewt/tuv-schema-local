-- dmap_object_gen_tag : type : table name : pplovers
set search_path = labppto,oracle,dmap_extension,public;
create table "pplovers"  (
ver_keycia varchar(4) not null,
ver_anio numeric(38) not null,
ver_mes numeric(38) not null,
ver_keyver numeric(38) not null,
ver_descri varchar(30) not null,
ver_status numeric(38) not null
) ;
-- dmap_object_gen_tag : type : alter table name : pplovers
set search_path = labppto,oracle,dmap_extension,public;
alter table pplovers alter column ver_keycia set not null;
-- dmap_object_gen_tag : type : alter table name : pplovers
set search_path = labppto,oracle,dmap_extension,public;
alter table pplovers alter column ver_anio set not null;
-- dmap_object_gen_tag : type : alter table name : pplovers
set search_path = labppto,oracle,dmap_extension,public;
alter table pplovers alter column ver_mes set not null;
-- dmap_object_gen_tag : type : alter table name : pplovers
set search_path = labppto,oracle,dmap_extension,public;
alter table pplovers alter column ver_keyver set not null;
-- dmap_object_gen_tag : type : alter table name : pplovers
set search_path = labppto,oracle,dmap_extension,public;
alter table pplovers alter column ver_descri set not null;
-- dmap_object_gen_tag : type : alter table name : pplovers
set search_path = labppto,oracle,dmap_extension,public;
alter table pplovers alter column ver_status set not null;
