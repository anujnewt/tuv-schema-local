-- dmap_object_gen_tag : type : table name : pploorde
set search_path = labppto,oracle,dmap_extension,public;
create table "pploorde"  (
ord_keycia varchar(4) not null,
ord_keyver numeric(38) not null,
ord_keyemp numeric(38) not null,
ord_keymes numeric(38) not null
) ;
-- dmap_object_gen_tag : type : alter table name : pploorde
set search_path = labppto,oracle,dmap_extension,public;
alter table pploorde alter column ord_keycia set not null;
-- dmap_object_gen_tag : type : alter table name : pploorde
set search_path = labppto,oracle,dmap_extension,public;
alter table pploorde alter column ord_keyver set not null;
-- dmap_object_gen_tag : type : alter table name : pploorde
set search_path = labppto,oracle,dmap_extension,public;
alter table pploorde alter column ord_keyemp set not null;
-- dmap_object_gen_tag : type : alter table name : pploorde
set search_path = labppto,oracle,dmap_extension,public;
alter table pploorde alter column ord_keymes set not null;
