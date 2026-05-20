-- dmap_object_gen_tag : type : table name : pptpomov
set search_path = labppto,oracle,dmap_extension,public;
create table "pptpomov"  (
tpo_keytpo numeric(38) not null,
tpo_destpo varchar(18) not null
) ;
-- dmap_object_gen_tag : type : alter table name : pptpomov
set search_path = labppto,oracle,dmap_extension,public;
alter table pptpomov alter column tpo_keytpo set not null;
-- dmap_object_gen_tag : type : alter table name : pptpomov
set search_path = labppto,oracle,dmap_extension,public;
alter table pptpomov alter column tpo_destpo set not null;
