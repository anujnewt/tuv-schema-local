-- dmap_object_gen_tag : type : table name : pppempresa
set search_path = pppt,oracle,dmap_extension,public;
create table "pppempresa"  (
idempresa numeric(38) not null,
empresa varchar(100)
) ;
-- dmap_object_gen_tag : type : alter table name : pppempresa
set search_path = pppt,oracle,dmap_extension,public;
alter table pppempresa alter column idempresa set not null;
