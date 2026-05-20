-- dmap_object_gen_tag : type : table name : xxchk_intarc_ora
set search_path = fecxc,oracle,dmap_extension,public;
create table "xxchk_intarc_ora"  (
e_codigo numeric(38) not null,
intbat varchar(50),
intori varchar(2),
intsub varchar(2),
intrel numeric(38),
intdoc varchar(12),
intref varchar(12),
intmon numeric,
intmoe numeric,
inttip varchar(1),
intdes varchar(40),
intdia varchar(2),
intfec varchar(8),
intcam numeric,
ctam01 varchar(3),
ctam02 varchar(3),
ctam03 varchar(4),
ctam04 varchar(4),
ctam05 varchar(3),
ctam06 varchar(3),
moncod varchar(2),
impfpo varchar(8),
tv6prd numeric(38),
impref2 varchar(30),
tv9ide varchar(20),
date_created timestamp(0) default statement_timestamp(),
created_by varchar(30),
procesado numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : xxchk_intarc_ora
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_intarc_ora add constraint pk_xxchk_intarc_ora primary key (e_codigo);
-- dmap_object_gen_tag : type : alter table name : xxchk_intarc_ora
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_intarc_ora alter column e_codigo set not null;
-- dmap_object_gen_tag : type : alter table name : xxchk_intarc_ora
set search_path = fecxc,oracle,dmap_extension,public;
alter table xxchk_intarc_ora add constraint fk_xxchk_in_empresa_a_fecxc_em foreign key (e_codigo) references fecxc_empresas(e_codigo) on delete no action not deferrable initially immediate;
