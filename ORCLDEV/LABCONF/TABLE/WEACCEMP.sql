-- dmap_object_gen_tag : type : table name : weaccemp
set search_path = labconf,oracle,dmap_extension,public;
create table "weaccemp"  (
wea_idusua numeric(38) not null,
wea_keyemp varchar(50),
wea_clavea varchar(50),
wea_fecalt timestamp(0),
wea_idmenu numeric(38),
wea_estatu varchar(2)
) ;
-- dmap_object_gen_tag : type : alter table name : weaccemp
set search_path = labconf,oracle,dmap_extension,public;
alter table weaccemp add primary key (wea_idusua);
