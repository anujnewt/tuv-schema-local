-- dmap_object_gen_tag : type : table name : xxper_sipros_nmcodeps
set search_path = labconf,oracle,dmap_extension,public;
create table "xxper_sipros_nmcodeps"  (
dep_keydep varchar(240),
dep_desdep varchar(240),
dep_refcnm varchar(60),
dep_refcnh varchar(60),
dep_keycen varchar(10),
dep_tipdep varchar(150),
dep_nu1aux varchar(10),
dep_nu2aux varchar(10),
dep_nu3aux varchar(10),
dep_nu4aux varchar(10),
dep_nu5aux varchar(10),
dep_ca1aux varchar(10),
dep_ca2aux varchar(10),
dep_ca3aux varchar(60),
dep_ca4aux varchar(60),
dep_ca5aux varchar(10),
ora_system varchar(30),
ora_transaction varchar(30),
ora_date timestamp(0),
ora_secuencia numeric,
ora_status varchar(2)
) ;
