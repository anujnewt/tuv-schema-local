-- dmap_object_gen_tag : type : table name : pploconc
set search_path = labppto,oracle,dmap_extension,public;
create table "pploconc"  (
con_keycon varchar(3) not null,
con_descri varchar(35) not null,
con_keycue numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : pploconc
set search_path = labppto,oracle,dmap_extension,public;
alter table pploconc alter column con_keycon set not null;
-- dmap_object_gen_tag : type : alter table name : pploconc
set search_path = labppto,oracle,dmap_extension,public;
alter table pploconc alter column con_descri set not null;
