-- dmap_object_gen_tag : type : table name : wesuperv
set search_path = labconf,oracle,dmap_extension,public;
create table "wesuperv"  (
sup_cvesup numeric(38) not null,
sup_keysup numeric(38) not null,
sup_keyemp numeric(38) not null
) ;
-- dmap_object_gen_tag : type : alter table name : wesuperv
set search_path = labconf,oracle,dmap_extension,public;
alter table wesuperv add primary key (sup_cvesup);
-- dmap_object_gen_tag : type : alter table name : wesuperv
set search_path = labconf,oracle,dmap_extension,public;
alter table wesuperv alter column sup_keysup set not null;
-- dmap_object_gen_tag : type : alter table name : wesuperv
set search_path = labconf,oracle,dmap_extension,public;
alter table wesuperv alter column sup_keyemp set not null;
