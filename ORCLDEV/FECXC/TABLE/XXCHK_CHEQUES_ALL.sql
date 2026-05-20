-- dmap_object_gen_tag : type : table name : xxchk_cheques_all
set search_path = fecxc,oracle,dmap_extension,public;
create table "xxchk_cheques_all"  (
e_codigo numeric(38) not null,
no_folio_det numeric(38) not null,
id_status_mov varchar(2) not null,
id_banco numeric(38),
id_tipo_operacion_set numeric(38) not null,
fec_valor timestamp(0),
referencia_cliente varchar(50) not null,
id_chequera varchar(20),
concepto varchar(100),
tipo_cambio decimal(20, 4),
importe decimal(20, 2),
id_cheque_set numeric(38),
id_forma_pago numeric(38),
moneda varchar(3),
fec_valor_original timestamp(0) not null,
beneficiario varchar(60),
procesado numeric(38),
id_cheque_sel numeric(38),
chk_orden numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : xxchk_cheques_all
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_cheques_all add constraint pk_xxchk_cheques_all primary key (e_codigo,no_folio_det,id_status_mov);
-- dmap_object_gen_tag : type : alter table name : xxchk_cheques_all
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_cheques_all alter column e_codigo set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_cheques_all
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_cheques_all alter column no_folio_det set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_cheques_all
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_cheques_all alter column id_status_mov set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_cheques_all
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_cheques_all alter column id_tipo_operacion_set set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_cheques_all
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_cheques_all alter column referencia_cliente set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_cheques_all
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_cheques_all alter column fec_valor_original set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_cheques_all
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_cheques_all add constraint fk_xxchk_ch_fk_cheall_fecxc_em foreign key (e_codigo) references fecxc_empresas(e_codigo) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : xxchk_cheques_all
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_cheques_all add constraint fk_xxchk_ch_xxchk_ban_xxchk_ca foreign key (id_banco) references xxchk_catalogo_bancos(id_banco) on delete no action not deferrable initially immediate;
