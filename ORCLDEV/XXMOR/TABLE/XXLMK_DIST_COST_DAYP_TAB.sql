-- dmap_object_gen_tag : type : table name : xxlmk_dist_cost_dayp_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_dist_cost_dayp_tab"  (
id_ordhdr numeric(38) not null,
des_canal varchar(5) not null,
des_franja varchar(3) not null,
des_dias varchar(2) not null,
num_porc numeric,
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_dist_cost_dayp_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_dist_cost_dayp_tab add primary key (id_ordhdr,des_canal,des_franja,des_dias);
-- dmap_object_gen_tag : type : alter table name : xxlmk_dist_cost_dayp_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_dist_cost_dayp_tab alter column id_ordhdr set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_dist_cost_dayp_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_dist_cost_dayp_tab add constraint xxlmkdistcostdayptab_fk1 foreign key (id_ordhdr) references xxlmk_ordhdr_tab(id_ordhdr) on delete no action not deferrable initially immediate;
