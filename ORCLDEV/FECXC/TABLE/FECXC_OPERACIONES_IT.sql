-- dmap_object_gen_tag : type : table name : fecxc_operaciones_it
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxc_operaciones_it"  (
id_tipo_operacion numeric(38) not null,
tipo_operacion varchar(30)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxc_operaciones_it
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_operaciones_it add constraint pk_fecxc_operaciones_it primary key (id_tipo_operacion);
-- dmap_object_gen_tag : type : alter table name : fecxc_operaciones_it
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_operaciones_it add constraint ckc_tipo_operacion_fecxc_op check (tipo_operacion is null or ( tipo_operacion in ('COBRANZA','OTROSINGRE','DNI','INTEREMPRESAS','SBUENCOBRO','EGRESO') ));
-- dmap_object_gen_tag : type : alter table name : fecxc_operaciones_it
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_operaciones_it alter column id_tipo_operacion set not null;
