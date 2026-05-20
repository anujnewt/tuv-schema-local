-- dmap_object_gen_tag : type : table name : xxlmk_canales_lmk_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_canales_lmk_tab"  (
id_canal numeric(38) not null,
des_can_psp varchar(100),
num_can_lmk numeric(38),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100),
cve_sales_area varchar(50),
id_agrupador_psp numeric(38),
ind_activo numeric(38),
ind_nivel numeric(38),
id_canal_network numeric(38),
num_duracion numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_canales_lmk_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_canales_lmk_tab add primary key (id_canal);
-- dmap_object_gen_tag : type : alter table name : xxlmk_canales_lmk_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_canales_lmk_tab add constraint xxlmkcanaleslmktab_fk1 foreign key (id_agrupador_psp) references xxlmk_agrupadores_psp_tab(id_agrupador_psp) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : xxlmk_canales_lmk_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_canales_lmk_tab add constraint xxlmkcanaleslmktab_fk2 foreign key (id_canal_network) references xxlmk_canales_lmk_tab(id_canal) on delete no action not deferrable initially immediate;
