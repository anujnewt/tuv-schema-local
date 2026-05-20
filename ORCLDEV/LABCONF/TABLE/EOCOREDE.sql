-- dmap_object_gen_tag : type : table name : eocorede
set search_path = labconf,oracle,dmap_extension,public;
create table "eocorede"  (
red_keyest varchar(3) not null,
red_paddep varchar(16),
red_hijdep varchar(16) not null,
red_codniv varchar(80) not null,
red_pesesp numeric(5),
red_numniv numeric(5)
) ;
-- dmap_object_gen_tag : type : alter table name : eocorede
set search_path = labconf,oracle,dmap_extension,public;
alter table eocorede alter column red_keyest set not null;
-- dmap_object_gen_tag : type : alter table name : eocorede
set search_path = labconf,oracle,dmap_extension,public;
alter table eocorede alter column red_hijdep set not null;
-- dmap_object_gen_tag : type : alter table name : eocorede
set search_path = labconf,oracle,dmap_extension,public;
alter table eocorede alter column red_codniv set not null;
