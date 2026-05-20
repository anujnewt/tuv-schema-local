-- dmap_object_gen_tag : type : table name : pppagrales
set search_path = labprod,oracle,dmap_extension,public;
create table "pppagrales"  (
gra_keysec numeric(38) not null,
gra_descri char(60) not null,
gra_valor char(255) not null
) ;
-- dmap_object_gen_tag : type : alter table name : pppagrales
set search_path = labprod,oracle,dmap_extension,public;
alter table pppagrales alter column gra_keysec set not null;
-- dmap_object_gen_tag : type : alter table name : pppagrales
set search_path = labprod,oracle,dmap_extension,public;
alter table pppagrales alter column gra_descri set not null;
-- dmap_object_gen_tag : type : alter table name : pppagrales
set search_path = labprod,oracle,dmap_extension,public;
alter table pppagrales alter column gra_valor set not null;
