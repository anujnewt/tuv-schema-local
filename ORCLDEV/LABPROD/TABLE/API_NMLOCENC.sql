-- dmap_object_gen_tag : type : table name : api_nmlocenc
set search_path = labprod,oracle,dmap_extension,public;
create table "api_nmlocenc"  (
id_transaccion varchar(30) not null,
cen_keycen varchar(16) not null,
cen_descen varchar(40) not null,
cen_refcon varchar(20),
cen_nu1aux varchar(10),
cen_nu2aux varchar(10),
cen_nu3aux varchar(10),
cen_nu4aux varchar(10),
cen_nu5aux varchar(10),
cen_ca1aux varchar(10),
cen_ca2aux varchar(10),
cen_ca3aux varchar(10),
cen_ca4aux varchar(10),
cen_ca5aux varchar(10),
fecha_insert timestamp(0),
fecha_proc timestamp(0),
estatus varchar(10),
code varchar(150),
message varchar(255)
) ;
-- dmap_object_gen_tag : type : alter table name : api_nmlocenc
set search_path = labprod,oracle,dmap_extension,public;
alter table api_nmlocenc alter column id_transaccion set not null;
-- dmap_object_gen_tag : type : alter table name : api_nmlocenc
set search_path = labprod,oracle,dmap_extension,public;
alter table api_nmlocenc alter column cen_keycen set not null;
-- dmap_object_gen_tag : type : alter table name : api_nmlocenc
set search_path = labprod,oracle,dmap_extension,public;
alter table api_nmlocenc alter column cen_descen set not null;
