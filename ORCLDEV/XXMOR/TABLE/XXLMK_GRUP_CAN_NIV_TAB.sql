-- dmap_object_gen_tag : type : table name : xxlmk_grup_can_niv_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_grup_can_niv_tab"  (
id_grupo numeric(38) not null,
id_canal numeric(38) not null,
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_grup_can_niv_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_grup_can_niv_tab add primary key (id_grupo,id_canal);
-- dmap_object_gen_tag : type : alter table name : xxlmk_grup_can_niv_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_grup_can_niv_tab alter column id_grupo set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_grup_can_niv_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_grup_can_niv_tab alter column id_canal set not null;
-- dmap_object_gen_tag : type : alter table name : xxlmk_grup_can_niv_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_grup_can_niv_tab add constraint xxlmkgrupcanmaptab_fk1 foreign key (id_grupo) references xxlmk_grupos_canales_tab(id_grupo) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : xxlmk_grup_can_niv_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_grup_can_niv_tab add constraint xxlmkgrupcanmaptab_fk2 foreign key (id_canal) references xxlmk_canales_lmk_tab(id_canal) on delete no action not deferrable initially immediate;
