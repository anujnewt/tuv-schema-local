-- dmap_object_gen_tag : type : table name : zz_test_tencas_t
set search_path = usrdrc,oracle,dmap_extension,public;
create table "zz_test_tencas_t"  (
id_row numeric(38),
id_parent varchar(40),
des_dato1 varchar(3000),
des_dato2 varchar(3000),
nom_empresa varchar(4000),
pad varchar(4000),
des_dato4 varchar(3000),
directo varchar(3000),
indirecto varchar(3000),
des_dato7 varchar(3000),
ten_casc_level numeric,
cant_hijos numeric,
consolida varchar(4000),
segmento varchar(4000),
clasificacion varchar(4000),
pais varchar(4000),
no_emp_oracle varchar(4000),
giro varchar(4000),
consolida_all char(1),
segmento_all char(1),
clasificacion_all char(1),
pais_all char(1),
no_emp_oracle_all char(1),
giro_all char(1)
) ;
