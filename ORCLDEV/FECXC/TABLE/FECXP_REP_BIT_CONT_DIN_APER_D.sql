-- dmap_object_gen_tag : type : table name : fecxp_rep_bit_cont_din_aper_d
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_rep_bit_cont_din_aper_d"  (
secuencia_pagos_erp numeric(38) not null,
e_codigo numeric(38) not null,
ap_invoice_id numeric(15),
ap_distribution_line_number numeric(15) not null,
ap_distribution_amount numeric,
cla_fe_id char(25),
cla_fe_des char(50),
tipo_operacion numeric(38),
id_banco numeric(38),
id_chequera varchar(11),
oracle_segmento1 char(25),
oracle_segmento2 char(25),
oracle_segmento3 char(25),
oracle_segmento4 char(25),
oracle_segmento5 char(25),
oracle_segmento6 char(25),
oracle_segmento7 char(25),
origen_registro char(20)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_bit_cont_din_aper_d
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_bit_cont_din_aper_d alter column secuencia_pagos_erp set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_bit_cont_din_aper_d
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_bit_cont_din_aper_d alter column e_codigo set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_rep_bit_cont_din_aper_d
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_rep_bit_cont_din_aper_d alter column ap_distribution_line_number set not null;
