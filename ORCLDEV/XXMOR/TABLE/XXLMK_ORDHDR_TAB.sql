-- dmap_object_gen_tag : type : table name : xxlmk_ordhdr_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_ordhdr_tab"  (
id_ordhdr numeric not null,
id_seg_neg numeric,
id_archivo numeric,
ind_proc_x_lin varchar(2),
ind_garantizado varchar(10),
cve_advid varchar(20),
cve_mcontid varchar(30),
cve_mcont_cutin varchar(30),
des_email varchar(4000),
des_ref_folio varchar(50),
cve_agyestnum varchar(50),
cve_accthdrid varchar(50),
des_rtcrd varchar(50),
des_rtcrd_cutin varchar(50),
des_coment varchar(200),
des_secnum varchar(20),
des_plat_canal varchar(20),
id_prddes varchar(50),
num_total_spts numeric,
can_tot_sin_desc numeric,
can_tot_con_desc numeric,
des_tip_factur varchar(50),
can_desc numeric,
des_target varchar(50),
cve_modulo varchar(200),
num_ord_agen varchar(50),
des_targ_afin varchar(50),
des_tipo_serv varchar(200),
ind_kids varchar(5),
ind_fav_lo_mejor varchar(5),
num_grps_totales numeric,
num_ejecucion numeric,
des_tipo_orden varchar(50),
des_version_fich varchar(50),
fec_creacion timestamp(0),
cve_creado_por varchar(50),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(50),
can_inversion_total numeric,
ind_tipo_orden numeric,
ind_estatus numeric,
des_agrupador varchar(10),
id_fza_ventas numeric,
ind_subtipo_ord numeric,
id_deal numeric(38),
des_marca_prod varchar(500)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_ordhdr_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_ordhdr_tab add constraint xxlmk_ordhdr_tab_pk primary key (id_ordhdr);
-- dmap_object_gen_tag : type : alter table name : xxlmk_ordhdr_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_ordhdr_tab alter column id_ordhdr set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_ordhdr_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_ordhdr_tab add constraint xxlmk_ordhdr_tab_fk1 foreign key (id_archivo) references xxlmk_archivos_sol_tab(id_archivo_sol) on delete no action not deferrable initially immediate;
