-- dmap_object_gen_tag : type : table name : fecxc_emp_x_segmento
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxc_emp_x_segmento"  (
id_segmento numeric(38) not null,
e_codigo numeric(38) not null
) ;
-- dmap_object_gen_tag : type : alter table name : fecxc_emp_x_segmento
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_emp_x_segmento add constraint pk_fecxc_emp_x_segmento primary key (id_segmento,e_codigo);
-- dmap_object_gen_tag : type : alter table name : fecxc_emp_x_segmento
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_emp_x_segmento alter column id_segmento set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_emp_x_segmento
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_emp_x_segmento alter column e_codigo set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_emp_x_segmento
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_emp_x_segmento add constraint fk_fecxc_em_emp_x_seg_fecxc_em foreign key (e_codigo) references fecxc_empresas(e_codigo) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : fecxc_emp_x_segmento
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_emp_x_segmento add constraint fk_fecxc_em_segmento__fecxc_se foreign key (id_segmento) references fecxc_segmentos_flujo(id_segmento) on delete no action not deferrable initially immediate;
