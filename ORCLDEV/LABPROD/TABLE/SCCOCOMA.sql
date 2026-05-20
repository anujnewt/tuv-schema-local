-- dmap_object_gen_tag : type : table name : sccocoma
set search_path = labprod,oracle,dmap_extension,public;
create table "sccocoma"  (
id numeric(38) not null,
com_keyusu numeric(38),
com_keypro numeric(38),
com_keyper varchar(7),
com_keyplz numeric(38),
com_keyemp numeric(38),
com_keydep varchar(16),
com_keypue varchar(16),
com_keycen varchar(16),
com_keycat varchar(16),
com_keyloc varchar(16),
com_keyims varchar(5),
com_tipemp varchar(6),
com_ca1aux varchar(10),
com_ca2aux varchar(10),
com_ca3aux varchar(10),
com_ca4aux varchar(10),
com_reserv varchar(1),
com_codocu varchar(6),
com_salcon decimal(16, 6),
com_limocu timestamp(0),
com_fecmov timestamp(0),
com_fecims timestamp(0),
com_tipmov varchar(6),
com_feccap timestamp(0),
com_horcap varchar(8),
com_status varchar(2) not null,
com_fecapl timestamp(0),
com_horapl varchar(8),
com_usuapl numeric(38),
com_keyerr varchar(2)
) ;
-- dmap_object_gen_tag : type : alter table name : sccocoma
set search_path = labprod,oracle,dmap_extension,public;
alter table sccocoma add constraint scocoma_pk primary key (id);
-- dmap_object_gen_tag : type : alter table name : sccocoma
set search_path = labprod,oracle,dmap_extension,public;
alter table sccocoma alter column com_status set not null;
