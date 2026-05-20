-- dmap_object_gen_tag : type : table name : fecxp_folios_prov_det
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_folios_prov_det"  (
fecxp_e_codigo numeric(38),
fecxp_no_folio_det varchar(150),
fecxp_importe decimal(20, 2),
ap_invoice_id numeric(15),
ap_invoice_amount numeric,
ap_distribution_line_number numeric(15),
ap_distribution_amount numeric,
ap_dist_code_combination_id numeric(15),
ap_cuenta varchar(150),
segmento1 varchar(25),
segmento2 varchar(25),
segmento3 varchar(25),
segmento4 varchar(25),
segmento5 varchar(25),
segmento6 varchar(25),
segmento7 varchar(25)
) ;
