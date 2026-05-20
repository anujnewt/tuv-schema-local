-- dmap_object_gen_tag : type : table name : holohoex
set search_path = usrsiho,oracle,dmap_extension,public;
create table "holohoex"  (
hoe_pertra varchar(3) not null,
hoe_jornad varchar(2),
hoe_keytpr varchar(1),
hoe_jorcos decimal(13, 2),
hoe_jortie decimal(13, 2)
) ;
-- dmap_object_gen_tag : type : alter table name : holohoex
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holohoex alter column hoe_pertra set not null;
