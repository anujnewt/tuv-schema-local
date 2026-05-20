-- dmap_object_gen_tag : type : table name : cfdiregimen
set search_path = labconf,oracle,dmap_extension,public;
create table "cfdiregimen"  (
idcomprobantepro numeric(38) not null,
regimen varchar(250)
) ;
-- dmap_object_gen_tag : type : alter table name : cfdiregimen
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdiregimen add constraint cfdiregimen_pk primary key (idcomprobantepro);
-- dmap_object_gen_tag : type : alter table name : cfdiregimen
set search_path = labconf,oracle,dmap_extension,public;
alter table cfdiregimen alter column idcomprobantepro set not null;
