-- dmap_object_gen_tag : type : table name : xxlmk_grupos_canales_tab
set search_path = xxmor,oracle,dmap_extension,public;
create table "xxlmk_grupos_canales_tab"  (
id_grupo numeric(38) not null,
num_duracion numeric(38),
fec_creacion timestamp(0),
cve_creado_por varchar(100),
fec_actualizacion timestamp(0),
cve_actualizado_por varchar(100),
nom_grupo varchar(20)
) ;
-- dmap_object_gen_tag : type : alter table name : xxlmk_grupos_canales_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_grupos_canales_tab add primary key (id_grupo);
-- dmap_object_gen_tag : type : alter table name : xxlmk_grupos_canales_tab
set search_path = xxmor,oracle,dmap_extension,public;
alter table xxlmk_grupos_canales_tab alter column id_grupo set not null;
