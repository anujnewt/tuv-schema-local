-- dmap_object_gen_tag : type : table name : fecxc_mapeo_fl_opera
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxc_mapeo_fl_opera"  (
cod_sec_tipcat numeric(38) not null,
cod_sec_lin numeric(38) not null,
id_tipo_operacion numeric(38) not null,
rel_contable varchar(40)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxc_mapeo_fl_opera
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_mapeo_fl_opera add constraint pk_fecxc_mapeo_fl_opera primary key (cod_sec_tipcat,cod_sec_lin,id_tipo_operacion);
-- dmap_object_gen_tag : type : alter table name : fecxc_mapeo_fl_opera
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_mapeo_fl_opera alter column cod_sec_tipcat set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_mapeo_fl_opera
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_mapeo_fl_opera alter column cod_sec_lin set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_mapeo_fl_opera
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_mapeo_fl_opera alter column id_tipo_operacion set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_mapeo_fl_opera
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_mapeo_fl_opera add constraint fk_fecxc_ma_flujo_ope_fecxc_de foreign key (cod_sec_tipcat,cod_sec_lin) references fecxc_det_catalogos(cod_sec_tipcat,cod_sec_lin) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : fecxc_mapeo_fl_opera
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_mapeo_fl_opera add constraint fk_fecxc_ma_flujo_vs__fecxc_op foreign key (id_tipo_operacion) references fecxc_operaciones_it(id_tipo_operacion) on delete no action not deferrable initially immediate;
