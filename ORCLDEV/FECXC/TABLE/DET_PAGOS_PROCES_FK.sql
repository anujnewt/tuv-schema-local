-- dmap_object_gen_tag : type : index name : det_pagos_proces_fk
set search_path = fecxc,oracle,dmap_extension,public;
create index det_pagos_proces_fk on fecxp_det_pagos_procesados (e_codigo, secuencia_pagos_erp, secuencia_det_pagos_erp, numero_de_partida_erp);
