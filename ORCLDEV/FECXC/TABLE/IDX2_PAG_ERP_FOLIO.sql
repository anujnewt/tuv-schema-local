-- dmap_object_gen_tag : type : index name : idx2_pag_erp_folio
set search_path = fecxc,oracle,dmap_extension,public;
create index idx2_pag_erp_folio on fecxp_enc_pagos_erp (folio_set, estatus_movimiento);
