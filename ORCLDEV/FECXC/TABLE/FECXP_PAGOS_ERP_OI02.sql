-- dmap_object_gen_tag : type : index name : fecxp_pagos_erp_oi02
set search_path = fecxc,oracle,dmap_extension,public;
create index fecxp_pagos_erp_oi02 on fecxp_pagos_erp_oi (e_codigo, folio_set);
