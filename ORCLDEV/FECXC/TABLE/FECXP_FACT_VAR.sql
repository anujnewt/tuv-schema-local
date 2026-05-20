-- dmap_object_gen_tag : type : table name : fecxp_fact_var
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_fact_var"  (
no_folio_det numeric(38) not null,
receipt_number varchar(30),
cash_receipt_id numeric(15),
customer_trx_id numeric(15),
customer_trx_line_id numeric(15),
code_combination numeric(38)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_fact_var
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_fact_var alter column no_folio_det set not null;
