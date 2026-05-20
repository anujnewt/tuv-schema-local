-- dmap_object_gen_tag : type : table name : cfdi2relacionados
set search_path = labprod,oracle,dmap_extension,public;
create table "cfdi2relacionados"  (
idcomprobanteemp numeric(10) not null,
rel_keypro numeric(5) not null,
rel_keyper varchar(7) not null,
rel_keyemp numeric(10) not null,
idcomprobanteemp_ori numeric(10) not null,
tiporelacion varchar(2) not null,
rel_uuid varchar(36)
) ;
-- dmap_object_gen_tag : type : alter table name : cfdi2relacionados
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdi2relacionados alter column idcomprobanteemp set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2relacionados
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdi2relacionados alter column rel_keypro set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2relacionados
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdi2relacionados alter column rel_keyper set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2relacionados
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdi2relacionados alter column rel_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2relacionados
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdi2relacionados alter column idcomprobanteemp_ori set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2relacionados
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdi2relacionados alter column tiporelacion set not null;
