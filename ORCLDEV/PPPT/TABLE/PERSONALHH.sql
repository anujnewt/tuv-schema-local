-- dmap_object_gen_tag : type : table name : personalhh
set search_path = pppt,oracle,dmap_extension,public;
create table "personalhh"  (
idpersonal numeric(38) not null,
idedocivil numeric(38) default 0,
tel3 varchar(50),
tel4 varchar(50),
idpais numeric(38) default 0,
idciudad numeric(38) default 0,
idestado numeric(38) default 0,
sbm numeric,
bono numeric,
aguinaldo numeric,
reparto numeric,
fondoahorro numeric,
gastoscol numeric,
vacaciones numeric,
primavac numeric,
valesdesp numeric,
otros numeric,
acciones numeric(1) default 0,
segurovida numeric(1) default 0,
seguroac numeric(1) default 0,
segurogm numeric(1) default 0,
automovil numeric(1) default 0,
automovilma varchar(50),
opcioncompra numeric(1) default 0,
gastosauto numeric(1) default 0,
fecharegistro timestamp(0),
idformacontacto numeric(38) default 0,
gastosv numeric default 0,
sueldodeseado numeric(38) default 0,
idcalificativo numeric(38) default 0,
habilidades varchar(4000),
notaspersonales varchar(4000),
tlqqcynsdp varchar(4000) not null default ''
) ;
-- dmap_object_gen_tag : type : alter table name : personalhh
set search_path = pppt,oracle,dmap_extension,public;
alter table personalhh alter column idpersonal set not null;
-- dmap_object_gen_tag : type : alter table name : personalhh
set search_path = pppt,oracle,dmap_extension,public;
alter table personalhh alter column tlqqcynsdp set not null;
