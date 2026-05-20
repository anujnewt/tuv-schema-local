-- dmap_object_gen_tag : type : table name : fecxp_referencias_flujo
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_referencias_flujo"  (
referencia_id numeric(38) not null,
referencia_des varchar(10) not null,
cla_fe_id varchar(25) not null
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_referencias_flujo
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_referencias_flujo alter column referencia_id set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_referencias_flujo
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_referencias_flujo alter column referencia_des set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_referencias_flujo
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_referencias_flujo alter column cla_fe_id set not null;
