-- dmap_object_gen_tag : type : table name : tmp_xxchk_asoc_fact_cheq_syb
set search_path = fecxc,oracle,dmap_extension,public;
create table "tmp_xxchk_asoc_fact_cheq_syb"  (
id_sec_cheque numeric(38) not null,
fam01cod varchar(4) not null,
fax01ntr numeric(38) not null,
facdoc varchar(15) not null,
clinom varchar(50),
clicod varchar(15),
monto decimal(20, 2),
moneda varchar(3),
tipo_cambio decimal(20, 4),
depref varchar(22) not null,
empresa_sy varchar(3) not null
) ;
-- dmap_object_gen_tag : type : alter table name : tmp_xxchk_asoc_fact_cheq_syb
set search_path = fecxc,oracle,dmap_extension,public;
alter table tmp_xxchk_asoc_fact_cheq_syb alter column id_sec_cheque set not null;
-- dmap_object_gen_tag : type : alter table name : tmp_xxchk_asoc_fact_cheq_syb
set search_path = fecxc,oracle,dmap_extension,public;
alter table tmp_xxchk_asoc_fact_cheq_syb alter column fam01cod set not null;
-- dmap_object_gen_tag : type : alter table name : tmp_xxchk_asoc_fact_cheq_syb
set search_path = fecxc,oracle,dmap_extension,public;
alter table tmp_xxchk_asoc_fact_cheq_syb alter column fax01ntr set not null;
-- dmap_object_gen_tag : type : alter table name : tmp_xxchk_asoc_fact_cheq_syb
set search_path = fecxc,oracle,dmap_extension,public;
alter table tmp_xxchk_asoc_fact_cheq_syb alter column facdoc set not null;
-- dmap_object_gen_tag : type : alter table name : tmp_xxchk_asoc_fact_cheq_syb
set search_path = fecxc,oracle,dmap_extension,public;
alter table tmp_xxchk_asoc_fact_cheq_syb alter column depref set not null;
-- dmap_object_gen_tag : type : alter table name : tmp_xxchk_asoc_fact_cheq_syb
set search_path = fecxc,oracle,dmap_extension,public;
alter table tmp_xxchk_asoc_fact_cheq_syb alter column empresa_sy set not null;
