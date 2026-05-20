-- dmap_object_gen_tag : type : table name : codeacont
set search_path = usrsiho,oracle,dmap_extension,public;
create table "codeacont"  (
con_keyemp varchar(12) not null,
con_fecven timestamp(0),
con_keyplz numeric(10),
con_fecoto timestamp(0)
) ;
-- dmap_object_gen_tag : type : alter table name : codeacont
set search_path = usrsiho,oracle,dmap_extension,public;
alter table codeacont alter column con_keyemp set not null;
