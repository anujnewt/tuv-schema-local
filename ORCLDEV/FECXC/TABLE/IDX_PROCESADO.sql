-- dmap_object_gen_tag : type : index name : idx_procesado
set search_path = fecxc,oracle,dmap_extension,public;
create index idx_procesado on fecxp_enc_pagos_erp (procesado);
