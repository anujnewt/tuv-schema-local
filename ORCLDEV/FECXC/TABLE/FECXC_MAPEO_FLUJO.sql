-- dmap_object_gen_tag : type : table name : fecxc_mapeo_flujo
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxc_mapeo_flujo"  (
cod_sec_tipcat numeric(38) not null,
cod_sec_lin numeric(38) not null,
cod_sec_catclas numeric(38) not null,
cod_sec_det numeric(38) not null,
sec_concepto_tipocat numeric(38) not null,
sec_concepto_detcat numeric(38) not null,
sec_flujo_tipocat numeric(38) not null,
sec_flujo_detcat numeric(38) not null,
rel_contable varchar(40)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxc_mapeo_flujo
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_mapeo_flujo add constraint pk_fecxc_mapeo_flujo primary key (cod_sec_catclas,cod_sec_tipcat,cod_sec_lin,cod_sec_det,sec_concepto_tipocat,sec_concepto_detcat);
-- dmap_object_gen_tag : type : alter table name : fecxc_mapeo_flujo
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_mapeo_flujo alter column cod_sec_tipcat set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_mapeo_flujo
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_mapeo_flujo alter column cod_sec_lin set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_mapeo_flujo
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_mapeo_flujo alter column cod_sec_catclas set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_mapeo_flujo
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_mapeo_flujo alter column cod_sec_det set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_mapeo_flujo
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_mapeo_flujo alter column sec_concepto_tipocat set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_mapeo_flujo
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_mapeo_flujo alter column sec_concepto_detcat set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_mapeo_flujo
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_mapeo_flujo alter column sec_flujo_tipocat set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_mapeo_flujo
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_mapeo_flujo alter column sec_flujo_detcat set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_mapeo_flujo
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_mapeo_flujo add constraint fk_fecxc_ma_fk_mapfl__fecxc_de foreign key (cod_sec_catclas,cod_sec_det) references fecxc_det_clasfecxc(cod_sec_catclas,cod_sec_det) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : fecxc_mapeo_flujo
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_mapeo_flujo add constraint fk_fecxc_ma_flujo_cxc_fecxc_de foreign key (cod_sec_tipcat,cod_sec_lin) references fecxc_det_catalogos(cod_sec_tipcat,cod_sec_lin) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : fecxc_mapeo_flujo
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_mapeo_flujo add constraint fk_fecxc_ma_flujo_flu_fecxc_de foreign key (sec_flujo_tipocat,sec_flujo_detcat) references fecxc_det_catalogos(cod_sec_tipcat,cod_sec_lin) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : fecxc_mapeo_flujo
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_mapeo_flujo add constraint fk_map_concep_tipo_cat foreign key (sec_concepto_tipocat,sec_concepto_detcat) references fecxc_det_catalogos(cod_sec_tipcat,cod_sec_lin) on delete no action not deferrable initially immediate;
