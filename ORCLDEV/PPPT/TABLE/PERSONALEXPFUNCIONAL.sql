-- dmap_object_gen_tag : type : table name : personalexpfuncional
set search_path = pppt,oracle,dmap_extension,public;
create table "personalexpfuncional"  (
idpersonal numeric(38) not null,
idexpfuncional numeric(38) not null
) ;
-- dmap_object_gen_tag : type : alter table name : personalexpfuncional
set search_path = pppt,oracle,dmap_extension,public;
alter table personalexpfuncional alter column idpersonal set not null;
-- dmap_object_gen_tag : type : alter table name : personalexpfuncional
set search_path = pppt,oracle,dmap_extension,public;
alter table personalexpfuncional alter column idexpfuncional set not null;
