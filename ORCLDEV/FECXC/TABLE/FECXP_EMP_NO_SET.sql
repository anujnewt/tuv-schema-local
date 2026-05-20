-- dmap_object_gen_tag : type : table name : fecxp_emp_no_set
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_emp_no_set"  (
id_emp numeric not null,
desc_emp varchar(500),
tipo_empresa varchar(10),
id_emp_old numeric,
comentarios2 varchar(400),
comentarios varchar(400),
cambio_set_no_set varchar(1) default 'N'
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_emp_no_set
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_emp_no_set add primary key (id_emp);
-- dmap_object_gen_tag : type : alter table name : fecxp_emp_no_set
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_emp_no_set alter column id_emp set not null;
