-- dmap_object_gen_tag : type : table name : nmlocepro
set search_path = labconf,oracle,dmap_extension,public;
create table "nmlocepro"  (
cen_keycen varchar(16) not null,
cen_descen varchar(40),
cen_refcon varchar(20),
cen_status varchar(3),
cen_nu1aux varchar(3)
) ;
-- dmap_object_gen_tag : type : alter table name : nmlocepro
set search_path = labconf,oracle,dmap_extension,public;
alter table nmlocepro add primary key (cen_keycen);
