-- dmap_object_gen_tag : type : table name : fecxc_iva
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxc_iva"  (
id_iva numeric not null,
porcent_iva numeric not null,
desc_iva varchar(500)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxc_iva
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_iva add constraint fecxc_iva_pk primary key (id_iva,porcent_iva);
-- dmap_object_gen_tag : type : alter table name : fecxc_iva
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_iva alter column id_iva set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_iva
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_iva alter column porcent_iva set not null;
