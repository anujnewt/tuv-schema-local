-- dmap_object_gen_tag : type : table name : fecxp_enc_pagos_erp_tmp
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_enc_pagos_erp_tmp"  (
secuencia_pagos_erp numeric(38) not null,
e_codigo numeric(38) not null
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_enc_pagos_erp_tmp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_enc_pagos_erp_tmp alter column secuencia_pagos_erp set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_enc_pagos_erp_tmp
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_enc_pagos_erp_tmp alter column e_codigo set not null;
