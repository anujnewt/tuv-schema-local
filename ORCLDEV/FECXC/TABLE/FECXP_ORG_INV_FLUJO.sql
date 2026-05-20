-- dmap_object_gen_tag : type : table name : fecxp_org_inv_flujo
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_org_inv_flujo"  (
secuencia_org_fe numeric(38) not null,
organization_id numeric(38) not null,
cla_fe_id varchar(25) not null
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_org_inv_flujo
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_org_inv_flujo add constraint pk_fecxp_org_inv_flujo primary key (secuencia_org_fe,organization_id,cla_fe_id);
-- dmap_object_gen_tag : type : alter table name : fecxp_org_inv_flujo
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_org_inv_flujo alter column secuencia_org_fe set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_org_inv_flujo
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_org_inv_flujo alter column organization_id set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_org_inv_flujo
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_org_inv_flujo alter column cla_fe_id set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_org_inv_flujo
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_org_inv_flujo add constraint fk_fecxp_org_inv_flujo_fe foreign key (cla_fe_id) references fecxp_clasificacion_fe(cla_fe_id) on delete no action not deferrable initially immediate;
