-- dmap_object_gen_tag : type : index name : idx_fecha_enc_soin
set search_path = fecxc,oracle,dmap_extension,public;
create index idx_fecha_enc_soin on fecxp_enc_pagos_soin (fecha_aplicacion);
