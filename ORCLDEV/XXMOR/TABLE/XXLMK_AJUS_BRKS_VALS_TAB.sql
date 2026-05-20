-- dmap_object_gen_tag : type : table name : xxlmk_ajus_brks_vals_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_ajus_brks_vals_tab"  (
id_ajuste_breaks numeric(38) not null,
id_canal numeric(38) not null,
num_break numeric(38) not null,
num_brek_nom_time numeric(38),
num_capacidad_ini numeric(38),
num_venta numeric(38),
num_ajuste numeric(38),
num_filler numeric(38),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100),
num_break_base numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_ajus_brks_vals_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_ajus_brks_vals_tab add primary key (id_ajuste_breaks,id_canal,num_break);
-- dmap_object_gen_tag : type : alter table name : xxlmk_ajus_brks_vals_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_ajus_brks_vals_tab alter column id_ajuste_breaks set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_ajus_brks_vals_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_ajus_brks_vals_tab alter column id_canal set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_ajus_brks_vals_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_ajus_brks_vals_tab alter column num_break set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_ajus_brks_vals_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_ajus_brks_vals_tab add constraint xxlmkajusbrksvalstab_fk1 foreign key (id_ajuste_breaks,id_canal) references xxlmk_ajus_brks_canales_tab(id_ajuste_breaks,id_canal) on delete no action not deferrable initially immediate;
