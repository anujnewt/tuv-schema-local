-- dmap_object_gen_tag : type : table name : fecxc_enc_impges
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxc_enc_impges"  (
e_codigo numeric(38) not null,
cod_sec_importa numeric(38) not null,
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
usu_gest varchar(30),
codcps varchar(30),
tipoplan varchar(10),
anoplan numeric(38),
codoperacion numeric(38),
customer_id numeric(38),
fec_valor timestamp(0),
fec_valor_original timestamp(0),
id_estatus_mov varchar(1)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxc_enc_impges
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_enc_impges add constraint pk_fecxc_enc_impges primary key (e_codigo,cod_sec_importa);
-- dmap_object_gen_tag : type : alter table name : fecxc_enc_impges
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_enc_impges alter column e_codigo set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_enc_impges
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_enc_impges alter column cod_sec_importa set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_enc_impges
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_enc_impges alter column codfolio set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_enc_impges
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_enc_impges alter column f_ingreso set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_enc_impges
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_enc_impges alter column f_deposito set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_enc_impges
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_enc_impges alter column f_real_dep set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_enc_impges
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_enc_impges alter column concepto set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_enc_impges
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_enc_impges alter column tipocambio set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_enc_impges
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_enc_impges alter column importe set not null;
-- dmap_object_gen_tag : type : alter table name : fecxc_enc_impges
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_enc_impges add constraint fk_fecxc_en_enc_det_i_fecxc_em foreign key (e_codigo) references fecxc_empresas(e_codigo) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : fecxc_enc_impges
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxc_enc_impges add constraint fk_fecxc_en_monmo foreign key (secmoneda) references fecxc_monedas(secmoneda) on delete no action not deferrable initially immediate;
