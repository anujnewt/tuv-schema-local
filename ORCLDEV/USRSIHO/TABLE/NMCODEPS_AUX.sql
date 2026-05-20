-- dmap_object_gen_tag : type : table name : nmcodeps_aux
set search_path = usrsiho,oracle,dmap_extension,public;
create table "nmcodeps_aux"  (
dep_keydep varchar(16),
dep_desdep varchar(40),
dep_refcon varchar(20),
dep_keycen varchar(16),
dep_tipdep varchar(1),
dep_nu1aux varchar(10),
dep_nu2aux varchar(10),
dep_nu3aux varchar(10),
dep_nu4aux varchar(10),
dep_nu5aux varchar(10),
dep_ca1aux varchar(10),
dep_ca2aux varchar(10),
dep_ca3aux varchar(10),
dep_ca4aux varchar(10),
dep_ca5aux varchar(10)
) ;
