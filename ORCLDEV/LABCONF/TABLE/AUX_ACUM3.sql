-- dmap_object_gen_tag : type : table name : aux_acum3
set search_path = labconf,oracle,dmap_extension,public;
create table "aux_acum3"  (
keyemp numeric(38) not null,
keycon char(16) not null,
cantid decimal(16, 2),
import decimal(16, 2),
keypro numeric(38),
keyper char(7)
) ;
-- dmap_object_gen_tag : type : alter table name : aux_acum3
set search_path = labconf,oracle,dmap_extension,public;
alter table aux_acum3 alter column keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : aux_acum3
set search_path = labconf,oracle,dmap_extension,public;
alter table aux_acum3 alter column keycon set not null;
