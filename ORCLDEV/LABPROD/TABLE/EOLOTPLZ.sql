-- dmap_object_gen_tag : type : table name : eolotplz
set search_path = labprod,oracle,dmap_extension,public;
create table "eolotplz"  (
tpl_numsec numeric(5) not null,
tpl_tipplz varchar(2) not null,
tpl_descri varchar(40) not null,
tpl_dessec varchar(20),
tpl_catego varchar(1),
tpl_keypro numeric(5) not null
) ;
-- dmap_object_gen_tag : type : alter table name : eolotplz
set search_path = labprod,oracle,dmap_extension,public;
alter table eolotplz alter column tpl_numsec set not null;
-- dmap_object_gen_tag : type : alter table name : eolotplz
set search_path = labprod,oracle,dmap_extension,public;
alter table eolotplz alter column tpl_tipplz set not null;
-- dmap_object_gen_tag : type : alter table name : eolotplz
set search_path = labprod,oracle,dmap_extension,public;
alter table eolotplz alter column tpl_descri set not null;
-- dmap_object_gen_tag : type : alter table name : eolotplz
set search_path = labprod,oracle,dmap_extension,public;
alter table eolotplz alter column tpl_keypro set not null;
