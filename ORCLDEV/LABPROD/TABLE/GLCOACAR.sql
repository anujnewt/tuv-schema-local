-- dmap_object_gen_tag : type : table name : glcoacar
set search_path = labprod,oracle,dmap_extension,public;
create table "glcoacar"  (
aca_keyusu numeric(38) not null,
aca_keyapr varchar(6) not null,
aca_keypro numeric(38) not null,
aca_actual varchar(1)
) ;
-- dmap_object_gen_tag : type : alter table name : glcoacar
set search_path = labprod,oracle,dmap_extension,public;
alter table glcoacar add constraint pk_glcoacar primary key (aca_keyusu,aca_keyapr,aca_keypro);
-- dmap_object_gen_tag : type : alter table name : glcoacar
set search_path = labprod,oracle,dmap_extension,public;
alter table glcoacar alter column aca_keyusu set not null;
-- dmap_object_gen_tag : type : alter table name : glcoacar
set search_path = labprod,oracle,dmap_extension,public;
alter table glcoacar alter column aca_keyapr set not null;
-- dmap_object_gen_tag : type : alter table name : glcoacar
set search_path = labprod,oracle,dmap_extension,public;
alter table glcoacar alter column aca_keypro set not null;
