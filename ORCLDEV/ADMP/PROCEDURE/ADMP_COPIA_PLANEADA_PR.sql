CREATE OR REPLACE EDITIONABLE PROCEDURE "ADMP"."ADMP_COPIA_PLANEADA_PR" (
                               pistIdAccion IN VARCHAR2,
                               pistDetalles IN VARCHAR2,
                               piinIdUsuario IN NUMBER,
                               piinIdCanalOrigen IN NUMBER,
                               pistFechaIniOrigen IN VARCHAR2,
                               pistFechaFinOrigen IN VARCHAR2,
                               piinIdCanalDestino IN NUMBER,
                               pistFechaIniDestino IN VARCHAR2,
                               pistFechaFinDestino IN VARCHAR2,
                               pistLunes IN VARCHAR2,
                               pistMartes IN VARCHAR2,
                               pistMiercoles IN VARCHAR2,
                               pistJueves IN VARCHAR2,
                               pistViernes IN VARCHAR2,
                               pistSabado IN VARCHAR2,
                               pistDomingo IN VARCHAR2,
                               piinIdTipoParrilla IN NUMBER,
                               piinIdTipoParrillaDestino IN NUMBER,
                               postMensaje OUT VARCHAR2
                               )
    IS
-- PGV moved types end

-- PGV moved types end
        linHoraIni NUMBER := 0;
        linHoraFin NUMBER := 0;
        linHoraIniMas NUMBER := 0;
        linHoraFinMenos NUMBER := 0;
    BEGIN
    if pistIdAccion = 'P' THEN
        DECLARE
-- PGV moved types start

-- PGV moved types start
        linIntervalo NUMBER := 0;
        ldtFechaIntervalo DATE := TO_DATE(pistFechaIniDestino, 'dd/mm/yyyy');
        linIdNuevoParrilla NUMBER :=-1;
        linIdNuevoParrillaSig NUMBER :=-1;
        lstIdNumeroDia VARCHAR(5) :=-1;
        lstIdNumeroAux VARCHAR(5) :=-1;
        lstIdNumeroProgram VARCHAR(5) :=-1;
        linFlagINSERTa NUMBER :=-1;
        lstHoraInicioTmp VARCHAR(8) :=-1;
        lstHoraFinTmp VARCHAR(8) :=-1;
        linIdNuevoDetParrilla NUMBER :=-1;
    BEGIN
        FOR ltbPrograma IN (
           SELECT * FROM ADMP.ADMP_PARRILLA_COPIA_VW WHERE ID_PARRILLA_DET IN(
           SELECT regexp_substr(pistDetalles,'[^,]+', 1, LEVEL) FROM DUAL
           CONNECT BY regexp_substr(pistDetalles, '[^,]+', 1, LEVEL) IS NOT NULL
        ))
        LOOP
            SELECT 1 + TRUNC(
                (SELECT FEC_PARRILLA
                FROM ADMP.ADMP_PARRILLA_COPIA_VW
                WHERE ID_PARRILLA_DET = ltbPrograma.ID_PARRILLA_DET)+1)
            - TRUNC(
                (SELECT FEC_PARRILLA
                FROM ADMP.ADMP_PARRILLA_COPIA_VW
                WHERE ID_PARRILLA_DET = ltbPrograma.ID_PARRILLA_DET)+1, 'IW')
            INTO lstIdNumeroProgram FROM DUAL;
       IF TO_NUMBER(REPLACE(ltbPrograma.DES_HORA_INICIO, ':','')) >= 240000 THEN
            linHoraIni := TO_NUMBER(REPLACE(
                       REPLACE(ltbPrograma.DES_HORA_INICIO, '24','00'),':',''));
            linHoraIniMas := TO_NUMBER(REPLACE(
                   REPLACE(ltbPrograma.DES_HORA_INICIO, '24','00'),':','')) + 1;
        IF SUBSTR(ltbPrograma.DES_HORA_FIN, 1, 2) = '25' THEN
            linHoraFin := TO_NUMBER(REPLACE(
                        REPLACE(ltbPrograma.DES_HORA_FIN, '25','01'),':',''));
            linHoraFinMenos := TO_NUMBER(REPLACE(
                    REPLACE(ltbPrograma.DES_HORA_FIN, '25','01'),':','')) - 1;
        ELSIF SUBSTR(ltbPrograma.DES_HORA_FIN, 1, 2) = '24' THEN
            linHoraFin := TO_NUMBER(REPLACE(
                        REPLACE(ltbPrograma.DES_HORA_FIN, '24','00'),':',''));
            linHoraFinMenos := TO_NUMBER(REPLACE(
                      REPLACE(ltbPrograma.DES_HORA_FIN, '24','00'),':','')) - 1;
        END IF;
    FOR ltbRec IN (
        SELECT  id_parrilla_det
        FROM    ADMP.ADMP_PARRILLA_COPIA_VW
        WHERE   id_canal = piinIdCanalDestino AND fec_parrilla
        BETWEEN (TO_DATE(pistFechaIniDestino, 'dd/mm/yyyy') + 1)
        AND     (TO_DATE(pistFechaFinDestino, 'dd/mm/yyyy') + 1)
        AND     (TO_NUMBER(REPLACE(DES_HORA_INICIO, ':',''))
        BETWEEN linHoraIni AND linHoraFinMenos
        OR      TO_NUMBER(REPLACE(DES_HORA_FIN, ':',''))
        BETWEEN linHoraIniMas AND linHoraFin
        OR      (TO_NUMBER(REPLACE(DES_HORA_INICIO, ':','')) <  linHoraIni
        AND     TO_NUMBER(REPLACE(DES_HORA_FIN, ':','')) >  linHoraFin))
        AND     Dia = lstIdNumeroProgram
        AND     ID_TIPO_PARRILLA = piinIdTipoParrillaDestino
        )
    LOOP
        DELETE ADMP.ADMP_TARGET_PARR_DET_TAB
        WHERE ID_PARRILLA_DET = ltbRec.id_parrilla_det;
        DELETE ADMP.ADMP_PARRILLA_DET_TAB
        WHERE ID_PARRILLA_DET = ltbRec.id_parrilla_det;
    END LOOP;
    ELSIF TO_NUMBER(REPLACE(ltbPrograma.DES_HORA_INICIO, ':','')) < 240000
    AND TO_NUMBER(REPLACE(ltbPrograma.DES_HORA_FIN, ':','')) > 240000 THEN
        linHoraIni := TO_NUMBER(REPLACE(ltbPrograma.DES_HORA_INICIO, ':',''));
        linHoraIniMas := TO_NUMBER(
                        REPLACE(ltbPrograma.DES_HORA_INICIO, ':','')) + 1;
        if SUBSTR(ltbPrograma.DES_HORA_FIN, 1, 2) = '25' THEN
            linHoraFin := TO_NUMBER(REPLACE(
                        REPLACE(ltbPrograma.DES_HORA_FIN, '25','01'),':',''));
            linHoraFinMenos := TO_NUMBER(REPLACE(
                    REPLACE(ltbPrograma.DES_HORA_FIN, '25','01'),':','')) - 1;
        ELSIF SUBSTR(ltbPrograma.DES_HORA_FIN, 1, 2) = '24' THEN
            linHoraFin := TO_NUMBER(REPLACE(
                        REPLACE(ltbPrograma.DES_HORA_FIN, '24','00'),':',''));
            linHoraFinMenos := TO_NUMBER(
              REPLACE(REPLACE(ltbPrograma.DES_HORA_FIN, '24','00'),':','')) - 1;
        END IF;
    FOR ltbRec IN (
        SELECT  id_parrilla_det
        FROM    ADMP.ADMP_PARRILLA_COPIA_VW
        WHERE   id_canal = piinIdCanalDestino
        AND     fec_parrilla BETWEEN TO_DATE(pistFechaIniDestino, 'dd/mm/yyyy')
        AND     TO_DATE(pistFechaFinDestino, 'dd/mm/yyyy')
        AND     (TO_NUMBER(REPLACE(DES_HORA_INICIO, ':',''))
        BETWEEN linHoraIni AND 239999
        OR      TO_NUMBER(REPLACE(DES_HORA_FIN, ':',''))
        BETWEEN  linHoraIniMas AND 240000
        OR      (TO_NUMBER(REPLACE(DES_HORA_INICIO, ':','')) <  linHoraIni
        AND     TO_NUMBER(REPLACE(DES_HORA_FIN, ':','')) >  240000))
        AND     Dia = ltbPrograma.DIA
        AND     ID_TIPO_PARRILLA = piinIdTipoParrillaDestino
        )
        LOOP
            DELETE ADMP.ADMP_TARGET_PARR_DET_TAB
                WHERE ID_PARRILLA_DET = ltbRec.id_parrilla_det;
            DELETE ADMP.ADMP_PARRILLA_DET_TAB
                WHERE ID_PARRILLA_DET = ltbRec.id_parrilla_det;
        END LOOP;
        FOR ltbRec IN (
        SELECT  id_parrilla_det
        FROM    ADMP.ADMP_PARRILLA_COPIA_VW
        WHERE   id_canal = piinIdCanalDestino
        AND     fec_parrilla
        BETWEEN (TO_DATE(pistFechaIniDestino, 'dd/mm/yyyy') + 1)
        AND     (TO_DATE(pistFechaFinDestino, 'dd/mm/yyyy') + 1)
        AND     (TO_NUMBER(REPLACE(DES_HORA_INICIO, ':',''))
        BETWEEN 0 AND linHoraFinMenos
        OR      TO_NUMBER(REPLACE(DES_HORA_FIN, ':',''))
        BETWEEN 1 AND linHoraFin
        OR      (TO_NUMBER(REPLACE(DES_HORA_INICIO, ':','')) <  0
        AND     TO_NUMBER(REPLACE(DES_HORA_FIN, ':','')) >  linHoraFin))
        AND     Dia = lstIdNumeroProgram
        AND     ID_TIPO_PARRILLA = piinIdTipoParrillaDestino
        )
        LOOP
            DELETE ADMP.ADMP_TARGET_PARR_DET_TAB WHERE ID_PARRILLA_DET = ltbRec.id_parrilla_det;
            DELETE ADMP.ADMP_PARRILLA_DET_TAB WHERE ID_PARRILLA_DET = ltbRec.id_parrilla_det;
        END LOOP;
    ELSE
        linHoraIni := TO_NUMBER(REPLACE(ltbPrograma.DES_HORA_INICIO, ':',''));
        linHoraIniMas := TO_NUMBER(
                        REPLACE(ltbPrograma.DES_HORA_INICIO, ':','')) + 1;
        linHoraFin := TO_NUMBER(REPLACE(ltbPrograma.DES_HORA_FIN, ':',''));
        linHoraFinMenos := TO_NUMBER(
                        REPLACE(ltbPrograma.DES_HORA_FIN, ':','')) - 1;
        FOR ltbRec IN (
            SELECT  id_parrilla_det
            FROM    ADMP.ADMP_PARRILLA_COPIA_VW
            WHERE   id_canal = piinIdCanalDestino
            AND     fec_parrilla
            BETWEEN TO_DATE(pistFechaIniDestino, 'dd/mm/yyyy')
            AND     TO_DATE(pistFechaFinDestino, 'dd/mm/yyyy')
            AND     (TO_NUMBER(REPLACE(DES_HORA_INICIO, ':',''))
            BETWEEN  linHoraIni AND linHoraFinMenos
            OR      TO_NUMBER(REPLACE(DES_HORA_FIN, ':',''))
            BETWEEN linHoraIniMas AND linHoraFin
            OR     (TO_NUMBER(REPLACE(DES_HORA_INICIO, ':','')) <  linHoraIni
            AND     TO_NUMBER(REPLACE(DES_HORA_FIN, ':','')) >  linHoraFin))
            AND     Dia = ltbPrograma.DIA
            AND     ID_TIPO_PARRILLA = piinIdTipoParrillaDestino
            )
            LOOP
                DELETE ADMP.ADMP_TARGET_PARR_DET_TAB
                    WHERE ID_PARRILLA_DET = ltbRec.id_parrilla_det;
                DELETE ADMP.ADMP_PARRILLA_DET_TAB
                    WHERE ID_PARRILLA_DET = ltbRec.id_parrilla_det;
            END LOOP;
        END if;
    END LOOP;
    SELECT TO_DATE(pistFechaFinDestino, 'dd/mm/yyyy') -
         TO_DATE(pistFechaIniDestino, 'dd/mm/yyyy') INTO linIntervalo FROM DUAL;
    LOOP
        DECLARE
            ltbCab   ADMP.ADMP_PARRILLA_TAB%ROWTYPE;
            ltbNext  ADMP.ADMP_PARRILLA_TAB%ROWTYPE;
            CURSOR lcurCabecero IS
            SELECT * FROM ADMP.ADMP_PARRILLA_TAB
            WHERE FEC_PARRILLA = ldtFechaIntervalo
            AND ID_CANAL = piinIdCanalDestino
            AND ID_TIPO_PARRILLA = piinIdTipoParrillaDestino;
            CURSOR lcurCabeceroSiguiente IS
            SELECT * FROM ADMP.ADMP_PARRILLA_TAB
            WHERE FEC_PARRILLA = (ldtFechaIntervalo + 1)
            AND ID_CANAL = piinIdCanalDestino
            AND ID_TIPO_PARRILLA = piinIdTipoParrillaDestino;
    BEGIN
     OPEN lcurCabecero;
     OPEN lcurCabeceroSiguiente;
         LOOP
            FETCH lcurCabecero INTO ltbCab;
            FETCH lcurCabeceroSiguiente INTO ltbNext;
            SELECT 1 + TRUNC (ldtFechaIntervalo)
              - TRUNC (ldtFechaIntervalo, 'IW')  INTO lstIdNumeroDia  FROM DUAL;
            linFlagINSERTa := -1;
            IF lstIdNumeroDia = '1' THEN
                IF pistLunes IS NOT NULL THEN
                    linFlagINSERTa := 1;
                END IF;
            END IF;
            IF lstIdNumeroDia = '2' THEN
                IF pistMartes     IS NOT NULL THEN
                    linFlagINSERTa := 1;
                END IF;
            END IF;
            IF lstIdNumeroDia = '3' THEN
                IF pistMiercoles     IS NOT NULL THEN
                    linFlagINSERTa := 1;
                END IF;
            END IF;
            IF lstIdNumeroDia = '4' THEN
                IF pistJueves     IS NOT NULL THEN
                    linFlagINSERTa := 1;
                END IF;
            END IF;
            IF lstIdNumeroDia = '5' THEN
                IF pistViernes     IS NOT NULL THEN
                    linFlagINSERTa := 1;
                END IF;
            END IF;
            IF lstIdNumeroDia = '6' THEN
                IF pistSabado     IS NOT NULL THEN
                    linFlagINSERTa := 1;
                END IF;
            END IF;
            IF lstIdNumeroDia = '7' THEN
                IF pistDomingo     IS NOT NULL THEN
                    linFlagINSERTa := 1;
                END IF;
            END IF;
    IF linFlagINSERTa = '1' THEN
        IF lcurCabecero%NOTFOUND THEN
            INSERT INTO ADMP.ADMP_PARRILLA_TAB(
                id_parrilla,
                fec_parrilla,
                id_canal,
                num_version,
                id_estado,
                num_created_by,
                fec_creation_DATE,
                num_last_upDATE,
                fec_last_upDATE,
                num_last_upDATE_login,
                atributo1,
                atributo2,
                atributo3,
                atributo4,
                atributo5,
                atributo6,
                atributo7,
                atributo8,
                atributo9,
                atributo10,
                atributo11,
                atributo12,
                atributo13,
                atributo14,
                atributo15,
                attribute_category,
                id_tipo_parrilla
                )
            VALUES(
                -1 ,
                ldtFechaIntervalo,
                piinIdCanalDestino,
                1,
                1,
                piinIdUsuario,
                SYSDATE,
                piinIdUsuario,
                SYSDATE,
                piinIdUsuario,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                piinIdTipoParrillaDestino )
            returning id_parrilla INTO linIdNuevoParrilla;
    ELSE
        linIdNuevoParrilla := ltbCab.ID_PARRILLA;
    END IF;
        IF lcurCabeceroSiguiente%NOTFOUND THEN
            INSERT INTO ADMP.ADMP_PARRILLA_TAB(
                id_parrilla,
                fec_parrilla,
                id_canal,
                num_version,
                id_estado,
                num_created_by,
                fec_creation_DATE,
                num_last_upDATE,
                fec_last_upDATE,
                num_last_upDATE_login,
                atributo1,
                atributo2,
                atributo3,
                atributo4,
                atributo5,
                atributo6,
                atributo7,
                atributo8,
                atributo9,
                atributo10,
                atributo11,
                atributo12,
                atributo13,
                atributo14,
                atributo15,
                attribute_category,
                id_tipo_parrilla
                )
            VALUES(
                -1 ,
                (ldtFechaIntervalo + 1),
                piinIdCanalDestino,
                1,
                1,
                piinIdUsuario,
                SYSDATE,
                piinIdUsuario,
                SYSDATE,
                piinIdUsuario,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                piinIdTipoParrillaDestino
                )
            returning id_parrilla INTO linIdNuevoParrillaSig;
        ELSE
            linIdNuevoParrillaSig := ltbNext.ID_PARRILLA;
        END IF;
        FOR ltbDetalle IN (
           SELECT * FROM ADMP.ADMP_PARRILLA_DET_TAB WHERE ID_PARRILLA_DET IN(
           SELECT regexp_substr(pistDetalles,'[^,]+', 1, LEVEL) FROM DUAL
           CONNECT BY regexp_substr(pistDetalles, '[^,]+', 1, LEVEL) IS NOT NULL
        ))
        LOOP
            SELECT 1 + TRUNC((SELECT FEC_PARRILLA
                              FROM ADMP.ADMP_PARRILLA_COPIA_VW
                              WHERE ID_PARRILLA_DET = ltbDetalle.ID_PARRILLA_DET))
                     - TRUNC((SELECT FEC_PARRILLA
                             FROM ADMP.ADMP_PARRILLA_COPIA_VW
                             WHERE ID_PARRILLA_DET = ltbDetalle.ID_PARRILLA_DET), 'IW')
                             INTO lstIdNumeroAux FROM DUAL;
            IF lstIdNumeroAux = lstIdNumeroDia THEN
                IF TO_NUMBER(REPLACE(ltbDetalle.DES_HORA_INICIO, ':','')) >= 240000
                AND TO_NUMBER(REPLACE(ltbDetalle.DES_HORA_FIN, ':','')) <= 250000 THEN
                IF SUBSTR(ltbDetalle.DES_HORA_INICIO, 1, 2) = '24' THEN
                    lstHoraInicioTmp := REPLACE(ltbDetalle.DES_HORA_INICIO, '24','00');
                ELSIF SUBSTR(ltbDetalle.DES_HORA_INICIO, 1, 2) = '25' THEN
                    lstHoraInicioTmp := REPLACE(ltbDetalle.DES_HORA_INICIO, '25','01');
                END IF;
                IF SUBSTR(ltbDetalle.DES_HORA_FIN, 1, 2) = '24' THEN
                    lstHoraFinTmp := REPLACE(ltbDetalle.DES_HORA_FIN, '24','00');
                ELSIF SUBSTR(ltbDetalle.DES_HORA_FIN, 1, 2) = '25' THEN
                    lstHoraFinTmp := REPLACE(ltbDetalle.DES_HORA_FIN, '25','01');
                END IF;
        INSERT INTO  ADMP.ADMP_PARRILLA_DET_TAB  (
                            ID_PARRILLA_DET,
                            ID_PARRILLA,
                            ID_GENERO,
                            DES_CICLO,
                            DES_HORA_INICIO,
                            DES_HORA_FIN,
                            DES_HORA_INICIO_REAL,
                            DES_HORA_FIN_REAL,
                            DES_HORA_INICIO_ISO,
                            DES_HORA_FIN_ISO,
                            ID_TIPO,
                            DES_PROGRAMA,
                            DES_PROGRAMA_ORIGINAL,
                            ID_CLASIFICACION,
                            ID_FORMATO,
                            ID_RESTRICCION,
                            DES_NOTAS,
                            NUM_TRANSMISIONES,
                            FEC_ULTIMA_TRANSMISION,
                            DES_ULTIMA_TRANSMISION,
                            NUM_COLOR,
                            NUM_SAP,
                            NUM_TEMPORADA,
                            NUM_REPETICION_TEMP,
                            COD_PROGRAMA_IBOPE,
                            DES_PROGRAMA_IBOPE,
                            ID_FUENTE,
                            ID_EVENTO,
                            DES_DESCRIPCION,
                            NUM_FUENTE_XLS,
                            NUM_CAMBIO_PROG,
                            FEC_CAMBIO_PROG,
                            DES_CAPITULO,
                            NUM_CREATED_BY,
                            FEC_CREATION_DATE,
                            NUM_LAST_UPDATE,
                            FEC_LAST_UPDATE,
                            NUM_LAST_UPDATE_LOGIN,
                            ATRIBUTO1,
                            ATRIBUTO2,
                            ATRIBUTO3,
                            ATRIBUTO4,
                            ATRIBUTO5,
                            ATRIBUTO6,
                            ATRIBUTO7,
                            ATRIBUTO8,
                            ATRIBUTO9,
                            ATRIBUTO10,
                            ATRIBUTO11,
                            ATRIBUTO12,
                            ATRIBUTO13,
                            ATRIBUTO14,
                            ATRIBUTO15,
                            ATTRIBUTE_CATEGORY
                         )
                VALUES (
                         -1 ,
                        linIdNuevoParrillaSig,
                        ltbDetalle.ID_GENERO,
                        ltbDetalle.DES_CICLO ,
                        lstHoraInicioTmp,
                        lstHoraFinTmp,
                        lstHoraInicioTmp,
                        lstHoraFinTmp,
                        lstHoraInicioTmp,
                        lstHoraFinTmp,
                        ltbDetalle.ID_TIPO,
                        ltbDetalle.DES_PROGRAMA,
                        ltbDetalle.DES_PROGRAMA_ORIGINAL,
                        ltbDetalle.ID_CLASIFICACION,
                        ltbDetalle.ID_FORMATO,
                        ltbDetalle.ID_RESTRICCION,
                        ltbDetalle.DES_NOTAS,
                        ltbDetalle.NUM_TRANSMISIONES,
                        ltbDetalle.FEC_ULTIMA_TRANSMISION,
                        ltbDetalle.DES_ULTIMA_TRANSMISION,
                        ltbDetalle.NUM_COLOR,
                        ltbDetalle.NUM_SAP,
                        ltbDetalle.NUM_TEMPORADA,
                        ltbDetalle.NUM_REPETICION_TEMP,
                        ltbDetalle.COD_PROGRAMA_IBOPE,
                        ltbDetalle.DES_PROGRAMA_IBOPE,
                        ltbDetalle.ID_FUENTE,
                        ltbDetalle.ID_EVENTO,
                        ltbDetalle.DES_DESCRIPCION,
                        ltbDetalle.NUM_FUENTE_XLS,
                        ltbDetalle.NUM_CAMBIO_PROG,
                        ltbDetalle.FEC_CAMBIO_PROG,
                        ltbDetalle.DES_CAPITULO,
                        piinIdUsuario,
                        SYSDATE,
                        piinIdUsuario,
                        SYSDATE,
                        piinIdUsuario,
                        ltbDetalle.ATRIBUTO1,
                        ltbDetalle.ATRIBUTO2,
                        ltbDetalle.ATRIBUTO3,
                        ltbDetalle.ATRIBUTO4,
                        ltbDetalle.ATRIBUTO5,
                        ltbDetalle.ATRIBUTO6,
                        ltbDetalle.ATRIBUTO7,
                        ltbDetalle.ATRIBUTO8,
                        ltbDetalle.ATRIBUTO9,
                        ltbDetalle.ATRIBUTO10,
                        ltbDetalle.ATRIBUTO11,
                        ltbDetalle.ATRIBUTO12,
                        ltbDetalle.ATRIBUTO13,
                        ltbDetalle.ATRIBUTO14,
                        ltbDetalle.ATRIBUTO15,
                        ltbDetalle.ATTRIBUTE_CATEGORY
                        )
                 returning ID_PARRILLA_DET INTO linIdNuevoDetParrilla;
        ELSIF TO_NUMBER(REPLACE(ltbDetalle.DES_HORA_INICIO, ':','')) < 240000
        AND TO_NUMBER(REPLACE(ltbDetalle.DES_HORA_FIN, ':','')) > 240000 THEN
             IF SUBSTR(ltbDetalle.DES_HORA_FIN, 1, 2) = '24' THEN
                lstHoraFinTmp := REPLACE(ltbDetalle.DES_HORA_FIN, '24','00');
            ELSIF SUBSTR(ltbDetalle.DES_HORA_FIN, 1, 2) = '25' THEN
                lstHoraFinTmp := REPLACE(ltbDetalle.DES_HORA_FIN, '25','01');
            END IF;
        INSERT INTO  ADMP.ADMP_PARRILLA_DET_TAB  (
                        ID_PARRILLA_DET,
                        ID_PARRILLA,
                        ID_GENERO,
                        DES_CICLO,
                        DES_HORA_INICIO,
                        DES_HORA_FIN,
                        DES_HORA_INICIO_REAL,
                        DES_HORA_FIN_REAL,
                        DES_HORA_INICIO_ISO,
                        DES_HORA_FIN_ISO,
                        ID_TIPO,
                        DES_PROGRAMA,
                        DES_PROGRAMA_ORIGINAL,
                        ID_CLASIFICACION,
                        ID_FORMATO,
                        ID_RESTRICCION,
                        DES_NOTAS,
                        NUM_TRANSMISIONES,
                        FEC_ULTIMA_TRANSMISION,
                        DES_ULTIMA_TRANSMISION,
                        NUM_COLOR,
                        NUM_SAP,
                        NUM_TEMPORADA,
                        NUM_REPETICION_TEMP,
                        COD_PROGRAMA_IBOPE,
                        DES_PROGRAMA_IBOPE,
                        ID_FUENTE,
                        ID_EVENTO,
                        DES_DESCRIPCION,
                        NUM_FUENTE_XLS,
                        NUM_CAMBIO_PROG,
                        FEC_CAMBIO_PROG,
                        DES_CAPITULO,
                        NUM_CREATED_BY,
                        FEC_CREATION_DATE,
                        NUM_LAST_UPDATE,
                        FEC_LAST_UPDATE,
                        NUM_LAST_UPDATE_LOGIN,
                        ATRIBUTO1,
                        ATRIBUTO2,
                        ATRIBUTO3,
                        ATRIBUTO4,
                        ATRIBUTO5,
                        ATRIBUTO6,
                        ATRIBUTO7,
                        ATRIBUTO8,
                        ATRIBUTO9,
                        ATRIBUTO10,
                        ATRIBUTO11,
                        ATRIBUTO12,
                        ATRIBUTO13,
                        ATRIBUTO14,
                        ATRIBUTO15,
                        ATTRIBUTE_CATEGORY
                     )
            VALUES (
                    -1 ,
                    linIdNuevoParrilla,
                    ltbDetalle.ID_GENERO,
                    ltbDetalle.DES_CICLO ,
                    ltbDetalle.DES_HORA_INICIO,
                    '24:00:00',
                    ltbDetalle.DES_HORA_INICIO,
                    '24:00:00',
                    ltbDetalle.DES_HORA_INICIO,
                    '24:00:00',
                    ltbDetalle.ID_TIPO,
                    ltbDetalle.DES_PROGRAMA,
                    ltbDetalle.DES_PROGRAMA_ORIGINAL,
                    ltbDetalle.ID_CLASIFICACION,
                    ltbDetalle.ID_FORMATO,
                    ltbDetalle.ID_RESTRICCION,
                    ltbDetalle.DES_NOTAS,
                    ltbDetalle.NUM_TRANSMISIONES,
                    ltbDetalle.FEC_ULTIMA_TRANSMISION,
                    ltbDetalle.DES_ULTIMA_TRANSMISION,
                    ltbDetalle.NUM_COLOR,
                    ltbDetalle.NUM_SAP,
                    ltbDetalle.NUM_TEMPORADA,
                    ltbDetalle.NUM_REPETICION_TEMP,
                    ltbDetalle.COD_PROGRAMA_IBOPE,
                    ltbDetalle.DES_PROGRAMA_IBOPE,
                    ltbDetalle.ID_FUENTE,
                    ltbDetalle.ID_EVENTO,
                    ltbDetalle.DES_DESCRIPCION,
                    ltbDetalle.NUM_FUENTE_XLS,
                    ltbDetalle.NUM_CAMBIO_PROG,
                    ltbDetalle.FEC_CAMBIO_PROG,
                    ltbDetalle.DES_CAPITULO,
                    piinIdUsuario,
                    SYSDATE,
                    piinIdUsuario,
                    SYSDATE,
                    piinIdUsuario,
                    ltbDetalle.ATRIBUTO1,
                    ltbDetalle.ATRIBUTO2,
                    ltbDetalle.ATRIBUTO3,
                    ltbDetalle.ATRIBUTO4,
                    ltbDetalle.ATRIBUTO5,
                    ltbDetalle.ATRIBUTO6,
                    ltbDetalle.ATRIBUTO7,
                    ltbDetalle.ATRIBUTO8,
                    ltbDetalle.ATRIBUTO9,
                    ltbDetalle.ATRIBUTO10,
                    ltbDetalle.ATRIBUTO11,
                    ltbDetalle.ATRIBUTO12,
                    ltbDetalle.ATRIBUTO13,
                    ltbDetalle.ATRIBUTO14,
                    ltbDetalle.ATRIBUTO15,
                    ltbDetalle.ATTRIBUTE_CATEGORY
                    )
            returning ID_PARRILLA_DET INTO linIdNuevoDetParrilla;
            INSERT INTO  ADMP.ADMP_PARRILLA_DET_TAB  (
                        ID_PARRILLA_DET,
                        ID_PARRILLA,
                        ID_GENERO,
                        DES_CICLO,
                        DES_HORA_INICIO,
                        DES_HORA_FIN,
                        DES_HORA_INICIO_REAL,
                        DES_HORA_FIN_REAL,
                        DES_HORA_INICIO_ISO,
                        DES_HORA_FIN_ISO,
                        ID_TIPO,
                        DES_PROGRAMA,
                        DES_PROGRAMA_ORIGINAL,
                        ID_CLASIFICACION,
                        ID_FORMATO,
                        ID_RESTRICCION,
                        DES_NOTAS,
                        NUM_TRANSMISIONES,
                        FEC_ULTIMA_TRANSMISION,
                        DES_ULTIMA_TRANSMISION,
                        NUM_COLOR,
                        NUM_SAP,
                        NUM_TEMPORADA,
                        NUM_REPETICION_TEMP,
                        COD_PROGRAMA_IBOPE,
                        DES_PROGRAMA_IBOPE,
                        ID_FUENTE,
                        ID_EVENTO,
                        DES_DESCRIPCION,
                        NUM_FUENTE_XLS,
                        NUM_CAMBIO_PROG,
                        FEC_CAMBIO_PROG,
                        DES_CAPITULO,
                        NUM_CREATED_BY,
                        FEC_CREATION_DATE,
                        NUM_LAST_UPDATE,
                        FEC_LAST_UPDATE,
                        NUM_LAST_UPDATE_LOGIN,
                        ATRIBUTO1,
                        ATRIBUTO2,
                        ATRIBUTO3,
                        ATRIBUTO4,
                        ATRIBUTO5,
                        ATRIBUTO6,
                        ATRIBUTO7,
                        ATRIBUTO8,
                        ATRIBUTO9,
                        ATRIBUTO10,
                        ATRIBUTO11,
                        ATRIBUTO12,
                        ATRIBUTO13,
                        ATRIBUTO14,
                        ATRIBUTO15,
                        ATTRIBUTE_CATEGORY
                     )
                VALUES (
                         -1 ,
                        linIdNuevoParrillaSig,
                        ltbDetalle.ID_GENERO,
                        ltbDetalle.DES_CICLO ,
                        '00:00:00',
                        lstHoraFinTmp,
                        '00:00:00',
                        lstHoraFinTmp,
                        '00:00:00',
                        lstHoraFinTmp,
                        ltbDetalle.ID_TIPO,
                        ltbDetalle.DES_PROGRAMA,
                        ltbDetalle.DES_PROGRAMA_ORIGINAL,
                        ltbDetalle.ID_CLASIFICACION,
                        ltbDetalle.ID_FORMATO,
                        ltbDetalle.ID_RESTRICCION,
                        ltbDetalle.DES_NOTAS,
                        ltbDetalle.NUM_TRANSMISIONES,
                        ltbDetalle.FEC_ULTIMA_TRANSMISION,
                        ltbDetalle.DES_ULTIMA_TRANSMISION,
                        ltbDetalle.NUM_COLOR,
                        ltbDetalle.NUM_SAP,
                        ltbDetalle.NUM_TEMPORADA,
                        ltbDetalle.NUM_REPETICION_TEMP,
                        ltbDetalle.COD_PROGRAMA_IBOPE,
                        ltbDetalle.DES_PROGRAMA_IBOPE,
                        ltbDetalle.ID_FUENTE,
                        ltbDetalle.ID_EVENTO,
                        ltbDetalle.DES_DESCRIPCION,
                        ltbDetalle.NUM_FUENTE_XLS,
                        ltbDetalle.NUM_CAMBIO_PROG,
                        ltbDetalle.FEC_CAMBIO_PROG,
                        ltbDetalle.DES_CAPITULO,
                        piinIdUsuario,
                        SYSDATE,
                        piinIdUsuario,
                        SYSDATE,
                        piinIdUsuario,
                        ltbDetalle.ATRIBUTO1,
                        ltbDetalle.ATRIBUTO2,
                        ltbDetalle.ATRIBUTO3,
                        ltbDetalle.ATRIBUTO4,
                        ltbDetalle.ATRIBUTO5,
                        ltbDetalle.ATRIBUTO6,
                        ltbDetalle.ATRIBUTO7,
                        ltbDetalle.ATRIBUTO8,
                        ltbDetalle.ATRIBUTO9,
                        ltbDetalle.ATRIBUTO10,
                        ltbDetalle.ATRIBUTO11,
                        ltbDetalle.ATRIBUTO12,
                        ltbDetalle.ATRIBUTO13,
                        ltbDetalle.ATRIBUTO14,
                        ltbDetalle.ATRIBUTO15,
                        ltbDetalle.ATTRIBUTE_CATEGORY
                        )
                    returning ID_PARRILLA_DET INTO linIdNuevoDetParrilla;
            ELSE
                INSERT INTO  ADMP.ADMP_PARRILLA_DET_TAB  (
                    ID_PARRILLA_DET,
                    ID_PARRILLA,
                    ID_GENERO,
                    DES_CICLO,
                    DES_HORA_INICIO,
                    DES_HORA_FIN,
                    DES_HORA_INICIO_REAL,
                    DES_HORA_FIN_REAL,
                    DES_HORA_INICIO_ISO,
                    DES_HORA_FIN_ISO,
                    ID_TIPO,
                    DES_PROGRAMA,
                    DES_PROGRAMA_ORIGINAL,
                    ID_CLASIFICACION,
                    ID_FORMATO,
                    ID_RESTRICCION,
                    DES_NOTAS,
                    NUM_TRANSMISIONES,
                    FEC_ULTIMA_TRANSMISION,
                    DES_ULTIMA_TRANSMISION,
                    NUM_COLOR,
                    NUM_SAP,
                    NUM_TEMPORADA,
                    NUM_REPETICION_TEMP,
                    COD_PROGRAMA_IBOPE,
                    DES_PROGRAMA_IBOPE,
                    ID_FUENTE,
                    ID_EVENTO,
                    DES_DESCRIPCION,
                    NUM_FUENTE_XLS,
                    NUM_CAMBIO_PROG,
                    FEC_CAMBIO_PROG,
                    DES_CAPITULO,
                    NUM_CREATED_BY,
                    FEC_CREATION_DATE,
                    NUM_LAST_UPDATE,
                    FEC_LAST_UPDATE,
                    NUM_LAST_UPDATE_LOGIN,
                    ATRIBUTO1,
                    ATRIBUTO2,
                    ATRIBUTO3,
                    ATRIBUTO4,
                    ATRIBUTO5,
                    ATRIBUTO6,
                    ATRIBUTO7,
                    ATRIBUTO8,
                    ATRIBUTO9,
                    ATRIBUTO10,
                    ATRIBUTO11,
                    ATRIBUTO12,
                    ATRIBUTO13,
                    ATRIBUTO14,
                    ATRIBUTO15,
                    ATTRIBUTE_CATEGORY
                    )
             VALUES (
                     -1 ,
                    linIdNuevoParrilla,
                    ltbDetalle.ID_GENERO,
                    ltbDetalle.DES_CICLO ,
                    ltbDetalle.DES_HORA_INICIO,
                    ltbDetalle.DES_HORA_FIN,
                    ltbDetalle.DES_HORA_INICIO,
                    ltbDetalle.DES_HORA_FIN,
                    ltbDetalle.DES_HORA_INICIO,
                    ltbDetalle.DES_HORA_FIN,
                    ltbDetalle.ID_TIPO,
                    ltbDetalle.DES_PROGRAMA,
                    ltbDetalle.DES_PROGRAMA_ORIGINAL,
                    ltbDetalle.ID_CLASIFICACION,
                    ltbDetalle.ID_FORMATO,
                    ltbDetalle.ID_RESTRICCION,
                    ltbDetalle.DES_NOTAS,
                    ltbDetalle.NUM_TRANSMISIONES,
                    ltbDetalle.FEC_ULTIMA_TRANSMISION,
                    ltbDetalle.DES_ULTIMA_TRANSMISION,
                    ltbDetalle.NUM_COLOR,
                    ltbDetalle.NUM_SAP,
                    ltbDetalle.NUM_TEMPORADA,
                    ltbDetalle.NUM_REPETICION_TEMP,
                    ltbDetalle.COD_PROGRAMA_IBOPE,
                    ltbDetalle.DES_PROGRAMA_IBOPE,
                    ltbDetalle.ID_FUENTE,
                    ltbDetalle.ID_EVENTO,
                    ltbDetalle.DES_DESCRIPCION,
                    ltbDetalle.NUM_FUENTE_XLS,
                    ltbDetalle.NUM_CAMBIO_PROG,
                    ltbDetalle.FEC_CAMBIO_PROG,
                    ltbDetalle.DES_CAPITULO,
                    piinIdUsuario,
                    SYSDATE,
                    piinIdUsuario,
                    SYSDATE,
                    piinIdUsuario,
                    ltbDetalle.ATRIBUTO1,
                    ltbDetalle.ATRIBUTO2,
                    ltbDetalle.ATRIBUTO3,
                    ltbDetalle.ATRIBUTO4,
                    ltbDetalle.ATRIBUTO5,
                    ltbDetalle.ATRIBUTO6,
                    ltbDetalle.ATRIBUTO7,
                    ltbDetalle.ATRIBUTO8,
                    ltbDetalle.ATRIBUTO9,
                    ltbDetalle.ATRIBUTO10,
                    ltbDetalle.ATRIBUTO11,
                    ltbDetalle.ATRIBUTO12,
                    ltbDetalle.ATRIBUTO13,
                    ltbDetalle.ATRIBUTO14,
                    ltbDetalle.ATRIBUTO15,
                    ltbDetalle.ATTRIBUTE_CATEGORY
                    )
            returning ID_PARRILLA_DET INTO linIdNuevoDetParrilla;
            END IF;
            END IF;
         END LOOP;
         END IF;
            ldtFechaIntervalo := ldtFechaIntervalo + 1;
            linIntervalo := linIntervalo - 1;
            EXIT;
         END LOOP;
         CLOSE lcurCabecero;
         CLOSE lcurCabeceroSiguiente;
         IF linIntervalo < 0 THEN
            EXIT;
         END IF;
       END;
        END LOOP;
    END;
    ELSIF pistIdAccion = 'S' THEN
    DECLARE
        linIntervalo NUMBER := 0;
        ldtFechaIntervalo DATE := TO_DATE(pistFechaIniDestino, 'dd/mm/yyyy');
        ldtFechaInicio DATE := TO_DATE(pistFechaIniOrigen, 'dd/mm/yyyy');
        linIdNuevoParrilla NUMBER :=-1;
        linIdNuevoParrillaSig NUMBER :=-1;
        linIdNuevoDetParrilla NUMBER :=-1;
        linIdParrillaOrigen NUMBER :=0;
        linIdParrillaUltimo NUMBER :=0;
        linIdParrillaInicio NUMBER :=0;
        BEGIN
        FOR ltbRec IN(
            SELECT  ID_PARRILLA_DET
            FROM(
            SELECT * FROM ADMP.ADMP_PARRILLA_COPIA_VW
            WHERE ID_CANAL = piinIdCanalDestino
            AND    FEC_PARRILLA
            BETWEEN (TO_DATE(pistFechaIniDestino, 'dd/mm/yyyy')+1)
            AND    TO_DATE(pistFechaFinDestino, 'dd/mm/yyyy')
            AND    ID_TIPO_PARRILLA = piinIdTipoParrillaDestino
            AND    DES_HORA_INICIO < '01:00:00'
            UNION
            SELECT * FROM ADMP.ADMP_PARRILLA_COPIA_VW
            WHERE ID_CANAL = piinIdCanalDestino
            AND  FEC_PARRILLA BETWEEN TO_DATE(pistFechaIniDestino, 'dd/mm/yyyy')
            AND  TO_DATE(pistFechaFinDestino, 'dd/mm/yyyy')
            AND  ID_TIPO_PARRILLA = piinIdTipoParrillaDestino
            AND  DES_HORA_INICIO < '06:00:00'
            AND  DES_HORA_FIN > '06:00:00'
            UNION
            SELECT * FROM ADMP.ADMP_PARRILLA_COPIA_VW
            WHERE ID_CANAL = piinIdCanalDestino
            AND  FEC_PARRILLA BETWEEN TO_DATE(pistFechaIniDestino, 'dd/mm/yyyy')
            AND  TO_DATE(pistFechaFinDestino, 'dd/mm/yyyy')
            AND  ID_TIPO_PARRILLA = piinIdTipoParrillaDestino
            AND  DES_HORA_INICIO >= '06:00:00'
            UNION
            SELECT * FROM ADMP.ADMP_PARRILLA_COPIA_VW
            WHERE ID_CANAL = piinIdCanalDestino
            AND    FEC_PARRILLA = (TO_DATE(pistFechaFinDestino, 'dd/mm/yyyy')+1)
            AND    ID_TIPO_PARRILLA = piinIdTipoParrillaDestino
            AND    DES_HORA_FIN <= '01:00:00')
        )
        LOOP
            DELETE ADMP.ADMP_TARGET_PARR_DET_TAB
                WHERE ID_PARRILLA_DET = ltbRec.id_parrilla_det;
            DELETE ADMP.ADMP_PARRILLA_DET_TAB
                WHERE ID_PARRILLA_DET = ltbRec.id_parrilla_det;
        END LOOP;
    SELECT TO_DATE(pistFechaFinOrigen, 'dd/mm/yyyy')
        - TO_DATE(pistFechaIniOrigen, 'dd/mm/yyyy') INTO linIntervalo FROM DUAL;
    LOOP
        BEGIN
            SELECT id_parrilla INTO linIdParrillaOrigen
            FROM ADMP.ADMP_PARRILLA_TAB
            WHERE fec_parrilla = ldtFechaInicio
            AND ID_CANAL = piinIdCanalOrigen
            AND ID_TIPO_PARRILLA = piinIdTipoParrilla;
        EXCEPTION WHEN no_data_found THEN
            linIdParrillaOrigen := NULL;
        END;
        DECLARE
            ltbCab   ADMP.ADMP_PARRILLA_TAB%ROWTYPE;
            ltbNext  ADMP.ADMP_PARRILLA_TAB%ROWTYPE;
            lstHoraInicioTmp VARCHAR(8) :=-1;
            lstHoraFinTmp VARCHAR(8) :=-1;
            CURSOR lcurCabecero IS
                SELECT * FROM ADMP.ADMP_PARRILLA_TAB
                WHERE FEC_PARRILLA = ldtFechaIntervalo
                AND ID_CANAL = piinIdCanalDestino
                AND ID_TIPO_PARRILLA = piinIdTipoParrillaDestino;
            CURSOR lcurCabeceroSiguiente IS
                SELECT * FROM ADMP.ADMP_PARRILLA_TAB
                WHERE FEC_PARRILLA = (ldtFechaIntervalo + 1)
                AND ID_CANAL = piinIdCanalDestino
                AND ID_TIPO_PARRILLA = piinIdTipoParrillaDestino;
    BEGIN
        OPEN lcurCabecero;
        OPEN lcurCabeceroSiguiente;
        LOOP
            FETCH lcurCabecero INTO ltbCab;
            FETCH lcurCabeceroSiguiente INTO ltbNext;
            IF lcurCabecero%NOTFOUND THEN
            IF linIdParrillaOrigen IS NOT NULL THEN
            INSERT INTO ADMP.ADMP_PARRILLA_TAB(
                id_parrilla,
                fec_parrilla,
                id_canal,
                num_version,
                id_estado,
                num_created_by,
                fec_creation_DATE,
                num_last_upDATE,
                fec_last_upDATE,
                num_last_upDATE_login,
                atributo1,
                atributo2,
                atributo3,
                atributo4,
                atributo5,
                atributo6,
                atributo7,
                atributo8,
                atributo9,
                atributo10,
                atributo11,
                atributo12,
                atributo13,
                atributo14,
                atributo15,
                attribute_category,
                id_tipo_parrilla
                )
        VALUES(
                -1 ,
                ldtFechaIntervalo,
                piinIdCanalDestino,
                1,
                1,
                piinIdUsuario,
                SYSDATE,
                piinIdUsuario,
                SYSDATE,
                piinIdUsuario,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                NULL,
                piinIdTipoParrillaDestino
                )
            returning id_parrilla INTO linIdNuevoParrilla;
            END IF;
        ELSE
        linIdNuevoParrilla := ltbCab.ID_PARRILLA;
        END IF;
     IF lcurCabeceroSiguiente%NOTFOUND THEN
     IF linIdParrillaOrigen IS NOT NULL THEN
        INSERT INTO ADMP.ADMP_PARRILLA_TAB(
            id_parrilla,
            fec_parrilla,
            id_canal,
            num_version,
            id_estado,
            num_created_by,
            fec_creation_DATE,
            num_last_upDATE,
            fec_last_upDATE,
            num_last_upDATE_login,
            atributo1,
            atributo2,
            atributo3,
            atributo4,
            atributo5,
            atributo6,
            atributo7,
            atributo8,
            atributo9,
            atributo10,
            atributo11,
            atributo12,
            atributo13,
            atributo14,
            atributo15,
            attribute_category,
            id_tipo_parrilla
            )
     VALUES(
            -1 ,
            (ldtFechaIntervalo + 1),
            piinIdCanalDestino,
            1,
            1,
            piinIdUsuario,
            SYSDATE,
            piinIdUsuario,
            SYSDATE,
            piinIdUsuario,
            NULL,
            NULL,
            NULL,
            NULL,
            NULL,
            NULL,
            NULL,
            NULL,
            NULL,
            NULL,
            NULL,
            NULL,
            NULL,
            NULL,
            NULL,
            NULL,
            piinIdTipoParrillaDestino
            )
        returning id_parrilla INTO linIdNuevoParrillaSig;
        END IF;
     ELSE
        linIdNuevoParrillaSig := ltbNext.ID_PARRILLA;
        END IF;
        IF linIdParrillaOrigen IS NOT NULL THEN
        FOR ltbDetalle IN (
            SELECT  ID_PARRILLA_DET,
                    ID_PARRILLA,
                    ID_GENERO,
                    DES_CICLO ,
                    DES_HORA_INICIO,
                    DES_HORA_FIN,
                    DES_HORA_INICIO_REAL,
                    DES_HORA_FIN_REAL,
                    DES_HORA_INICIO_ISO,
                    DES_HORA_FIN_ISO,
                    ID_TIPO,
                    DES_PROGRAMA,
                    DES_PROGRAMA_ORIGINAL,
                    ID_CLASIFICACION,
                    ID_FORMATO,
                    ID_RESTRICCION,
                    DES_NOTAS,
                    NUM_TRANSMISIONES,
                    FEC_ULTIMA_TRANSMISION,
                    DES_ULTIMA_TRANSMISION,
                    NUM_COLOR,
                    NUM_SAP,
                    NUM_TEMPORADA,
                    NUM_REPETICION_TEMP,
                    COD_PROGRAMA_IBOPE,
                    DES_PROGRAMA_IBOPE,
                    ID_FUENTE,
                    ID_EVENTO,
                    DES_DESCRIPCION,
                    NUM_FUENTE_XLS,
                    NUM_CAMBIO_PROG,
                    FEC_CAMBIO_PROG,
                    DES_CAPITULO,
                    NUM_CREATED_BY,
                    FEC_CREATION_DATE,
                    NUM_LAST_UPDATE,
                    FEC_LAST_UPDATE,
                    NUM_LAST_UPDATE_LOGIN,
                    ATRIBUTO1,
                    ATRIBUTO2,
                    ATRIBUTO3,
                    ATRIBUTO4,
                    ATRIBUTO5,
                    ATRIBUTO6,
                    ATRIBUTO7,
                    ATRIBUTO8,
                    ATRIBUTO9,
                    ATRIBUTO10,
                    ATRIBUTO11,
                    ATRIBUTO12,
                    ATRIBUTO13,
                    ATRIBUTO14,
                    ATRIBUTO15,
                    ATTRIBUTE_CATEGORY
                FROM    ADMP.ADMP_PARRILLA_DET_TAB
                WHERE   ID_PARRILLA = linIdParrillaOrigen
                )
            LOOP
        IF TO_NUMBER(REPLACE(ltbDetalle.DES_HORA_INICIO, ':','')) >= 240000
        AND TO_NUMBER(REPLACE(ltbDetalle.DES_HORA_FIN, ':','')) <= 250000 THEN
            IF SUBSTR(ltbDetalle.DES_HORA_INICIO, 1, 2) = '24' THEN
                lstHoraInicioTmp := REPLACE(ltbDetalle.DES_HORA_INICIO, '24','00');
            ELSIF SUBSTR(ltbDetalle.DES_HORA_INICIO, 1, 2) = '25' THEN
                lstHoraInicioTmp := REPLACE(ltbDetalle.DES_HORA_INICIO, '25','01');
            END IF;
            IF SUBSTR(ltbDetalle.DES_HORA_FIN, 1, 2) = '24' THEN
                lstHoraFinTmp := REPLACE(ltbDetalle.DES_HORA_FIN, '24','00');
            ELSIF SUBSTR(ltbDetalle.DES_HORA_FIN, 1, 2) = '25' THEN
                lstHoraFinTmp := REPLACE(ltbDetalle.DES_HORA_FIN, '25','01');
            END IF;
        INSERT INTO  ADMP.ADMP_PARRILLA_DET_TAB  (
                            ID_PARRILLA_DET,
                            ID_PARRILLA,
                            ID_GENERO,
                            DES_CICLO,
                            DES_HORA_INICIO,
                            DES_HORA_FIN,
                            DES_HORA_INICIO_REAL,
                            DES_HORA_FIN_REAL,
                            DES_HORA_INICIO_ISO,
                            DES_HORA_FIN_ISO,
                            ID_TIPO,
                            DES_PROGRAMA,
                            DES_PROGRAMA_ORIGINAL,
                            ID_CLASIFICACION,
                            ID_FORMATO,
                            ID_RESTRICCION,
                            DES_NOTAS,
                            NUM_TRANSMISIONES,
                            FEC_ULTIMA_TRANSMISION,
                            DES_ULTIMA_TRANSMISION,
                            NUM_COLOR,
                            NUM_SAP,
                            NUM_TEMPORADA,
                            NUM_REPETICION_TEMP,
                            COD_PROGRAMA_IBOPE,
                            DES_PROGRAMA_IBOPE,
                            ID_FUENTE,
                            ID_EVENTO,
                            DES_DESCRIPCION,
                            NUM_FUENTE_XLS,
                            NUM_CAMBIO_PROG,
                            FEC_CAMBIO_PROG,
                            DES_CAPITULO,
                            NUM_CREATED_BY,
                            FEC_CREATION_DATE,
                            NUM_LAST_UPDATE,
                            FEC_LAST_UPDATE,
                            NUM_LAST_UPDATE_LOGIN,
                            ATRIBUTO1,
                            ATRIBUTO2,
                            ATRIBUTO3,
                            ATRIBUTO4,
                            ATRIBUTO5,
                            ATRIBUTO6,
                            ATRIBUTO7,
                            ATRIBUTO8,
                            ATRIBUTO9,
                            ATRIBUTO10,
                            ATRIBUTO11,
                            ATRIBUTO12,
                            ATRIBUTO13,
                            ATRIBUTO14,
                            ATRIBUTO15,
                            ATTRIBUTE_CATEGORY
                         )
                VALUES (
                         -1 ,
                        linIdNuevoParrillaSig,
                        ltbDetalle.ID_GENERO,
                        ltbDetalle.DES_CICLO ,
                        lstHoraInicioTmp,
                        lstHoraFinTmp,
                        lstHoraInicioTmp,
                        lstHoraFinTmp,
                        lstHoraInicioTmp,
                        lstHoraFinTmp,
                        ltbDetalle.ID_TIPO,
                        ltbDetalle.DES_PROGRAMA,
                        ltbDetalle.DES_PROGRAMA_ORIGINAL,
                        ltbDetalle.ID_CLASIFICACION,
                        ltbDetalle.ID_FORMATO,
                        ltbDetalle.ID_RESTRICCION,
                        ltbDetalle.DES_NOTAS,
                        ltbDetalle.NUM_TRANSMISIONES,
                        ltbDetalle.FEC_ULTIMA_TRANSMISION,
                        ltbDetalle.DES_ULTIMA_TRANSMISION,
                        ltbDetalle.NUM_COLOR,
                        ltbDetalle.NUM_SAP,
                        ltbDetalle.NUM_TEMPORADA,
                        ltbDetalle.NUM_REPETICION_TEMP,
                        ltbDetalle.COD_PROGRAMA_IBOPE,
                        ltbDetalle.DES_PROGRAMA_IBOPE,
                        ltbDetalle.ID_FUENTE,
                        ltbDetalle.ID_EVENTO,
                        ltbDetalle.DES_DESCRIPCION,
                        ltbDetalle.NUM_FUENTE_XLS,
                        ltbDetalle.NUM_CAMBIO_PROG,
                        ltbDetalle.FEC_CAMBIO_PROG,
                        ltbDetalle.DES_CAPITULO,
                        piinIdUsuario,
                        SYSDATE,
                        piinIdUsuario,
                        SYSDATE,
                        piinIdUsuario,
                        ltbDetalle.ATRIBUTO1,
                        ltbDetalle.ATRIBUTO2,
                        ltbDetalle.ATRIBUTO3,
                        ltbDetalle.ATRIBUTO4,
                        ltbDetalle.ATRIBUTO5,
                        ltbDetalle.ATRIBUTO6,
                        ltbDetalle.ATRIBUTO7,
                        ltbDetalle.ATRIBUTO8,
                        ltbDetalle.ATRIBUTO9,
                        ltbDetalle.ATRIBUTO10,
                        ltbDetalle.ATRIBUTO11,
                        ltbDetalle.ATRIBUTO12,
                        ltbDetalle.ATRIBUTO13,
                        ltbDetalle.ATRIBUTO14,
                        ltbDetalle.ATRIBUTO15,
                        ltbDetalle.ATTRIBUTE_CATEGORY
                        )
                    returning ID_PARRILLA_DET INTO linIdNuevoDetParrilla;
        ELSIF TO_NUMBER(REPLACE(ltbDetalle.DES_HORA_INICIO, ':','')) < 240000
        AND TO_NUMBER(REPLACE(ltbDetalle.DES_HORA_FIN, ':','')) > 240000  THEN
        IF SUBSTR(ltbDetalle.DES_HORA_FIN, 1, 2) = '24' THEN
            lstHoraFinTmp := REPLACE(ltbDetalle.DES_HORA_FIN, '24','00');
        ELSIF SUBSTR(ltbDetalle.DES_HORA_FIN, 1, 2) = '25' THEN
            lstHoraFinTmp := REPLACE(ltbDetalle.DES_HORA_FIN, '25','01');
        END IF;
        INSERT INTO  ADMP.ADMP_PARRILLA_DET_TAB  (
                                    ID_PARRILLA_DET,
                                    ID_PARRILLA,
                                    ID_GENERO,
                                    DES_CICLO,
                                    DES_HORA_INICIO,
                                    DES_HORA_FIN,
                                    DES_HORA_INICIO_REAL,
                                    DES_HORA_FIN_REAL,
                                    DES_HORA_INICIO_ISO,
                                    DES_HORA_FIN_ISO,
                                    ID_TIPO,
                                    DES_PROGRAMA,
                                    DES_PROGRAMA_ORIGINAL,
                                    ID_CLASIFICACION,
                                    ID_FORMATO,
                                    ID_RESTRICCION,
                                    DES_NOTAS,
                                    NUM_TRANSMISIONES,
                                    FEC_ULTIMA_TRANSMISION,
                                    DES_ULTIMA_TRANSMISION,
                                    NUM_COLOR,
                                    NUM_SAP,
                                    NUM_TEMPORADA,
                                    NUM_REPETICION_TEMP,
                                    COD_PROGRAMA_IBOPE,
                                    DES_PROGRAMA_IBOPE,
                                    ID_FUENTE,
                                    ID_EVENTO,
                                    DES_DESCRIPCION,
                                    NUM_FUENTE_XLS,
                                    NUM_CAMBIO_PROG,
                                    FEC_CAMBIO_PROG,
                                    DES_CAPITULO,
                                    NUM_CREATED_BY,
                                    FEC_CREATION_DATE,
                                    NUM_LAST_UPDATE,
                                    FEC_LAST_UPDATE,
                                    NUM_LAST_UPDATE_LOGIN,
                                    ATRIBUTO1,
                                    ATRIBUTO2,
                                    ATRIBUTO3,
                                    ATRIBUTO4,
                                    ATRIBUTO5,
                                    ATRIBUTO6,
                                    ATRIBUTO7,
                                    ATRIBUTO8,
                                    ATRIBUTO9,
                                    ATRIBUTO10,
                                    ATRIBUTO11,
                                    ATRIBUTO12,
                                    ATRIBUTO13,
                                    ATRIBUTO14,
                                    ATRIBUTO15,
                                    ATTRIBUTE_CATEGORY
                                 )
                         VALUES (
                                 -1 ,
                                linIdNuevoParrilla,
                                ltbDetalle.ID_GENERO,
                                ltbDetalle.DES_CICLO ,
                                ltbDetalle.DES_HORA_INICIO,
                                '24:00:00',
                                ltbDetalle.DES_HORA_INICIO,
                                '24:00:00',
                                ltbDetalle.DES_HORA_INICIO,
                                '24:00:00',
                                ltbDetalle.ID_TIPO,
                                ltbDetalle.DES_PROGRAMA,
                                ltbDetalle.DES_PROGRAMA_ORIGINAL,
                                ltbDetalle.ID_CLASIFICACION,
                                ltbDetalle.ID_FORMATO,
                                ltbDetalle.ID_RESTRICCION,
                                ltbDetalle.DES_NOTAS,
                                ltbDetalle.NUM_TRANSMISIONES,
                                ltbDetalle.FEC_ULTIMA_TRANSMISION,
                                ltbDetalle.DES_ULTIMA_TRANSMISION,
                                ltbDetalle.NUM_COLOR,
                                ltbDetalle.NUM_SAP,
                                ltbDetalle.NUM_TEMPORADA,
                                ltbDetalle.NUM_REPETICION_TEMP,
                                ltbDetalle.COD_PROGRAMA_IBOPE,
                                ltbDetalle.DES_PROGRAMA_IBOPE,
                                ltbDetalle.ID_FUENTE,
                                ltbDetalle.ID_EVENTO,
                                ltbDetalle.DES_DESCRIPCION,
                                ltbDetalle.NUM_FUENTE_XLS,
                                ltbDetalle.NUM_CAMBIO_PROG,
                                ltbDetalle.FEC_CAMBIO_PROG,
                                ltbDetalle.DES_CAPITULO,
                                piinIdUsuario,
                                SYSDATE,
                                piinIdUsuario,
                                SYSDATE,
                                piinIdUsuario,
                                ltbDetalle.ATRIBUTO1,
                                ltbDetalle.ATRIBUTO2,
                                ltbDetalle.ATRIBUTO3,
                                ltbDetalle.ATRIBUTO4,
                                ltbDetalle.ATRIBUTO5,
                                ltbDetalle.ATRIBUTO6,
                                ltbDetalle.ATRIBUTO7,
                                ltbDetalle.ATRIBUTO8,
                                ltbDetalle.ATRIBUTO9,
                                ltbDetalle.ATRIBUTO10,
                                ltbDetalle.ATRIBUTO11,
                                ltbDetalle.ATRIBUTO12,
                                ltbDetalle.ATRIBUTO13,
                                ltbDetalle.ATRIBUTO14,
                                ltbDetalle.ATRIBUTO15,
                                ltbDetalle.ATTRIBUTE_CATEGORY
                                )
                          returning ID_PARRILLA_DET INTO linIdNuevoDetParrilla;
            INSERT INTO  ADMP.ADMP_PARRILLA_DET_TAB  (
                                    ID_PARRILLA_DET,
                                    ID_PARRILLA,
                                    ID_GENERO,
                                    DES_CICLO,
                                    DES_HORA_INICIO,
                                    DES_HORA_FIN,
                                    DES_HORA_INICIO_REAL,
                                    DES_HORA_FIN_REAL,
                                    DES_HORA_INICIO_ISO,
                                    DES_HORA_FIN_ISO,
                                    ID_TIPO,
                                    DES_PROGRAMA,
                                    DES_PROGRAMA_ORIGINAL,
                                    ID_CLASIFICACION,
                                    ID_FORMATO,
                                    ID_RESTRICCION,
                                    DES_NOTAS,
                                    NUM_TRANSMISIONES,
                                    FEC_ULTIMA_TRANSMISION,
                                    DES_ULTIMA_TRANSMISION,
                                    NUM_COLOR,
                                    NUM_SAP,
                                    NUM_TEMPORADA,
                                    NUM_REPETICION_TEMP,
                                    COD_PROGRAMA_IBOPE,
                                    DES_PROGRAMA_IBOPE,
                                    ID_FUENTE,
                                    ID_EVENTO,
                                    DES_DESCRIPCION,
                                    NUM_FUENTE_XLS,
                                    NUM_CAMBIO_PROG,
                                    FEC_CAMBIO_PROG,
                                    DES_CAPITULO,
                                    NUM_CREATED_BY,
                                    FEC_CREATION_DATE,
                                    NUM_LAST_UPDATE,
                                    FEC_LAST_UPDATE,
                                    NUM_LAST_UPDATE_LOGIN,
                                    ATRIBUTO1,
                                    ATRIBUTO2,
                                    ATRIBUTO3,
                                    ATRIBUTO4,
                                    ATRIBUTO5,
                                    ATRIBUTO6,
                                    ATRIBUTO7,
                                    ATRIBUTO8,
                                    ATRIBUTO9,
                                    ATRIBUTO10,
                                    ATRIBUTO11,
                                    ATRIBUTO12,
                                    ATRIBUTO13,
                                    ATRIBUTO14,
                                    ATRIBUTO15,
                                    ATTRIBUTE_CATEGORY
                                 )
                        VALUES (
                                 -1 ,
                                linIdNuevoParrillaSig,
                                ltbDetalle.ID_GENERO,
                                ltbDetalle.DES_CICLO ,
                                '00:00:00',
                                lstHoraFinTmp,
                                '00:00:00',
                                lstHoraFinTmp,
                                '00:00:00',
                                lstHoraFinTmp,
                                ltbDetalle.ID_TIPO,
                                ltbDetalle.DES_PROGRAMA,
                                ltbDetalle.DES_PROGRAMA_ORIGINAL,
                                ltbDetalle.ID_CLASIFICACION,
                                ltbDetalle.ID_FORMATO,
                                ltbDetalle.ID_RESTRICCION,
                                ltbDetalle.DES_NOTAS,
                                ltbDetalle.NUM_TRANSMISIONES,
                                ltbDetalle.FEC_ULTIMA_TRANSMISION,
                                ltbDetalle.DES_ULTIMA_TRANSMISION,
                                ltbDetalle.NUM_COLOR,
                                ltbDetalle.NUM_SAP,
                                ltbDetalle.NUM_TEMPORADA,
                                ltbDetalle.NUM_REPETICION_TEMP,
                                ltbDetalle.COD_PROGRAMA_IBOPE,
                                ltbDetalle.DES_PROGRAMA_IBOPE,
                                ltbDetalle.ID_FUENTE,
                                ltbDetalle.ID_EVENTO,
                                ltbDetalle.DES_DESCRIPCION,
                                ltbDetalle.NUM_FUENTE_XLS,
                                ltbDetalle.NUM_CAMBIO_PROG,
                                ltbDetalle.FEC_CAMBIO_PROG,
                                ltbDetalle.DES_CAPITULO,
                                piinIdUsuario,
                                SYSDATE,
                                piinIdUsuario,
                                SYSDATE,
                                piinIdUsuario,
                                ltbDetalle.ATRIBUTO1,
                                ltbDetalle.ATRIBUTO2,
                                ltbDetalle.ATRIBUTO3,
                                ltbDetalle.ATRIBUTO4,
                                ltbDetalle.ATRIBUTO5,
                                ltbDetalle.ATRIBUTO6,
                                ltbDetalle.ATRIBUTO7,
                                ltbDetalle.ATRIBUTO8,
                                ltbDetalle.ATRIBUTO9,
                                ltbDetalle.ATRIBUTO10,
                                ltbDetalle.ATRIBUTO11,
                                ltbDetalle.ATRIBUTO12,
                                ltbDetalle.ATRIBUTO13,
                                ltbDetalle.ATRIBUTO14,
                                ltbDetalle.ATRIBUTO15,
                                ltbDetalle.ATTRIBUTE_CATEGORY
                                )
                          returning ID_PARRILLA_DET INTO linIdNuevoDetParrilla;
                    ELSE
                    INSERT INTO  ADMP.ADMP_PARRILLA_DET_TAB  (
                        ID_PARRILLA_DET,
                        ID_PARRILLA,
                        ID_GENERO,
                        DES_CICLO,
                        DES_HORA_INICIO,
                        DES_HORA_FIN,
                        DES_HORA_INICIO_REAL,
                        DES_HORA_FIN_REAL,
                        DES_HORA_INICIO_ISO,
                        DES_HORA_FIN_ISO,
                        ID_TIPO,
                        DES_PROGRAMA,
                        DES_PROGRAMA_ORIGINAL,
                        ID_CLASIFICACION,
                        ID_FORMATO,
                        ID_RESTRICCION,
                        DES_NOTAS,
                        NUM_TRANSMISIONES,
                        FEC_ULTIMA_TRANSMISION,
                        DES_ULTIMA_TRANSMISION,
                        NUM_COLOR,
                        NUM_SAP,
                        NUM_TEMPORADA,
                        NUM_REPETICION_TEMP,
                        COD_PROGRAMA_IBOPE,
                        DES_PROGRAMA_IBOPE,
                        ID_FUENTE,
                        ID_EVENTO,
                        DES_DESCRIPCION,
                        NUM_FUENTE_XLS,
                        NUM_CAMBIO_PROG,
                        FEC_CAMBIO_PROG,
                        DES_CAPITULO,
                        NUM_CREATED_BY,
                        FEC_CREATION_DATE,
                        NUM_LAST_UPDATE,
                        FEC_LAST_UPDATE,
                        NUM_LAST_UPDATE_LOGIN,
                        ATRIBUTO1,
                        ATRIBUTO2,
                        ATRIBUTO3,
                        ATRIBUTO4,
                        ATRIBUTO5,
                        ATRIBUTO6,
                        ATRIBUTO7,
                        ATRIBUTO8,
                        ATRIBUTO9,
                        ATRIBUTO10,
                        ATRIBUTO11,
                        ATRIBUTO12,
                        ATRIBUTO13,
                        ATRIBUTO14,
                        ATRIBUTO15,
                        ATTRIBUTE_CATEGORY
                     )
         VALUES (
                 -1 ,
                linIdNuevoParrilla,
                ltbDetalle.ID_GENERO,
                ltbDetalle.DES_CICLO ,
                ltbDetalle.DES_HORA_INICIO,
                ltbDetalle.DES_HORA_FIN,
                ltbDetalle.DES_HORA_INICIO,
                ltbDetalle.DES_HORA_FIN,
                ltbDetalle.DES_HORA_INICIO,
                ltbDetalle.DES_HORA_FIN,
                ltbDetalle.ID_TIPO,
                ltbDetalle.DES_PROGRAMA,
                ltbDetalle.DES_PROGRAMA_ORIGINAL,
                ltbDetalle.ID_CLASIFICACION,
                ltbDetalle.ID_FORMATO,
                ltbDetalle.ID_RESTRICCION,
                ltbDetalle.DES_NOTAS,
                ltbDetalle.NUM_TRANSMISIONES,
                ltbDetalle.FEC_ULTIMA_TRANSMISION,
                ltbDetalle.DES_ULTIMA_TRANSMISION,
                ltbDetalle.NUM_COLOR,
                ltbDetalle.NUM_SAP,
                ltbDetalle.NUM_TEMPORADA,
                ltbDetalle.NUM_REPETICION_TEMP,
                ltbDetalle.COD_PROGRAMA_IBOPE,
                ltbDetalle.DES_PROGRAMA_IBOPE,
                ltbDetalle.ID_FUENTE,
                ltbDetalle.ID_EVENTO,
                ltbDetalle.DES_DESCRIPCION,
                ltbDetalle.NUM_FUENTE_XLS,
                ltbDetalle.NUM_CAMBIO_PROG,
                ltbDetalle.FEC_CAMBIO_PROG,
                ltbDetalle.DES_CAPITULO,
                piinIdUsuario,
                SYSDATE,
                piinIdUsuario,
                SYSDATE,
                piinIdUsuario,
                ltbDetalle.ATRIBUTO1,
                ltbDetalle.ATRIBUTO2,
                ltbDetalle.ATRIBUTO3,
                ltbDetalle.ATRIBUTO4,
                ltbDetalle.ATRIBUTO5,
                ltbDetalle.ATRIBUTO6,
                ltbDetalle.ATRIBUTO7,
                ltbDetalle.ATRIBUTO8,
                ltbDetalle.ATRIBUTO9,
                ltbDetalle.ATRIBUTO10,
                ltbDetalle.ATRIBUTO11,
                ltbDetalle.ATRIBUTO12,
                ltbDetalle.ATRIBUTO13,
                ltbDetalle.ATRIBUTO14,
                ltbDetalle.ATRIBUTO15,
                ltbDetalle.ATTRIBUTE_CATEGORY
                )
                returning ID_PARRILLA_DET INTO linIdNuevoDetParrilla;
                END IF;
            END LOOP;
         END IF;
         ldtFechaIntervalo := ldtFechaIntervalo + 1;
         ldtFechaInicio := ldtFechaInicio + 1;
         linIntervalo := linIntervalo - 1;
         EXIT;
        END LOOP;
        CLOSE lcurCabecero;
        CLOSE lcurCabeceroSiguiente;
        IF linIntervalo < 0 THEN
          EXIT;
        END IF;
        END;
        END LOOP;
        END;
    END IF;
    COMMIT;
    postMensaje := 'ok';
    EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        raise_application_error(-20001,'An error was encountered - '||SQLCODE||
        ' -ERROR- '||SQLERRM);
    END;
/
