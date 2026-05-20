-- dmap_object_gen_tag : type : table name : fecxp_det_pagos_soin
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_det_pagos_soin"  (
secuencia_det_pagos_soin numeric(38) not null,
secuencia_pagos_soin numeric(38) not null,
e_codigo numeric(38) not null,
numero_de_partida numeric(38) not null,
importe_linea decimal(20, 4),
ctam01 varchar(3),
ctam02 varchar(3),
ctam03 varchar(3)
) ;
-- dmap_object_gen_tag : type : alter table name : fecxp_det_pagos_soin
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_det_pagos_soin add constraint pk_fecxp_det_pagos_soin primary key (e_codigo,secuencia_pagos_soin,secuencia_det_pagos_soin,numero_de_partida);
-- dmap_object_gen_tag : type : alter table name : fecxp_det_pagos_soin
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_det_pagos_soin alter column secuencia_det_pagos_soin set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_det_pagos_soin
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_det_pagos_soin alter column secuencia_pagos_soin set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_det_pagos_soin
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_det_pagos_soin alter column e_codigo set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_det_pagos_soin
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_det_pagos_soin alter column numero_de_partida set not null;
-- dmap_object_gen_tag : type : alter table name : fecxp_det_pagos_soin
set search_path = fecxc,oracle,dmap_extension,public;
alter table fecxp_det_pagos_soin add constraint fk_fecxp_de_pagos_soi_fecxp_en foreign key (e_codigo,secuencia_pagos_soin) references fecxp_enc_pagos_soin(e_codigo,secuencia_pagos_soin) on delete no action not deferrable initially immediate;
