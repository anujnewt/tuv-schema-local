-- DMAP_OBJECT_GEN_TAG : TYPE : EDITIONABLE NAME : xxmor_funcional_pkg_mor_rpta_concom_type
SET search_path = xxmor,oracle,dmap_extension,public;

CREATE TYPE xxmor_funcional_pkg_mor_rpta_concom_type AS (
ID_SOLICITUD       NUMERIC := NULL,
                       ID_RPTA_CONCOM     NUMERIC := NULL ,
                       RESULTADOGENERAL   varchar := NULL ,
                       TRACKINGID         varchar := NULL ,
                       DESC_CONCOM        varchar := NULL ,
                       POSICION_CONCOM    varchar := NULL ,
                       ID_CONCOM          varchar := NULL ,
                       NUMLINEA_CONCOM    varchar := NULL ,
                       ESTATUS_CONCOM     varchar := NULL ,
                       CAMPO_CONCOM       varchar := NULL ,
                       DETALLE_CONCOM     varchar := NULL ,
                       ACCION_CONCOM      varchar := NULL ,
                       TIPOREGLA_CONCOM   varchar := NULL ,
                       ESTATUS_ORDUNI     char := NULL

);
