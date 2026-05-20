-- dmap_object_gen_tag : type : table name : interpretacion
set search_path = pppt,oracle,dmap_extension,public;
create table "interpretacion"  (
idinterpretacion numeric(38) not null default 0,
idprueba numeric(38),
patron varchar(10),
nombre varchar(50),
tipo numeric(38),
interpretacion varchar(4000)
) ;
-- dmap_object_gen_tag : type : alter table name : interpretacion
set search_path = pppt,oracle,dmap_extension,public;
alter table interpretacion alter column idinterpretacion set not null;
