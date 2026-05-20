-- dmap_object_gen_tag : type : table name : xxchk_cat_cambios_estado
set search_path = fecxc,oracle,dmap_extension,public;
create table "xxchk_cat_cambios_estado"  (
id_estado_cheque numeric(38) not null,
id_estado_b numeric(38) not null,
descripcion varchar(100) not null
) ;
-- dmap_object_gen_tag : type : alter table name : xxchk_cat_cambios_estado
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_cat_cambios_estado add constraint pk_xxchk_cat_cambios_estado primary key (id_estado_cheque,id_estado_b);
-- dmap_object_gen_tag : type : alter table name : xxchk_cat_cambios_estado
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_cat_cambios_estado alter column id_estado_cheque set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_cat_cambios_estado
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_cat_cambios_estado alter column id_estado_b set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_cat_cambios_estado
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_cat_cambios_estado alter column descripcion set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_cat_cambios_estado
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_cat_cambios_estado add constraint fk_xxchk_ca_fk_cambio_xxchk_ca foreign key (id_estado_cheque) references xxchk_cat_edos(id_estado_cheque) on delete no action not deferrable initially immediate;
