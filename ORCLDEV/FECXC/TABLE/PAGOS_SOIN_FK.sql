-- dmap_object_gen_tag : type : index name : pagos_soin_fk
set search_path = fecxc,oracle,dmap_extension,public;
create index pagos_soin_fk on fecxp_det_pagos_soin (e_codigo, secuencia_pagos_soin);
