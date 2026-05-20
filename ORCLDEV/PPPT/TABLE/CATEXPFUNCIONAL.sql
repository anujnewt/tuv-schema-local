-- dmap_object_gen_tag : type : table name : catexpfuncional
set search_path = pppt,oracle,dmap_extension,public;
create table "catexpfuncional"  (
idexpfuncional numeric(38) not null default 0,
expfuncional varchar(50)
) ;
-- dmap_object_gen_tag : type : alter table name : catexpfuncional
set search_path = pppt,oracle,dmap_extension,public;
alter table catexpfuncional alter column idexpfuncional set not null;
