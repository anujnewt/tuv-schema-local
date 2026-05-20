-- dmap_object_gen_tag : type : table name : xxper_sipros_nmlocenc
set search_path = labconf,oracle,dmap_extension,public;
create table "xxper_sipros_nmlocenc"  (
cen_keycen varchar(60),
cen_descen varchar(240),
cen_refcon varchar(120),
cen_nu1aux varchar(10),
cen_nu2aux varchar(10),
cen_nu3aux varchar(10),
cen_nu4aux varchar(10),
cen_nu5aux varchar(10),
cen_ca1aux varchar(10),
cen_ca2aux varchar(10),
cen_ca3aux varchar(60),
cen_ca4aux varchar(60),
cen_ca5aux varchar(10),
ora_system varchar(30),
ora_transaction varchar(30),
ora_date timestamp(0),
ora_secuencia numeric,
ora_status varchar(2)
) ;
