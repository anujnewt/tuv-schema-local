-- dmap_object_gen_tag : type : index name : fecxp_rep_ppto_o_erp00
set search_path = fecxc,oracle,dmap_extension,public;
create index fecxp_rep_ppto_o_erp00 on fecxp_rep_ppto_comp_o_erp (code_combination_id, moneda);
