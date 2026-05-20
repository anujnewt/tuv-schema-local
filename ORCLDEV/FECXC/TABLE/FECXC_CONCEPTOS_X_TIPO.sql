-- dmap_object_gen_tag : type : table name : fecxc_conceptos_x_tipo
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxc_conceptos_x_tipo"  (
tipo_linea varchar(30) not null,
cod_sec_tipcat numeric(38) not null,
cod_sec_lin numeric(38) not null,
visible_siono varchar(2)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxc_conceptos_x_tipo
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_conceptos_x_tipo add constraint pk_fecxc_conceptos_x_tipo primary key (cod_sec_tipcat,tipo_linea,cod_sec_lin);
-- dmap_object_gen_tag : type : alter table name : fecxc_conceptos_x_tipo
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_conceptos_x_tipo add constraint ckc_tipo_linea_fecxc_co check (tipo_linea in ('IMPUESTO','BASE','OTROS','DNI','INTERCAMBIOS','COBVIRTUAL','RECLASIFICACIONES','TRASPASOS','OTROS_INGRESOS','INTERESES','FILLER_UNO','FILLER_DOS'));
-- dmap_object_gen_tag : type : alter table name : fecxc_conceptos_x_tipo
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_conceptos_x_tipo add constraint ckc_visible_siono_fecxc_co check (visible_siono is null or ( visible_siono in ('SI','NO') ));
-- dmap_object_gen_tag : type : alter table name : fecxc_conceptos_x_tipo
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_conceptos_x_tipo alter column tipo_linea set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_conceptos_x_tipo
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_conceptos_x_tipo alter column cod_sec_tipcat set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_conceptos_x_tipo
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_conceptos_x_tipo alter column cod_sec_lin set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_conceptos_x_tipo
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_conceptos_x_tipo add constraint fk_fecxc_co_conxtip_d_fecxc_de foreign key (cod_sec_tipcat,cod_sec_lin) references fecxc_det_catalogos(cod_sec_tipcat,cod_sec_lin) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : fecxc_conceptos_x_tipo
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_conceptos_x_tipo add constraint fk_fecxc_co_conxtip_t_fecxc_ti foreign key (tipo_linea) references fecxc_tipos_linea(tipo_linea) on delete no action not deferrable initially immediate;
