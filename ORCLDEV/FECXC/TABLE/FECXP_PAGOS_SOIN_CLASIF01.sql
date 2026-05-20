-- dmap_object_gen_tag : type : index name : fecxp_pagos_soin_clasif01
set search_path = fecxc,oracle,dmap_extension,public;
create index fecxp_pagos_soin_clasif01 on fecxp_pagos_soin_clasif (e_codigo, tipo_operacion, ctam01, ctam02, ctam03);
