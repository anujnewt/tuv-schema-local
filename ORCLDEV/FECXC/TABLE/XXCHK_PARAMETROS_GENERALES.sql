-- dmap_object_gen_tag : type : table name : xxchk_parametros_generales
set search_path = fecxc,oracle,dmap_extension,public;
create table "xxchk_parametros_generales"  (
antiguedad numeric not null,
rechazos_maximos numeric not null,
usuario_autoriza varchar(30) not null,
estado_inicial_chk numeric(38) not null,
edo_entregado_cli numeric(38) not null,
e_codigo varchar(10),
e_codigo_d varchar(75)
) ;
-- dmap_object_gen_tag : type : alter table name : xxchk_parametros_generales
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_parametros_generales alter column antiguedad set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_parametros_generales
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_parametros_generales alter column rechazos_maximos set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_parametros_generales
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_parametros_generales alter column usuario_autoriza set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_parametros_generales
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_parametros_generales alter column estado_inicial_chk set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_parametros_generales
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_parametros_generales alter column edo_entregado_cli set not null;
