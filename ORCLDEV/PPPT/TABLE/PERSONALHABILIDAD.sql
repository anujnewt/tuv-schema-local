-- dmap_object_gen_tag : type : table name : personalhabilidad
set search_path = pppt,oracle,dmap_extension,public;
create table "personalhabilidad"  (
idpersonal numeric(38) not null,
idhabilidad numeric(38) not null,
dominio numeric default 0,
comentario varchar(250)
) ;
-- dmap_object_gen_tag : type : alter table name : personalhabilidad
set search_path = pppt,oracle,dmap_extension,public;
alter table personalhabilidad alter column idpersonal set not null;
-- dmap_object_gen_tag : type : alter table name : personalhabilidad
set search_path = pppt,oracle,dmap_extension,public;
alter table personalhabilidad alter column idhabilidad set not null;
