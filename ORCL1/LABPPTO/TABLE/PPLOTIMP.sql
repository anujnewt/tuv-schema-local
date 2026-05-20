-- dmap_object_gen_tag : type : table name : pplotimp
set search_path = labppto,oracle,dmap_extension,public;
create table "pplotimp"  (
imp_keyver numeric(38) not null,
imp_keytab numeric(38) not null,
imp_keyren numeric(38) not null,
imp_valmin decimal(11,2) not null,
imp_valmax decimal(18,2) not null,
imp_cuofij decimal(11,2) not null,
imp_porexe decimal(11,3) not null
) ;
-- dmap_object_gen_tag : type : alter table name : pplotimp
set search_path = labppto,oracle,dmap_extension,public;
alter table pplotimp alter column imp_keyver set not null;
-- dmap_object_gen_tag : type : alter table name : pplotimp
set search_path = labppto,oracle,dmap_extension,public;
alter table pplotimp alter column imp_keytab set not null;
-- dmap_object_gen_tag : type : alter table name : pplotimp
set search_path = labppto,oracle,dmap_extension,public;
alter table pplotimp alter column imp_keyren set not null;
-- dmap_object_gen_tag : type : alter table name : pplotimp
set search_path = labppto,oracle,dmap_extension,public;
alter table pplotimp alter column imp_valmin set not null;
-- dmap_object_gen_tag : type : alter table name : pplotimp
set search_path = labppto,oracle,dmap_extension,public;
alter table pplotimp alter column imp_valmax set not null;
-- dmap_object_gen_tag : type : alter table name : pplotimp
set search_path = labppto,oracle,dmap_extension,public;
alter table pplotimp alter column imp_cuofij set not null;
-- dmap_object_gen_tag : type : alter table name : pplotimp
set search_path = labppto,oracle,dmap_extension,public;
alter table pplotimp alter column imp_porexe set not null;
