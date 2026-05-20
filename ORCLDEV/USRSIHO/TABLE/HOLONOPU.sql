-- dmap_object_gen_tag : type : table name : holonopu
set search_path = usrsiho,oracle,dmap_extension,public;
create table "holonopu"  (
nop_keynom numeric(5) not null,
nop_keypue varchar(16) not null
) ;
-- dmap_object_gen_tag : type : alter table name : holonopu
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holonopu add constraint pk_hnopu primary key (nop_keynom,nop_keypue);
-- dmap_object_gen_tag : type : alter table name : holonopu
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holonopu alter column nop_keynom set not null;
-- dmap_object_gen_tag : type : alter table name : holonopu
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holonopu alter column nop_keypue set not null;
