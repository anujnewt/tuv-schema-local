-- dmap_object_gen_tag : type : index name : idx_det_pagos_procesados_01
set search_path = fecxc,oracle,dmap_extension,public;
create index idx_det_pagos_procesados_01 on fecxp_det_pagos_procesados (secuencia_pagos_erp);
