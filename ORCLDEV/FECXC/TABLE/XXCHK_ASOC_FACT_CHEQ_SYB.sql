-- dmap_object_gen_tag : type : table name : xxchk_asoc_fact_cheq_syb
set search_path = fecxc,oracle,dmap_extension,public;
create table "xxchk_asoc_fact_cheq_syb"  (
id_sec_cheque numeric(38) not null,
fam01cod varchar(4) not null,
fax01ntr numeric(38) not null,
facdoc varchar(15) not null,
id_estado_cheque numeric(38),
e_codigo numeric(38),
clinom varchar(50),
clicod varchar(15),
monto decimal(20, 2),
moneda varchar(3),
tipo_cambio decimal(20, 4),
depref varchar(22) not null,
empresa_sy varchar(3) not null,
no_cheque numeric(38),
ttrcod varchar(2)
) ;
-- dmap_object_gen_tag : type : alter table name : xxchk_asoc_fact_cheq_syb
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_asoc_fact_cheq_syb add constraint pk_xxchk_asoc_fact_cheq_syb primary key (id_sec_cheque,fam01cod,fax01ntr,facdoc);
-- dmap_object_gen_tag : type : alter table name : xxchk_asoc_fact_cheq_syb
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_asoc_fact_cheq_syb alter column id_sec_cheque set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_asoc_fact_cheq_syb
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_asoc_fact_cheq_syb alter column fam01cod set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_asoc_fact_cheq_syb
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_asoc_fact_cheq_syb alter column fax01ntr set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_asoc_fact_cheq_syb
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_asoc_fact_cheq_syb alter column facdoc set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_asoc_fact_cheq_syb
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_asoc_fact_cheq_syb alter column depref set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_asoc_fact_cheq_syb
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_asoc_fact_cheq_syb alter column empresa_sy set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_asoc_fact_cheq_syb
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_asoc_fact_cheq_syb add constraint fk_xxchk_as_fk_cheksy_xxchk_ca foreign key (id_estado_cheque) references xxchk_cat_edos(id_estado_cheque) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : xxchk_asoc_fact_cheq_syb
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_asoc_fact_cheq_syb add constraint fk_xxchk_as_fk_chksyb_fecxc_em foreign key (e_codigo) references fecxc_empresas(e_codigo) on delete no action not deferrable initially immediate;
-- dmap_object_gen_tag : type : alter table name : xxchk_asoc_fact_cheq_syb
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_asoc_fact_cheq_syb add constraint fk_xxchk_as_xxchk_chq_xxchk_ca foreign key (id_sec_cheque) references xxchk_captura_cheques(id_sec_cheque) on delete no action not deferrable initially immediate;
