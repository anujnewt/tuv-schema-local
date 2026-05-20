-- dmap_object_gen_tag : type : table name : fecxp_presupuesto_soin
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_presupuesto_soin"  (
secuencia_presupuesto_soin numeric(38) not null,
secmoneda numeric(38),
periodo numeric(38),
prscod numeric(38),
mescod numeric(38),
moneda varchar(3),
arsmap varchar(3),
aejmap varchar(3),
cncmap varchar(3),
importe decimal(20, 2)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_presupuesto_soin
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_presupuesto_soin add constraint pk_fecxp_presupuesto_soin primary key (secuencia_presupuesto_soin);
-- dmap_object_gen_tag : type : alter table name : fecxp_presupuesto_soin
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_presupuesto_soin alter column secuencia_presupuesto_soin set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_presupuesto_soin
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_presupuesto_soin add constraint fk_fecxp_pr_moneda_de_fecxc_mo foreign key (secmoneda) references fecxc_monedas(secmoneda) on delete no action not deferrable initially immediate;
