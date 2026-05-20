-- dmap_object_gen_tag : type : table name : fecxp_gastos_set_erp
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_gastos_set_erp"  (
secuencia_pagos_erp numeric(38) not null,
secuencia_gastos_set_erp numeric(38) not null,
e_codigo numeric(38) not null,
check_id numeric(15) not null,
invoice_id numeric(15) not null,
invoice_distrib_line_number numeric(15) not null,
invoice_distrib_line_amount numeric not null,
po_physical_header_id varchar(20),
po_physical_line_id numeric,
po_header_id numeric,
po_line_id numeric,
po_distribution_id_number numeric,
code_combination_id numeric not null,
oracle_segmento1 varchar(25) not null,
oracle_segmento2 varchar(25) not null,
oracle_segmento3 varchar(25) not null,
oracle_segmento4 varchar(25) not null,
oracle_segmento5 varchar(25) not null,
oracle_segmento6 varchar(25) not null,
oracle_segmento7 varchar(25) not null,
atributo_11 varchar(150) not null
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_gastos_set_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_gastos_set_erp add constraint pk_cxpfe_gastos_set_erp primary key (e_codigo,secuencia_pagos_erp,secuencia_gastos_set_erp);
-- dmap_object_gen_tag : type : alter table name : fecxp_gastos_set_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_gastos_set_erp alter column secuencia_pagos_erp set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_gastos_set_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_gastos_set_erp alter column secuencia_gastos_set_erp set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_gastos_set_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_gastos_set_erp alter column e_codigo set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_gastos_set_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_gastos_set_erp alter column check_id set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_gastos_set_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_gastos_set_erp alter column invoice_id set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_gastos_set_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_gastos_set_erp alter column invoice_distrib_line_number set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_gastos_set_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_gastos_set_erp alter column invoice_distrib_line_amount set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_gastos_set_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_gastos_set_erp alter column code_combination_id set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_gastos_set_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_gastos_set_erp alter column oracle_segmento1 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_gastos_set_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_gastos_set_erp alter column oracle_segmento2 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_gastos_set_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_gastos_set_erp alter column oracle_segmento3 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_gastos_set_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_gastos_set_erp alter column oracle_segmento4 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_gastos_set_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_gastos_set_erp alter column oracle_segmento5 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_gastos_set_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_gastos_set_erp alter column oracle_segmento6 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_gastos_set_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_gastos_set_erp alter column oracle_segmento7 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_gastos_set_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_gastos_set_erp alter column atributo_11 set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_gastos_set_erp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_gastos_set_erp add constraint fk_fecxp_ga_gastos_se_fecxp_de foreign key (e_codigo,secuencia_pagos_erp) references fecxp_enc_pagos_erp(e_codigo,secuencia_pagos_erp) on delete no action not deferrable initially immediate;
