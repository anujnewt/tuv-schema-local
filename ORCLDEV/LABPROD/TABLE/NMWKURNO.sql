-- dmap_object_gen_tag : type : table name : nmwkurno
set search_path = labprod,oracle,dmap_extension,public;
create table "nmwkurno"  (
urn_keymen varchar(8),
urn_keycfg varchar(5),
urn_descfg varchar(30),
urn_keycia varchar(2),
urn_keypro numeric(10),
urn_keynom numeric(5),
urn_tablat varchar(2),
urn_keyper varchar(200),
urn_opcper varchar(1),
urn_ran001 varchar(200),
urn_ran002 varchar(200),
urn_tiprep varchar(1),
urn_meses varchar(40)
) ;
