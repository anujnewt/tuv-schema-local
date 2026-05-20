-- dmap_object_gen_tag : type : index name : xxap_timbrado_viaticos_n04
set search_path = labprod,oracle,dmap_extension,public;
create index xxap_timbrado_viaticos_n04 on xxap_timbrado_viaticos_lab (invoice_payment_id);
