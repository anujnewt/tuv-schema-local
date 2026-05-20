-- dmap_object_gen_tag : type : table name : weparmen
set search_path = labprod,oracle,dmap_extension,public;
create table "weparmen"  (
wep_cvemen numeric(38) not null,
wep_nommen varchar(20),
wep_status numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : weparmen
set search_path = labprod,oracle,dmap_extension,public;
alter table weparmen add primary key (wep_cvemen);
