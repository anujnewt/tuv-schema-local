-- dmap_object_gen_tag : type : table name : comparativo
set search_path = labprod,oracle,dmap_extension,public;
create table "comparativo"  (
id_comp numeric(10),
cve_origen numeric(38),
cve_mes numeric(38),
cve_cia varchar(4),
cve_virh varchar(10),
cve_vicon varchar(10),
cve_tpreg varchar(2),
cve_ccrh varchar(16),
cve_dptrh varchar(16),
cve_dptcon varchar(16),
cve_proc numeric,
cve_empl numeric,
tipo_emp varchar(6),
cve_pue varchar(16),
status varchar(1),
cve_plaza numeric,
version numeric,
cve_anio numeric
) ;
