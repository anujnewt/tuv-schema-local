-- dmap_object_gen_tag : type : table name : cfdi2nominaemisor
set search_path = labconf,oracle,dmap_extension,public;
create table "cfdi2nominaemisor"  (
idcomprobanteemp numeric(10) not null,
curp varchar(18),
registropatronal varchar(20),
rfcpatronorigen varchar(13),
origenrecurso varchar(2),
montorecursopropio decimal(18, 2)
) ;
-- dmap_object_gen_tag : type : alter table name : cfdi2nominaemisor
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2nominaemisor add constraint pk_cfdi2nominaemisor primary key (idcomprobanteemp);
-- dmap_object_gen_tag : type : alter table name : cfdi2nominaemisor
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2nominaemisor alter column idcomprobanteemp set not null;
