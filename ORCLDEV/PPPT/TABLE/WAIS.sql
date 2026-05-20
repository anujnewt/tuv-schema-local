-- dmap_object_gen_tag : type : table name : wais
set search_path = pppt,oracle,dmap_extension,public;
create table "wais"  (
tipo numeric(38) not null,
maximo numeric not null,
v17 numeric,
v19 numeric,
v24 numeric,
v34 numeric,
v44 numeric,
v54 numeric,
v64 numeric,
v69 numeric,
v74 numeric,
v999 numeric
) ;
-- dmap_object_gen_tag : type : alter table name : wais
set search_path = pppt,oracle,dmap_extension,public;
alter table wais alter column tipo set not null;
-- dmap_object_gen_tag : type : alter table name : wais
set search_path = pppt,oracle,dmap_extension,public;
alter table wais alter column maximo set not null;
