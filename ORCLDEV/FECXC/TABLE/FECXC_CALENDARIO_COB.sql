-- dmap_object_gen_tag : type : table name : fecxc_calendario_cob
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxc_calendario_cob"  (
anio_cobranza numeric(38) not null,
mes_cobranza numeric(38) not null,
fecha_inicio timestamp(0) not null,
fecha_fin timestamp(0) not null
) ;
-- dmap_object_gen_tag : type : alter table name : fecxc_calendario_cob
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_calendario_cob add constraint pk_fecxc_calendario_cob primary key (anio_cobranza,mes_cobranza);
-- dmap_object_gen_tag : type : alter table name : fecxc_calendario_cob
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_calendario_cob add constraint ckc_mes_cobranza_fecxc_ca check (mes_cobranza between 1 and 12 and mes_cobranza in (1,2,3,4,5,6,7,8,9,10,11,12));
-- dmap_object_gen_tag : type : alter table name : fecxc_calendario_cob
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_calendario_cob alter column anio_cobranza set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_calendario_cob
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_calendario_cob alter column mes_cobranza set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_calendario_cob
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_calendario_cob alter column fecha_inicio set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_calendario_cob
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_calendario_cob alter column fecha_fin set not null;
