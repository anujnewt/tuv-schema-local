-- dmap_object_gen_tag : type : table name : xxchk_asoc_fact_cheq
set search_path = fecxc,oracle,dmap_extension,public;
create table "xxchk_asoc_fact_cheq"  (
id_sec_cheque numeric(38) not null,
customer_trx_id numeric(38) not null,
e_codigo numeric(38),
id_estado_cheque numeric(38),
monto decimal(20, 2),
moneda varchar(3),
tipo_cambio decimal(20, 4),
org_id numeric(38),
trx_number varchar(20),
no_cheque numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : xxchk_asoc_fact_cheq
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_asoc_fact_cheq add constraint pk_xxchk_asoc_fact_cheq primary key (id_sec_cheque,customer_trx_id);
-- dmap_object_gen_tag : type : alter table name : xxchk_asoc_fact_cheq
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_asoc_fact_cheq alter column id_sec_cheque set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_asoc_fact_cheq
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_asoc_fact_cheq alter column customer_trx_id set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_asoc_fact_cheq
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_asoc_fact_cheq add constraint fk_xxchk_as_fk_cheora_xxchk_ca foreign key (id_estado_cheque) references xxchk_cat_edos(id_estado_cheque) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : xxchk_asoc_fact_cheq
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_asoc_fact_cheq add constraint fk_xxchk_as_fk_chk_fa_fecxc_em foreign key (e_codigo) references fecxc_empresas(e_codigo) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : xxchk_asoc_fact_cheq
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_asoc_fact_cheq add constraint fk_xxchk_as_xxchk_che_xxchk_ca foreign key (id_sec_cheque) references xxchk_captura_cheques(id_sec_cheque) on delete no action not deferrable initially immediate;
