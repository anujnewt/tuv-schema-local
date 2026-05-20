-- dmap_object_gen_tag : type : index name : pagos_oracle_fk
set search_path = fecxc,oracle,dmap_extension,public;
create index pagos_oracle_fk on fecxp_det_pagos_erp (e_codigo, secuencia_pagos_erp);
