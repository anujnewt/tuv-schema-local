-- dmap_object_gen_tag : type : table name : agrupxcod
set search_path = usrsiho,oracle,dmap_extension,public;
create table "agrupxcod"  (
xco_keypro numeric(5) not null,
xco_cvegpo varchar(3) not null,
xco_prefij varchar(3) not null
) ;
-- dmap_object_gen_tag : type : alter table name : agrupxcod
set search_path = usrsiho,oracle,dmap_extension,public;
alter table agrupxcod alter column xco_keypro set not null;
-- dmap_object_gen_tag : type : alter table name : agrupxcod
set search_path = usrsiho,oracle,dmap_extension,public;
alter table agrupxcod alter column xco_cvegpo set not null;
-- dmap_object_gen_tag : type : alter table name : agrupxcod
set search_path = usrsiho,oracle,dmap_extension,public;
alter table agrupxcod alter column xco_prefij set not null;
