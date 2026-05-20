-- dmap_object_gen_tag : type : table name : fecxc_enc_clasificados
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxc_enc_clasificados"  (
e_codigo numeric(38) not null,
cod_sec_clasifica numeric(38) not null,
secmoneda numeric(38),
codfolio numeric(38) not null,
f_ingreso timestamp(0) not null,
f_deposito timestamp(0) not null,
f_real_dep timestamp(0) not null default statement_timestamp(),
codcliente varchar(15),
tipocliente varchar(4),
refecliente varchar(10),
codbancoe numeric(20),
codbancor numeric(20),
numcheque varchar(20),
formapago varchar(10),
nchequera varchar(20),
concepto varchar(40) not null,
nom_bene varchar(255),
tipocambio numeric not null,
importe decimal(20, 2) not null,
usu_gest varchar(30) not null,
clasificado_xreg numeric(38),
anoplan2 numeric(38),
codcps2 varchar(30),
tipoplan varchar(10),
codoperacion numeric(38),
customer_id numeric(38),
fec_valor timestamp(0),
fec_valor_original timestamp(0),
id_estatus_mov varchar(1)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxc_enc_clasificados
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_enc_clasificados add constraint pk_fecxc_enc_clasificados primary key (e_codigo,cod_sec_clasifica);
-- dmap_object_gen_tag : type : alter table name : fecxc_enc_clasificados
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_enc_clasificados alter column e_codigo set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_enc_clasificados
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_enc_clasificados alter column cod_sec_clasifica set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_enc_clasificados
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_enc_clasificados alter column codfolio set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_enc_clasificados
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_enc_clasificados alter column f_ingreso set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_enc_clasificados
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_enc_clasificados alter column f_deposito set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_enc_clasificados
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_enc_clasificados alter column f_real_dep set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_enc_clasificados
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_enc_clasificados alter column concepto set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_enc_clasificados
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_enc_clasificados alter column tipocambio set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_enc_clasificados
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_enc_clasificados alter column importe set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_enc_clasificados
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_enc_clasificados alter column usu_gest set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_enc_clasificados
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_enc_clasificados add constraint fk_fecxc_en_empresa_e_fecxc_em foreign key (e_codigo) references fecxc_empresas(e_codigo) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : fecxc_enc_clasificados
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_enc_clasificados add constraint fk_fecxc_moneda foreign key (secmoneda) references fecxc_monedas(secmoneda) on delete no action not deferrable initially immediate;
