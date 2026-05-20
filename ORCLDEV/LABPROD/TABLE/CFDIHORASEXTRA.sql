-- dmap_object_gen_tag : type : table name : cfdihorasextra
set search_path = labprod,oracle,dmap_extension,public;
create table "cfdihorasextra"  (
idcomprobanteemp numeric(38) not null,
com_keyemp numeric(38) not null,
dias numeric(38) not null,
tipohoras varchar(10) not null,
horasextra decimal(18, 6) not null,
importepagado decimal(18, 6) not null
) ;
-- dmap_object_gen_tag : type : alter table name : cfdihorasextra
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdihorasextra alter column idcomprobanteemp set not null;
-- dmap_object_gen_tag : type : alter table name : cfdihorasextra
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdihorasextra alter column com_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : cfdihorasextra
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdihorasextra alter column dias set not null;
-- dmap_object_gen_tag : type : alter table name : cfdihorasextra
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdihorasextra alter column tipohoras set not null;
-- dmap_object_gen_tag : type : alter table name : cfdihorasextra
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdihorasextra alter column horasextra set not null;
-- dmap_object_gen_tag : type : alter table name : cfdihorasextra
set search_path = labprod,oracle,dmap_extension,public;
alter table cfdihorasextra alter column importepagado set not null;
