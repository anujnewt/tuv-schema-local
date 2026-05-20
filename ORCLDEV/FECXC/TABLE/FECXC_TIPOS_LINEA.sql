-- dmap_object_gen_tag : type : table name : fecxc_tipos_linea
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxc_tipos_linea"  (
tipo_linea varchar(30) not null,
visible_siono varchar(2)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxc_tipos_linea
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_tipos_linea add constraint pk_fecxc_tipos_linea primary key (tipo_linea);
-- dmap_object_gen_tag : type : alter table name : fecxc_tipos_linea
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_tipos_linea add constraint ckc_tipo_linea_fecxc_ti check (tipo_linea in ('IMPUESTO','BASE','OTROS','DNI','INTERCAMBIOS','COBVIRTUAL','RECLASIFICACIONES','TRASPASOS','OTROS_INGRESOS','INTERESES','FILLER_UNO','FILLER_DOS'));
-- dmap_object_gen_tag : type : alter table name : fecxc_tipos_linea
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_tipos_linea add constraint ckc_visible_siono_fecxc_ti check (visible_siono is null or ( visible_siono in ('SI','NO') ));
-- dmap_object_gen_tag : type : alter table name : fecxc_tipos_linea
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_tipos_linea alter column tipo_linea set not null;
