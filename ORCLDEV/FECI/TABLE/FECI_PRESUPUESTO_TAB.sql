-- dmap_object_gen_tag : type : table name : feci_presupuesto_tab
set search_path = feci,oracle,dmap_extension,public;
create table "feci_presupuesto_tab"  (
id_presupuesto  bigint generated always as identity  (start with 1 increment by 1  maxvalue 999999999999999999 minvalue 1 no cycle cache 20 ),
cod_segmento varchar(20) not null,
cod_concepto varchar(20) not null,
cod_region varchar(20),
cod_moneda varchar(20) not null,
fec_presupuesto timestamp(0) not null,
num_gestion numeric not null,
num_importe numeric not null,
fec_creacion timestamp(0) not null,
fec_ult_modificacion timestamp(0) not null,
id_usuario_creacion numeric not null,
id_usuario_ult_modif numeric not null,
ind_estado numeric not null
) ;
-- dmap_object_gen_tag : type : alter table name : feci_presupuesto_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_presupuesto_tab add constraint presupuesto_pk primary key (id_presupuesto);
-- dmap_object_gen_tag : type : alter table name : feci_presupuesto_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_presupuesto_tab alter column id_presupuesto set not null;
-- dmap_object_gen_tag : type : alter table name : feci_presupuesto_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_presupuesto_tab alter column cod_segmento set not null;
-- dmap_object_gen_tag : type : alter table name : feci_presupuesto_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_presupuesto_tab alter column cod_concepto set not null;
-- dmap_object_gen_tag : type : alter table name : feci_presupuesto_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_presupuesto_tab alter column cod_moneda set not null;
-- dmap_object_gen_tag : type : alter table name : feci_presupuesto_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_presupuesto_tab alter column fec_presupuesto set not null;
-- dmap_object_gen_tag : type : alter table name : feci_presupuesto_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_presupuesto_tab alter column num_gestion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_presupuesto_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_presupuesto_tab alter column num_importe set not null;
-- dmap_object_gen_tag : type : alter table name : feci_presupuesto_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_presupuesto_tab alter column fec_creacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_presupuesto_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_presupuesto_tab alter column fec_ult_modificacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_presupuesto_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_presupuesto_tab alter column id_usuario_creacion set not null;
-- dmap_object_gen_tag : type : alter table name : feci_presupuesto_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_presupuesto_tab alter column id_usuario_ult_modif set not null;
-- dmap_object_gen_tag : type : alter table name : feci_presupuesto_tab
set search_path = feci,oracle,dmap_extension,public;
alter table feci_presupuesto_tab alter column ind_estado set not null;
