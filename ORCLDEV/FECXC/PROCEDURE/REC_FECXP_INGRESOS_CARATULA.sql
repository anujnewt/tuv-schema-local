-- dmap_object_gen_tag : type : procedure name : rec_fecxp_ingresos_caratula;
set search_path = fecxc,oracle,dmap_extension,public;
drop type  if exists rec_fecxp_ingresos_caratula;
-- dmap_object_gen_tag : type : procedure name : FECXC.rec_fecxp_ingresos_caratula
set search_path = fecxc,oracle,dmap_extension,public;
create type FECXC.rec_fecxp_ingresos_caratula as (cla_fe_id           varchar(25),e_codigo            integer,folio_set           integer,tipo_operacion      integer,fecha               timestamp(0),moneda              varchar(3),importe             decimal(20,4),id_banco            integer,id_chequera         varchar(20),referencia          varchar(30),importe_linea       decimal(20,4),ora_soin_segmento1  varchar(25),ora_soin_segmento2  varchar(25),ora_soin_segmento3  varchar(25),oracle_segmento4    varchar(25),oracle_segmento5    varchar(25),oracle_segmento6    varchar(25),oracle_segmento7    varchar(25),cual_erp            varchar(1),tipo_clasificacion  varchar(20),id_status_mov       varchar(1));
