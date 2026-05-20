-- dmap_object_gen_tag : type : table name : comparativo
set search_path = labppto,oracle,dmap_extension,public;
create table "comparativo"  (
id_comp numeric(10) not null,
cve_origen numeric(38) not null,
cve_mes numeric(38) not null,
cve_cia varchar(4) not null,
cve_virh varchar(10) not null,
cve_vicon varchar(10) not null,
cve_tpreg varchar(2) not null,
cve_ccrh varchar(16) not null,
cve_dptrh varchar(16) not null,
cve_dptcon varchar(16) not null,
cve_proc numeric(38) not null,
cve_empl numeric(38) not null,
tipo_emp varchar(6) not null,
cve_pue varchar(16) not null,
status varchar(1) not null,
cve_plaza numeric(38),
version numeric(38),
cve_anio numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : comparativo
set search_path = labppto,oracle,dmap_extension,public;
alter table comparativo alter column id_comp set not null;
-- dmap_object_gen_tag : type : alter table name : comparativo
set search_path = labppto,oracle,dmap_extension,public;
alter table comparativo alter column cve_origen set not null;
-- dmap_object_gen_tag : type : alter table name : comparativo
set search_path = labppto,oracle,dmap_extension,public;
alter table comparativo alter column cve_mes set not null;
-- dmap_object_gen_tag : type : alter table name : comparativo
set search_path = labppto,oracle,dmap_extension,public;
alter table comparativo alter column cve_cia set not null;
-- dmap_object_gen_tag : type : alter table name : comparativo
set search_path = labppto,oracle,dmap_extension,public;
alter table comparativo alter column cve_virh set not null;
-- dmap_object_gen_tag : type : alter table name : comparativo
set search_path = labppto,oracle,dmap_extension,public;
alter table comparativo alter column cve_vicon set not null;
-- dmap_object_gen_tag : type : alter table name : comparativo
set search_path = labppto,oracle,dmap_extension,public;
alter table comparativo alter column cve_tpreg set not null;
-- dmap_object_gen_tag : type : alter table name : comparativo
set search_path = labppto,oracle,dmap_extension,public;
alter table comparativo alter column cve_ccrh set not null;
-- dmap_object_gen_tag : type : alter table name : comparativo
set search_path = labppto,oracle,dmap_extension,public;
alter table comparativo alter column cve_dptrh set not null;
-- dmap_object_gen_tag : type : alter table name : comparativo
set search_path = labppto,oracle,dmap_extension,public;
alter table comparativo alter column cve_dptcon set not null;
-- dmap_object_gen_tag : type : alter table name : comparativo
set search_path = labppto,oracle,dmap_extension,public;
alter table comparativo alter column cve_proc set not null;
-- dmap_object_gen_tag : type : alter table name : comparativo
set search_path = labppto,oracle,dmap_extension,public;
alter table comparativo alter column cve_empl set not null;
-- dmap_object_gen_tag : type : alter table name : comparativo
set search_path = labppto,oracle,dmap_extension,public;
alter table comparativo alter column tipo_emp set not null;
-- dmap_object_gen_tag : type : alter table name : comparativo
set search_path = labppto,oracle,dmap_extension,public;
alter table comparativo alter column cve_pue set not null;
-- dmap_object_gen_tag : type : alter table name : comparativo
set search_path = labppto,oracle,dmap_extension,public;
alter table comparativo alter column status set not null;
