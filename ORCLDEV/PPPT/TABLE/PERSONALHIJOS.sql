-- dmap_object_gen_tag : type : table name : personalhijos
set search_path = pppt,oracle,dmap_extension,public;
create table "personalhijos"  (
idhijo numeric(38) not null default 0,
idpersonal numeric(38),
nombre varchar(50),
sexo numeric(38),
dob timestamp(0),
ocupacion varchar(50)
) ;
-- dmap_object_gen_tag : type : alter table name : personalhijos
set search_path = pppt,oracle,dmap_extension,public;
alter table personalhijos alter column idhijo set not null;
