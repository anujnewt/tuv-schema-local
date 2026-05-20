-- dmap_object_gen_tag : type : table name : xxchk_captura_cheques
set search_path = fecxc,oracle,dmap_extension,public;
create table "xxchk_captura_cheques"  (
id_sec_cheque numeric(38) not null,
e_codigo numeric(38),
id_banco numeric(38),
id_estado_cheque numeric(38),
no_cheque numeric(38) not null,
referencia_cliente varchar(50),
id_cliente varchar(50) not null,
cheque_repuesto numeric(38),
no_cheque_reemplazo numeric(38),
fecha_emision timestamp(0) not null,
fecha_cobro timestamp(0),
date_created timestamp(0) not null default statement_timestamp(),
last_modified_date timestamp(0) default statement_timestamp(),
created_by varchar(30) not null,
modified_by varchar(30),
importe decimal(20, 2) not null,
moneda varchar(3) not null,
entregado_por varchar(30) not null,
expide varchar(50) not null,
imagen varchar(120) not null,
vencido numeric(38),
desc_cliente varchar(80),
procesado numeric(38),
id_banco_rep numeric(38),
folio varchar(30),
en_recibo_ar varchar(1)
) ;
-- dmap_object_gen_tag : type : alter table name : xxchk_captura_cheques
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_captura_cheques add constraint pk_xxchk_captura_cheques primary key (id_sec_cheque);
-- dmap_object_gen_tag : type : alter table name : xxchk_captura_cheques
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_captura_cheques alter column id_sec_cheque set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_captura_cheques
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_captura_cheques alter column no_cheque set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_captura_cheques
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_captura_cheques alter column id_cliente set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_captura_cheques
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_captura_cheques alter column fecha_emision set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_captura_cheques
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_captura_cheques alter column date_created set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_captura_cheques
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_captura_cheques alter column created_by set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_captura_cheques
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_captura_cheques alter column importe set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_captura_cheques
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_captura_cheques alter column moneda set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_captura_cheques
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_captura_cheques alter column entregado_por set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_captura_cheques
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_captura_cheques alter column expide set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_captura_cheques
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_captura_cheques alter column imagen set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_captura_cheques
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_captura_cheques add constraint fk_xxchk_ca_fk_cheque_xxchk_ca foreign key (id_estado_cheque) references xxchk_cat_edos(id_estado_cheque) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : xxchk_captura_cheques
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_captura_cheques add constraint fk_xxchk_ca_xxchk_ban_xxchk_ca foreign key (id_banco) references xxchk_catalogo_bancos(id_banco) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : xxchk_captura_cheques
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_captura_cheques add constraint fk_xxchk_chek_toempre foreign key (e_codigo) references fecxc_empresas(e_codigo) on delete no action not deferrable initially immediate;
