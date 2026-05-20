-- dmap_object_gen_tag : type : table name : pppagrales
set search_path = labppto,oracle,dmap_extension,public;
create table "pppagrales"  (
gra_keysec numeric(10) not null,
gra_descri varchar(60) not null,
gra_valor varchar(255) not null
) ;
-- dmap_object_gen_tag : type : alter table name : pppagrales
set search_path = labppto,oracle,dmap_extension,public;
alter table pppagrales alter column gra_keysec set not null;
-- dmap_object_gen_tag : type : alter table name : pppagrales
set search_path = labppto,oracle,dmap_extension,public;
alter table pppagrales alter column gra_descri set not null;
-- dmap_object_gen_tag : type : alter table name : pppagrales
set search_path = labppto,oracle,dmap_extension,public;
alter table pppagrales alter column gra_valor set not null;
