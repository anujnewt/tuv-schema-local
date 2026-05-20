-- dmap_object_gen_tag : type : table name : pppajusteoffice
set search_path = pppt,oracle,dmap_extension,public;
create table "pppajusteoffice"  (
idprueba numeric(38) not null,
idnivel numeric(38) not null,
porcentaje numeric not null
) ;
-- dmap_object_gen_tag : type : alter table name : pppajusteoffice
set search_path = pppt,oracle,dmap_extension,public;
alter table pppajusteoffice alter column idprueba set not null;
-- dmap_object_gen_tag : type : alter table name : pppajusteoffice
set search_path = pppt,oracle,dmap_extension,public;
alter table pppajusteoffice alter column idnivel set not null;
-- dmap_object_gen_tag : type : alter table name : pppajusteoffice
set search_path = pppt,oracle,dmap_extension,public;
alter table pppajusteoffice alter column porcentaje set not null;
