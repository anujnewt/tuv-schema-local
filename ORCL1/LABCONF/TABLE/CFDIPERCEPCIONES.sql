-- dmap_object_gen_tag : type : table name : cfdipercepciones
set search_path = labconf,oracle,dmap_extension,public;
create table "cfdipercepciones"  (
idcomprobanteemp numeric(38) not null,
com_keyemp numeric(38) not null,
com_keycon varchar(3),
tipopercepcion varchar(3) not null,
clave varchar(6) not null,
concepto varchar(100) not null,
importegravado decimal(18, 6) not null,
importeexento decimal(18, 6) not null
) ;
-- dmap_object_gen_tag : type : alter table name : cfdipercepciones
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdipercepciones alter column idcomprobanteemp set not null;
-- dmap_object_gen_tag : type : alter table name : cfdipercepciones
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdipercepciones alter column com_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : cfdipercepciones
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdipercepciones alter column tipopercepcion set not null;
-- dmap_object_gen_tag : type : alter table name : cfdipercepciones
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdipercepciones alter column clave set not null;
-- dmap_object_gen_tag : type : alter table name : cfdipercepciones
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdipercepciones alter column concepto set not null;
-- dmap_object_gen_tag : type : alter table name : cfdipercepciones
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdipercepciones alter column importegravado set not null;
-- dmap_object_gen_tag : type : alter table name : cfdipercepciones
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdipercepciones alter column importeexento set not null;
