-- dmap_object_gen_tag : type : table name : tmp_xxchk_asoc_fact_cheq
set search_path = fecxc,oracle,dmap_extension,public;
create table "tmp_xxchk_asoc_fact_cheq"  (
id_sec_cheque numeric(38) not null,
customer_trx_id numeric(38) not null,
e_codigo numeric(38),
monto decimal(20, 2),
moneda varchar(3),
tipo_cambio decimal(20, 4),
org_id numeric(38),
trx_number varchar(20)
) ;
-- dmap_object_gen_tag : type : alter table name : tmp_xxchk_asoc_fact_cheq
set search_path = fecxc,oracle,dmap_extension,public;
alter table tmp_xxchk_asoc_fact_cheq alter column id_sec_cheque set not null;
-- dmap_object_gen_tag : type : alter table name : tmp_xxchk_asoc_fact_cheq
set search_path = fecxc,oracle,dmap_extension,public;
alter table tmp_xxchk_asoc_fact_cheq alter column customer_trx_id set not null;
