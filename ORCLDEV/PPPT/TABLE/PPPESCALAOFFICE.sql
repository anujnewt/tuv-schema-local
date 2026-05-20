-- dmap_object_gen_tag : type : table name : pppescalaoffice
set search_path = pppt,oracle,dmap_extension,public;
create table "pppescalaoffice"  (
idprueba numeric(38) not null,
tema numeric(38) not null,
nivel numeric(38) not null,
minimo numeric(38) not null,
maximo numeric(38) not null
) ;
-- dmap_object_gen_tag : type : alter table name : pppescalaoffice
set search_path = pppt,oracle,dmap_extension,public;
alter table pppescalaoffice alter column idprueba set not null;
-- dmap_object_gen_tag : type : alter table name : pppescalaoffice
set search_path = pppt,oracle,dmap_extension,public;
alter table pppescalaoffice alter column tema set not null;
-- dmap_object_gen_tag : type : alter table name : pppescalaoffice
set search_path = pppt,oracle,dmap_extension,public;
alter table pppescalaoffice alter column nivel set not null;
-- dmap_object_gen_tag : type : alter table name : pppescalaoffice
set search_path = pppt,oracle,dmap_extension,public;
alter table pppescalaoffice alter column minimo set not null;
-- dmap_object_gen_tag : type : alter table name : pppescalaoffice
set search_path = pppt,oracle,dmap_extension,public;
alter table pppescalaoffice alter column maximo set not null;
