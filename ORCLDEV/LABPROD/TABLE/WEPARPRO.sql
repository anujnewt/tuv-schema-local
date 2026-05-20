-- dmap_object_gen_tag : type : table name : weparpro
set search_path = labprod,oracle,dmap_extension,public;
create table "weparpro"  (
pro_cvepro numeric(38) not null,
pro_nompro varchar(40),
pro_tippro numeric(38),
pro_urlpro varchar(40),
pro_icopro varchar(40)
) ;
-- dmap_object_gen_tag : type : alter table name : weparpro
set search_path = labprod,oracle,dmap_extension,public;
alter table weparpro add primary key (pro_cvepro);
