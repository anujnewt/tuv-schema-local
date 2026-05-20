-- dmap_object_gen_tag : type : table name : cfdi2comprobantepro
set search_path = labconf,oracle,dmap_extension,public;
create table "cfdi2comprobantepro"  (
idcomprobantepro numeric(10) not null,
com_keypro numeric(5) not null,
com_keyper varchar(7) not null,
com_ejecut numeric(5) not null
) ;
-- dmap_object_gen_tag : type : alter table name : cfdi2comprobantepro
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2comprobantepro add constraint pk_cfdi2comprobantepro primary key (idcomprobantepro);
-- dmap_object_gen_tag : type : alter table name : cfdi2comprobantepro
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2comprobantepro alter column idcomprobantepro set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2comprobantepro
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2comprobantepro alter column com_keypro set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2comprobantepro
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2comprobantepro alter column com_keyper set not null;
-- dmap_object_gen_tag : type : alter table name : cfdi2comprobantepro
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdi2comprobantepro alter column com_ejecut set not null;
