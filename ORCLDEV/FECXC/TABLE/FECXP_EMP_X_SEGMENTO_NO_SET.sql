-- dmap_object_gen_tag : type : table name : fecxp_emp_x_segmento_no_set
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_emp_x_segmento_no_set"  (
id_segmento numeric(38) not null,
e_codigo numeric(38) not null,
tipo_empresa varchar(10)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_emp_x_segmento_no_set
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_emp_x_segmento_no_set add constraint pk_fecxp_emp_x_segmento_no_set primary key (id_segmento,e_codigo);
-- dmap_object_gen_tag : type : alter table name : fecxp_emp_x_segmento_no_set
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_emp_x_segmento_no_set alter column id_segmento set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_emp_x_segmento_no_set
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_emp_x_segmento_no_set alter column e_codigo set not null;
