-- dmap_object_gen_tag : type : table name : evaluacion
set search_path = pppt,oracle,dmap_extension,public;
create table "evaluacion"  (
idevaluacion numeric(38) not null default 0,
evaluacion varchar(100) not null,
idempresa numeric(38) not null default 0,
mincalificacion numeric(38) not null default 70,
maxminutos numeric(38) not null default 0,
activa numeric(1) not null default 1,
ordenpreguntas numeric(38) not null default 0,
modopreguntas numeric(38) not null default 0,
modocalificacion numeric(38) not null default 0,
navegacion numeric(38) not null default 0,
bmustanswer numeric(1) not null default 0,
bshowcal numeric(1) not null default 0,
brevision numeric(1) not null default 0,
bshowintro numeric(1) not null default 0,
introduccion varchar(4000)
) ;
-- dmap_object_gen_tag : type : alter table name : evaluacion
set search_path = pppt,oracle,dmap_extension,public;
alter table evaluacion alter column idevaluacion set not null;
-- dmap_object_gen_tag : type : alter table name : evaluacion
set search_path = pppt,oracle,dmap_extension,public;
alter table evaluacion alter column evaluacion set not null;
-- dmap_object_gen_tag : type : alter table name : evaluacion
set search_path = pppt,oracle,dmap_extension,public;
alter table evaluacion alter column idempresa set not null;
-- dmap_object_gen_tag : type : alter table name : evaluacion
set search_path = pppt,oracle,dmap_extension,public;
alter table evaluacion alter column mincalificacion set not null;
-- dmap_object_gen_tag : type : alter table name : evaluacion
set search_path = pppt,oracle,dmap_extension,public;
alter table evaluacion alter column maxminutos set not null;
-- dmap_object_gen_tag : type : alter table name : evaluacion
set search_path = pppt,oracle,dmap_extension,public;
alter table evaluacion alter column activa set not null;
-- dmap_object_gen_tag : type : alter table name : evaluacion
set search_path = pppt,oracle,dmap_extension,public;
alter table evaluacion alter column ordenpreguntas set not null;
-- dmap_object_gen_tag : type : alter table name : evaluacion
set search_path = pppt,oracle,dmap_extension,public;
alter table evaluacion alter column modopreguntas set not null;
-- dmap_object_gen_tag : type : alter table name : evaluacion
set search_path = pppt,oracle,dmap_extension,public;
alter table evaluacion alter column modocalificacion set not null;
-- dmap_object_gen_tag : type : alter table name : evaluacion
set search_path = pppt,oracle,dmap_extension,public;
alter table evaluacion alter column navegacion set not null;
-- dmap_object_gen_tag : type : alter table name : evaluacion
set search_path = pppt,oracle,dmap_extension,public;
alter table evaluacion alter column bmustanswer set not null;
-- dmap_object_gen_tag : type : alter table name : evaluacion
set search_path = pppt,oracle,dmap_extension,public;
alter table evaluacion alter column bshowcal set not null;
-- dmap_object_gen_tag : type : alter table name : evaluacion
set search_path = pppt,oracle,dmap_extension,public;
alter table evaluacion alter column brevision set not null;
-- dmap_object_gen_tag : type : alter table name : evaluacion
set search_path = pppt,oracle,dmap_extension,public;
alter table evaluacion alter column bshowintro set not null;
