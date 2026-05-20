-- dmap_object_gen_tag : type : table name : ccm001
set search_path = fecxc,oracle,dmap_extension,public;
create table "ccm001"  (
moncod char(2) not null,
mondes varchar(40),
montpc numeric,
montpv numeric not null,
monfca varchar(8),
monusr varchar(8),
monimp varchar(3),
monvtc numeric,
timestamp timestamp
) ;
-- dmap_object_gen_tag : type : alter table name : ccm001
set search_path = fecxc,oracle,dmap_extension,public;
alter table ccm001 add primary key (moncod);
-- dmap_object_gen_tag : type : alter table name : ccm001
set search_path = fecxc,oracle,dmap_extension,public;
alter table ccm001 alter column moncod set not null;
-- dmap_object_gen_tag : type : alter table name : ccm001
set search_path = fecxc,oracle,dmap_extension,public;
alter table ccm001 alter column montpv set not null;
