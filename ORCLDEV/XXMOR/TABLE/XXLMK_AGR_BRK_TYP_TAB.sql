-- dmap_object_gen_tag : type : table name : xxlmk_agr_brk_typ_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_agr_brk_typ_tab"  (
id_agr_brk_typ numeric(38) not null,
des_prefijo varchar(100),
des_break_type varchar(5),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100),
id_agrupador_psp numeric(38) not null
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_agr_brk_typ_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_agr_brk_typ_tab add primary key (id_agr_brk_typ);
-- dmap_object_gen_tag : type : alter table name : xxlmk_agr_brk_typ_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_agr_brk_typ_tab alter column id_agr_brk_typ set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_agr_brk_typ_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_agr_brk_typ_tab alter column id_agrupador_psp set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_agr_brk_typ_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_agr_brk_typ_tab add constraint xxlmkagrbrktyptab_fk1 foreign key (id_agrupador_psp) references xxlmk_agrupadores_psp_tab(id_agrupador_psp) on delete no action not deferrable initially immediate;
