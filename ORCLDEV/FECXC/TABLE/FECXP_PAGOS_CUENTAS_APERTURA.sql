-- dmap_object_gen_tag : type : table name : fecxp_pagos_cuentas_apertura
set search_path = fecxc,oracle,dmap_extension,public;
create table "fecxp_pagos_cuentas_apertura"  (
oracle_segmento1 varchar(25),
oracle_segmento2 varchar(25),
oracle_segmento3 varchar(25),
oracle_segmento4 varchar(25),
oracle_segmento5 varchar(25),
oracle_segmento6 varchar(25),
oracle_segmento7 varchar(25),
comentario varchar(255) default '<SIN COMENTARIO>'
) ;
