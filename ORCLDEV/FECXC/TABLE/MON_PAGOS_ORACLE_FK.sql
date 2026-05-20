-- dmap_object_gen_tag : type : index name : mon_pagos_oracle_fk
set search_path = fecxc,oracle,dmap_extension,public;
create index mon_pagos_oracle_fk on fecxp_enc_pagos_erp (secmoneda);
