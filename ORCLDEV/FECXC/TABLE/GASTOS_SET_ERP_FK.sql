-- dmap_object_gen_tag : type : index name : gastos_set_erp_fk
set search_path = fecxc,oracle,dmap_extension,public;
create index gastos_set_erp_fk on fecxp_gastos_set_erp (secuencia_pagos_erp, e_codigo);
