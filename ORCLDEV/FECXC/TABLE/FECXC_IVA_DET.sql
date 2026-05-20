-- dmap_object_gen_tag : type : table name : fecxc_iva_det
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxc_iva_det"  (
n_linea numeric not null,
porcent_iva numeric not null,
desc_iva varchar(500)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxc_iva_det
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_iva_det add constraint fecxc_iva_det_pk primary key (n_linea);
-- dmap_object_gen_tag : type : alter table name : fecxc_iva_det
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_iva_det alter column n_linea set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_iva_det
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_iva_det alter column porcent_iva set not null;
