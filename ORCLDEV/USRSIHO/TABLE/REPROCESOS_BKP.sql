-- dmap_object_gen_tag : type : table name : reprocesos_bkp
set search_path = usrsiho,oracle,dmap_extension,public;
create table "reprocesos_bkp"  (
rep_ejercicio numeric(10) not null,
rep_keyemp numeric(10),
rep_capini numeric,
rep_capfin numeric,
rep_costog numeric,
rep_keyrec numeric(10),
rep_fecsol timestamp(0),
rep_import decimal(20, 2),
rep_imbase decimal(20, 2),
rep_forpag numeric(10),
rep_tipcam decimal(16, 6),
rep_pertra numeric(10),
rep_moneda decimal(16, 6),
rep_keypro numeric(5),
rep_keyapr varchar(6),
rep_keynom numeric(5),
rep_numemi numeric(10),
rep_bannvo numeric(10),
rep_impres numeric,
rep_keycon varchar(5),
rep_status numeric(10),
rep_rphori numeric(10),
rep_keyrph numeric(10),
rep_fecpag timestamp(0),
rep_ordcom varchar(100),
rep_obscan varchar(100),
rep_eminvo numeric(10),
rep_imneto decimal(12, 2),
rep_keypol numeric(10),
rep_nummes numeric(10),
rep_ordnvo numeric(10),
rep_recnvo numeric(10),
rep_basnvo decimal(12, 2)
) ;
-- dmap_object_gen_tag : type : alter table name : reprocesos_bkp
set search_path = usrsiho,oracle,dmap_extension,public;
alter table reprocesos_bkp alter column rep_ejercicio set not null;
