-- dmap_object_gen_tag : type : table name : glcoacar
set search_path = usrsiho,oracle,dmap_extension,public;
create table "glcoacar"  (
aca_keypro numeric(5) not null,
aca_keyapr varchar(6) not null,
aca_keyusu numeric(10) not null,
aca_actual varchar(1)
) ;
-- dmap_object_gen_tag : type : alter table name : glcoacar
set search_path = usrsiho,oracle,dmap_extension,public;
alter table glcoacar add constraint pk_gacar primary key (aca_keypro,aca_keyapr,aca_keyusu);
-- dmap_object_gen_tag : type : alter table name : glcoacar
set search_path = usrsiho,oracle,dmap_extension,public;
alter table glcoacar alter column aca_keypro set not null;
-- dmap_object_gen_tag : type : alter table name : glcoacar
set search_path = usrsiho,oracle,dmap_extension,public;
alter table glcoacar alter column aca_keyusu set not null;
