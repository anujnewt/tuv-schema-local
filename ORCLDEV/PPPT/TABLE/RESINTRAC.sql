-- dmap_object_gen_tag : type : table name : resintrac
set search_path = pppt,oracle,dmap_extension,public;
create table "resintrac"  (
idpersonal numeric(38) not null,
serie1 numeric,
serie2 numeric,
serie3 numeric,
serie4 numeric,
serie5 numeric,
serie6 numeric,
serie7 numeric,
serie8 numeric,
serie9 numeric,
ci numeric(38),
status numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : resintrac
set search_path = pppt,oracle,dmap_extension,public;
alter table resintrac alter column idpersonal set not null;
