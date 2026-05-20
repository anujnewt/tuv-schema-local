-- dmap_object_gen_tag : type : table name : nmlocepro
set search_path = labprod,oracle,dmap_extension,public;
create table "nmlocepro"  (
cen_keycen varchar(16),
cen_descen varchar(60),
cen_refcon varchar(20),
cen_status varchar(3),
cen_nu1aux varchar(3),
cen_cia varchar(3),
cen_neg varchar(2),
cen_cta varchar(3)
) ;
