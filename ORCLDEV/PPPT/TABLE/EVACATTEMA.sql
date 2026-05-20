-- dmap_object_gen_tag : type : table name : evacattema
set search_path = pppt,oracle,dmap_extension,public;
create table "evacattema"  (
idtema numeric(38) not null default 0,
tema varchar(100) not null,
idempresa numeric(38) not null default 0
) ;
-- dmap_object_gen_tag : type : alter table name : evacattema
set search_path = pppt,oracle,dmap_extension,public;
alter table evacattema alter column idtema set not null;
-- dmap_object_gen_tag : type : alter table name : evacattema
set search_path = pppt,oracle,dmap_extension,public;
alter table evacattema alter column tema set not null;
-- dmap_object_gen_tag : type : alter table name : evacattema
set search_path = pppt,oracle,dmap_extension,public;
alter table evacattema alter column idempresa set not null;
