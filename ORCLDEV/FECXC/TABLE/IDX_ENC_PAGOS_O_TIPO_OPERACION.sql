-- dmap_object_gen_tag : type : index name : idx_enc_pagos_o_tipo_operacion
set search_path = fecxc,oracle,dmap_extension,public;
create index idx_enc_pagos_o_tipo_operacion on fecxp_enc_pagos_erp (tipo_operacion);
