-- dmap_object_gen_tag : type : table name : holodear
set search_path = usrsiho,oracle,dmap_extension,public;
create table "holodear"  (
dea_keydep varchar(16) not null,
dea_keyapr varchar(6) not null
) ;
-- dmap_object_gen_tag : type : alter table name : holodear
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holodear add constraint pk_hdear primary key (dea_keydep,dea_keyapr);
-- dmap_object_gen_tag : type : alter table name : holodear
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holodear alter column dea_keydep set not null;
-- dmap_object_gen_tag : type : alter table name : holodear
set search_path = usrsiho,oracle,dmap_extension,public;
alter table holodear alter column dea_keyapr set not null;
