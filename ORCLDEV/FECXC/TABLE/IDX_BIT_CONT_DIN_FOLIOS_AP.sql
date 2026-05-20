-- dmap_object_gen_tag : type : index name : idx_bit_cont_din_folios_ap
set search_path = fecxc,oracle,dmap_extension,public;
create index idx_bit_cont_din_folios_ap on fecxp_bit_cont_din_folios_ap (secuencia_pagos_erp);
