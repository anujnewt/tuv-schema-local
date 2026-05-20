-- dmap_object_gen_tag : type : table name : fecxc_tpc
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxc_tpc"  (
sec_tpc numeric(38) not null,
secmoneda numeric(38),
fecha_tpc timestamp(0),
tipo_cambio decimal(20,11),
tipo_cambio_dls decimal(20,11)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxc_tpc
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_tpc add constraint pk_fecxc_tpc primary key (sec_tpc);
-- dmap_object_gen_tag : type : alter table name : fecxc_tpc
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_tpc alter column sec_tpc set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_tpc
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_tpc add constraint fk_fecxc_tp_tiposdeca_fecxc_mo foreign key (secmoneda) references fecxc_monedas(secmoneda) on delete no action not deferrable initially immediate;
