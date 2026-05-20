-- dmap_object_gen_tag : type : table name : puestos
set search_path = pppt,oracle,dmap_extension,public;
create table "puestos"  (
idpuesto numeric(38) not null default 0,
puesto varchar(150),
nivel numeric(38),
idempresa numeric(38) default 0,
bateria numeric(1) default 0,
idnivel numeric(38),
notaperfil varchar(4000)
) ;
-- dmap_object_gen_tag : type : alter table name : puestos
set search_path = pppt,oracle,dmap_extension,public;
alter table puestos alter column idpuesto set not null;
