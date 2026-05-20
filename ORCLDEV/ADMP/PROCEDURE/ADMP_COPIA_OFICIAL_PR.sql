CREATE OR REPLACE EDITIONABLE PROCEDURE "ADMP"."ADMP_COPIA_OFICIAL_PR" (
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
      IF pistIdAccion = 'P' THEN
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
        linFlagInserta NUMBER :=-1;
        lstHoraInicioTmp VARCHAR(8) :=-1;
        lstHoraFinTmp VARCHAR(8) :=-1;
        lstHoraInicioIso VARCHAR(8) :=-1;
        lstHoraFinIso VARCHAR(8) :=-1;
        lstHoraFinAux VARCHAR(8) :=-1;
        lstHoraFinIsoAux VARCHAR(8) :=-1;
        linHoraFinIsoNum NUMBER := -1;
        lstHoraInicioAux VARCHAR(8) :=-1;
        lstHoraInicioIsoAux VARCHAR(8) :=-1;
        linHoraIniIso NUMBER := 0;
        linLength NUMBER := 0;
        linIdNuevoDetParrilla NUMBER :=-1;
    BEGIN
        FOR ltbPrograma IN (
           SELECT * FROM ADMP.ADMP_PARRILLA_COPIA_VW WHERE ID_PARRILLA_DET IN(
           SELECT regexp_substr(pistDetalles,'[^,]+', 1, LEVEL) FROM DUAL
           CONNECT BY regexp_substr(pistDetalles, '[^,]+', 1, LEVEL) IS NOT NULL
        ))
    LOOP
        SELECT 1 + TRUNC((SELECT FEC_PARRILLA
        FROM ADMP.ADMP_PARRILLA_COPIA_VW
        WHERE ID_PARRILLA_DET = ltbPrograma.ID_PARRILLA_DET)-1)
        - TRUNC((SELECT FEC_PARRILLA
            FROM ADMP.ADMP_PARRILLA_COPIA_VW
            WHERE ID_PARRILLA_DET = ltbPrograma.ID_PARRILLA_DET)-1, 'IW')
            INTO lstIdNumeroProgram FROM DUAL;
    IF TO_NUMBER(REPLACE(ltbPrograma.DES_HORA_FIN, ':','')) <= 10000 THEN
        linHoraIni := TO_NUMBER(REPLACE(
            CONCAT('24', SUBSTR(ltbPrograma.DES_HORA_INICIO, 3)),':',''));
        linHoraIniMas := TO_NUMBER(REPLACE(
            CONCAT('24', SUBSTR(ltbPrograma.DES_HORA_INICIO, 3)),':','')) + 1;
    IF SUBSTR(ltbPrograma.DES_HORA_FIN, 1, 2) = '00' THEN
        linHoraFin := to_NUMBER(REPLACE(
            CONCAT('24', SUBSTR(ltbPrograma.DES_HORA_FIN, 3)),':',''));
        linHoraFinMenos := to_NUMBER(REPLACE(
            CONCAT('24', SUBSTR(ltbPrograma.DES_HORA_FIN, 3)),':','')) - 1;
    ELSIF SUBSTR(ltbPrograma.DES_HORA_FIN, 1, 2) = '01' THEN
        linHoraFin := to_NUMBER(REPLACE(
            CONCAT('25', SUBSTR(ltbPrograma.DES_HORA_FIN, 3)),':',''));
        linHoraFinMenos := to_NUMBER(REPLACE(
            CONCAT('25', SUBSTR(ltbPrograma.DES_HORA_FIN, 3)),':','')) - 1;
    END IF;
    FOR ltbRec IN (
        SELECT  id_parrilla_det
        FROM    ADMP.ADMP_PARRILLA_COPIA_VW
        WHERE   id_canal = piinIdCanalDestino
        AND     fec_parrilla BETWEEN
                (TO_DATE(pistFechaIniDestino, 'dd/mm/yyyy') - 1)
        AND     (TO_DATE(pistFechaFinDestino, 'dd/mm/yyyy') - 1)
        AND     (TO_NUMBER(REPLACE(DES_HORA_INICIO, ':',''))
        BETWEEN  linHoraIni
        AND      linHoraFinMenos
        OR       TO_NUMBER(REPLACE(DES_HORA_FIN, ':',''))
        BETWEEN  linHoraIniMas
        AND linHoraFin
        OR      (TO_NUMBER(REPLACE(DES_HORA_INICIO, ':','')) <  linHoraIni
        AND TO_NUMBER(REPLACE(DES_HORA_FIN, ':','')) >  linHoraFin))
        AND     Dia = lstIdNumeroProgram
        AND     ID_TIPO_PARRILLA = piinIdTipoParrillaDestino)
        LOOP
            DELETE ADMP.ADMP_TARGET_PARR_DET_TAB
            WHERE ID_PARRILLA_DET = ltbRec.id_parrilla_det;
            DELETE ADMP.ADMP_PARRILLA_DET_TAB
            WHERE ID_PARRILLA_DET = ltbRec.id_parrilla_det;
        END LOOP;
    ELSIF to_NUMBER(REPLACE(ltbPrograma.DES_HORA_INICIO, ':','')) < 10000
        AND to_NUMBER(REPLACE(ltbPrograma.DES_HORA_FIN, ':','')) > 10000 THEN
        linHoraIni := to_NUMBER(REPLACE(
            CONCAT('24', SUBSTR(ltbPrograma.DES_HORA_INICIO, 3)),':',''));
        linHoraIniMas := to_NUMBER(REPLACE(
            CONCAT('24', SUBSTR(ltbPrograma.DES_HORA_INICIO, 3)),':','')) + 1;
        linHoraFin := 250000;
        linHoraFinMenos := 249999;
    FOR ltbRec IN (
        SELECT  id_parrilla_det
        FROM    ADMP.ADMP_PARRILLA_COPIA_VW
        WHERE   id_canal = piinIdCanalDestino
        AND     fec_parrilla
        BETWEEN (TO_DATE(pistFechaIniDestino, 'dd/mm/yyyy')-1)
        AND     (TO_DATE(pistFechaFinDestino, 'dd/mm/yyyy')-1)
        AND     (TO_NUMBER(REPLACE(DES_HORA_INICIO, ':',''))
        BETWEEN  linHoraIni AND linHoraFinMenos
        OR       TO_NUMBER(REPLACE(DES_HORA_FIN, ':',''))
        BETWEEN  linHoraIniMas AND linHoraFin
        OR      (TO_NUMBER(REPLACE(DES_HORA_INICIO, ':','')) <  linHoraIni
        AND      TO_NUMBER(REPLACE(DES_HORA_FIN, ':','')) >  linHoraFin))
        AND      Dia = lstIdNumeroProgram
        AND      ID_TIPO_PARRILLA = piinIdTipoParrillaDestino)
        LOOP
            DELETE ADMP.ADMP_TARGET_PARR_DET_TAB
            WHERE ID_PARRILLA_DET = ltbRec.id_parrilla_det;
            DELETE ADMP.ADMP_PARRILLA_DET_TAB
            WHERE ID_PARRILLA_DET = ltbRec.id_parrilla_det;
        END LOOP;
    ELSIF TO_NUMBER(REPLACE(ltbPrograma.DES_HORA_INICIO, ':','')) < 60000
          AND TO_NUMBER(REPLACE(ltbPrograma.DES_HORA_FIN, ':','')) > 60000  THEN
        linHoraIni := 60000;
        linHoraIniMas := 60001;
        linHoraFin := TO_NUMBER(REPLACE(ltbPrograma.DES_HORA_FIN,':',''));
        linHoraFinMenos :=
                    TO_NUMBER(REPLACE(ltbPrograma.DES_HORA_FIN,':','')) + 1;
        FOR ltbRec IN (
            SELECT  id_parrilla_det
            FROM    ADMP.ADMP_PARRILLA_COPIA_VW
            WHERE   id_canal = piinIdCanalDestino
            AND     fec_parrilla
            BETWEEN TO_DATE(pistFechaIniDestino, 'dd/mm/yyyy')
            AND     TO_DATE(pistFechaFinDestino, 'dd/mm/yyyy')
            AND     (TO_NUMBER(REPLACE(DES_HORA_INICIO, ':',''))
            BETWEEN linHoraIni AND linHoraFinMenos
            OR      TO_NUMBER(REPLACE(DES_HORA_FIN, ':',''))
            BETWEEN  linHoraIniMas AND linHoraFin
            OR      (TO_NUMBER(REPLACE(DES_HORA_INICIO, ':','')) <  linHoraIni
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
    ELSIF TO_NUMBER(REPLACE(ltbPrograma.DES_HORA_INICIO, ':','')) >= 060000 THEN
        linHoraIni := TO_NUMBER(REPLACE(ltbPrograma.DES_HORA_INICIO, ':',''));
        linHoraIniMas :=
                TO_NUMBER(REPLACE(ltbPrograma.DES_HORA_INICIO, ':','')) + 1;
        linHoraFin := TO_NUMBER(REPLACE(ltbPrograma.DES_HORA_FIN, ':',''));
        linHoraFinMenos :=
                TO_NUMBER(REPLACE(ltbPrograma.DES_HORA_FIN, ':','')) - 1;
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
            BETWEEN  linHoraIniMas AND linHoraFin
            OR      (TO_NUMBER(REPLACE(DES_HORA_INICIO, ':','')) <  linHoraIni
            AND TO_NUMBER(REPLACE(DES_HORA_FIN, ':','')) >  linHoraFin))
            AND     Dia = ltbPrograma.DIA
            AND     ID_TIPO_PARRILLA = piinIdTipoParrillaDestino
            )
        LOOP
            DELETE ADMP.ADMP_TARGET_PARR_DET_TAB
                WHERE ID_PARRILLA_DET = ltbRec.id_parrilla_det;
            DELETE ADMP.ADMP_PARRILLA_DET_TAB
                WHERE ID_PARRILLA_DET = ltbRec.id_parrilla_det;
        END LOOP;
      END IF;
    END LOOP;
    SELECT TO_DATE(pistFechaFinDestino, 'dd/mm/yyyy') -
        TO_DATE(pistFechaIniDestino, 'dd/mm/yyyy') INTO linIntervalo FROM DUAL;
    LOOP
        DECLARE
            ltbCab   ADMP.ADMP_PARRILLA_TAB%ROWTYPE;
            ltbNext  ADMP.ADMP_PARRILLA_TAB%ROWTYPE;
            CURSOR lcurCabecero
                IS SELECT *
                FROM ADMP.ADMP_PARRILLA_TAB
                WHERE FEC_PARRILLA = ldtFechaIntervalo
                AND ID_CANAL = piinIdCanalDestino
                AND ID_TIPO_PARRILLA = piinIdTipoParrillaDestino;
            CURSOR lcurCabeceroSiguiente
                IS SELECT *
                FROM ADMP.ADMP_PARRILLA_TAB
                WHERE FEC_PARRILLA = (ldtFechaIntervalo - 1)
                AND ID_CANAL = piinIdCanalDestino
                AND ID_TIPO_PARRILLA = piinIdTipoParrillaDestino;
        BEGIN
            OPEN lcurCabecero;
            OPEN lcurCabeceroSiguiente;
             LOOP
                FETCH lcurCabecero INTO ltbCab;
                FETCH lcurCabeceroSiguiente INTO ltbNext;
                SELECT 1 + TRUNC (ldtFechaIntervalo) -
                    TRUNC (ldtFechaIntervalo, 'IW')
                INTO lstIdNumeroDia  FROM DUAL;
                linFlagInserta := -1;
                IF lstIdNumeroDia = '1' THEN
                    IF pistLunes IS NOT NULL THEN
                        linFlagInserta := 1;
                    END IF;
                END IF;
                IF lstIdNumeroDia = '2' THEN
                    IF pistMartes     IS NOT NULL THEN
                        linFlagInserta := 1;
                    END IF;
                END IF;
                IF lstIdNumeroDia = '3' THEN
                    IF pistMiercoles     IS NOT NULL THEN
                        linFlagInserta := 1;
                    END IF;
                END IF;
                IF lstIdNumeroDia = '4' THEN
                    IF pistJueves     IS NOT NULL THEN
                        linFlagInserta := 1;
                    END IF;
                END IF;
                IF lstIdNumeroDia = '5' THEN
                    IF pistViernes     IS NOT NULL THEN
                        linFlagInserta := 1;
                    END IF;
                END IF;
                IF lstIdNumeroDia = '6' THEN
                    IF pistSabado     IS NOT NULL THEN
                        linFlagInserta := 1;
                    END IF;
                END IF;
                IF lstIdNumeroDia = '7' THEN
                    IF pistDomingo     IS NOT NULL THEN
                        linFlagInserta := 1;
                    END IF;
                END IF;
        IF linFlagInserta = '1' THEN
            IF lcurCabecero%NOTFOUND THEN
                INSERT INTO ADMP.ADMP_PARRILLA_TAB
                    (id_parrilla,
                    fec_parrilla,
                    id_canal,
                    num_version,
                    id_estado,
                    num_created_by,
                    fec_creation_date,
                    num_last_update,
                    fec_last_update,
                    num_last_update_login,
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
                    id_tipo_parrilla)
                VALUES
                    (-1 ,
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
        INSERT INTO ADMP.ADMP_PARRILLA_TAB
            (id_parrilla,
            fec_parrilla,
            id_canal,
            num_version,
            id_estado,
            num_created_by,
            fec_creation_date,
            num_last_update,
            fec_last_update,
            num_last_update_login,
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
            id_tipo_parrilla )
        VALUES
            (-1 ,
            (ldtFechaIntervalo - 1),
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
        SELECT 1 + TRUNC((SELECT FEC_PARRILLA FROM ADMP.ADMP_PARRILLA_COPIA_VW
            WHERE ID_PARRILLA_DET = ltbDetalle.ID_PARRILLA_DET))
        - TRUNC((SELECT FEC_PARRILLA FROM ADMP.ADMP_PARRILLA_COPIA_VW
            WHERE ID_PARRILLA_DET = ltbDetalle.ID_PARRILLA_DET), 'IW')
        INTO lstIdNumeroAux FROM DUAL;
    IF lstIdNumeroAux = lstIdNumeroDia THEN
        IF to_NUMBER(REPLACE(ltbDetalle.DES_HORA_FIN, ':','')) <= 10000 THEN
        IF SUBSTR(ltbDetalle.DES_HORA_INICIO, 1, 2) = '00' THEN
            lstHoraInicioTmp := CONCAT('24',
                                SUBSTR(ltbDetalle.DES_HORA_INICIO, 3));
            lstHoraInicioIso := CONCAT('23',
                                SUBSTR(ltbDetalle.DES_HORA_INICIO, 3));
        ELSIF SUBSTR(ltbDetalle.DES_HORA_INICIO, 1, 2) = '01' THEN
            lstHoraInicioTmp := CONCAT('25',
                                SUBSTR(ltbDetalle.DES_HORA_INICIO, 3));
            lstHoraInicioIso := CONCAT('00',
                                SUBSTR(ltbDetalle.DES_HORA_INICIO, 3));
        END IF;
        IF SUBSTR(ltbDetalle.DES_HORA_FIN, 1, 2) = '00' THEN
            lstHoraFinTmp := CONCAT('24', SUBSTR(ltbDetalle.DES_HORA_FIN, 3));
            lstHoraFinIso := CONCAT('23', SUBSTR(ltbDetalle.DES_HORA_FIN, 3));
        ELSIF SUBSTR(ltbDetalle.DES_HORA_FIN, 1, 2) = '01' THEN
            lstHoraFinTmp := CONCAT('25', SUBSTR(ltbDetalle.DES_HORA_FIN, 3));
            lstHoraFinIso := CONCAT('00', SUBSTR(ltbDetalle.DES_HORA_FIN, 3));
        END IF;
    INSERT INTO  ADMP.ADMP_PARRILLA_DET_TAB
        (ID_PARRILLA_DET,
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
        ATTRIBUTE_CATEGORY)
    VALUES
        (-1 ,
        linIdNuevoParrillaSig,
        ltbDetalle.ID_GENERO,
        ltbDetalle.DES_CICLO ,
        lstHoraInicioTmp,
        lstHoraFinTmp,
        lstHoraInicioTmp,
        lstHoraFinTmp,
        lstHoraInicioIso,
        lstHoraFinIso,
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
        ltbDetalle.ATTRIBUTE_CATEGORY)
    returning ID_PARRILLA_DET INTO linIdNuevoDetParrilla;
    ELSIF TO_NUMBER(REPLACE(ltbDetalle.DES_HORA_INICIO, ':','')) < 010000
        AND TO_NUMBER(REPLACE(ltbDetalle.DES_HORA_FIN, ':','')) > 010000  THEN
        IF SUBSTR(ltbDetalle.DES_HORA_INICIO, 1, 2) = '00' THEN
            lstHoraInicioTmp := CONCAT('24',
                                SUBSTR(ltbDetalle.DES_HORA_INICIO, 3));
            lstHoraInicioIso := CONCAT('23',
                                SUBSTR(ltbDetalle.DES_HORA_INICIO, 3));
        ELSIF SUBSTR(ltbDetalle.DES_HORA_INICIO, 1, 2) = '01' THEN
            lstHoraInicioTmp := CONCAT('25',
                                SUBSTR(ltbDetalle.DES_HORA_INICIO, 3));
            lstHoraInicioIso := CONCAT('00',
                                SUBSTR(ltbDetalle.DES_HORA_INICIO, 3));
        END IF;
    INSERT INTO  ADMP.ADMP_PARRILLA_DET_TAB
        (ID_PARRILLA_DET,
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
        ATTRIBUTE_CATEGORY)
    VALUES
        (-1 ,
        linIdNuevoParrillaSig,
        ltbDetalle.ID_GENERO,
        ltbDetalle.DES_CICLO ,
        lstHoraInicioTmp,
        '25:00:00',
        lstHoraInicioTmp,
        '25:00:00',
        lstHoraInicioIso,
        '00:00:00',
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
        ltbDetalle.ATTRIBUTE_CATEGORY)
    returning ID_PARRILLA_DET INTO linIdNuevoDetParrilla;
    ELSIF TO_NUMBER(REPLACE(ltbDetalle.DES_HORA_INICIO, ':','')) < 060000
        AND TO_NUMBER(REPLACE(ltbDetalle.DES_HORA_FIN, ':','')) > 060000  THEN
    linHoraFinIsoNum := TO_NUMBER(SUBSTR(ltbDetalle.DES_HORA_FIN, 1, 2));
    lstHoraFinIsoAux := SUBSTR(ltbDetalle.DES_HORA_FIN, 1, 2);
    linHoraFinIsoNum := linHoraFinIsoNum-1;
    IF linHoraFinIsoNum < 10 THEN
        lstHoraFinAux := CONCAT('0', to_char(linHoraFinIsoNum));
    ELSE
        lstHoraFinAux := to_char(linHoraFinIsoNum);
    END IF;
        lstHoraFinIso := CONCAT(lstHoraFinAux,
                         SUBSTR(ltbDetalle.DES_HORA_FIN, 3));
    IF lstHoraFinIso = '24:00:00' THEN
        lstHoraFinIso := '00:00:00';
    END IF;
    INSERT INTO  ADMP.ADMP_PARRILLA_DET_TAB
        (ID_PARRILLA_DET,
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
        ATTRIBUTE_CATEGORY)
    VALUES
        (-1 ,
        linIdNuevoParrilla,
        ltbDetalle.ID_GENERO,
        ltbDetalle.DES_CICLO ,
        '06:00:00',
        ltbDetalle.DES_HORA_FIN,
        '06:00:00',
        ltbDetalle.DES_HORA_FIN,
        '05:00:00',
        lstHoraFinIso,
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
    ELSIF TO_NUMBER(REPLACE(ltbDetalle.DES_HORA_INICIO, ':','')) >= 060000 THEN
        linHoraIniIso := TO_NUMBER(SUBSTR(ltbDetalle.DES_HORA_INICIO, 1, 2));
        lstHoraInicioIsoAux := SUBSTR(ltbDetalle.DES_HORA_INICIO, 1, 2);
        linHoraIniIso := linHoraIniIso -1;
        IF linHoraIniIso < 10 THEN
            lstHoraInicioAux := CONCAT('0', TO_CHAR(linHoraIniIso));
        ELSE
            lstHoraInicioAux := TO_CHAR(linHoraIniIso);
        END IF;
        lstHoraInicioIso := CONCAT(lstHoraInicioAux,
                            SUBSTR(ltbDetalle.DES_HORA_INICIO, 3));
        linHoraFinIsoNum := TO_NUMBER(SUBSTR(ltbDetalle.DES_HORA_FIN, 1, 2));
        lstHoraFinIsoAux := SUBSTR(ltbDetalle.DES_HORA_FIN, 1, 2);
        linHoraFinIsoNum := linHoraFinIsoNum-1;
        IF linHoraFinIsoNum < 10 THEN
            lstHoraFinAux := CONCAT('0', TO_CHAR(linHoraFinIsoNum));
        ELSE
            lstHoraFinAux := to_char(linHoraFinIsoNum);
        END IF;
        lstHoraFinIso := CONCAT(lstHoraFinAux,
                         SUBSTR(ltbDetalle.DES_HORA_FIN, 3));
        IF lstHoraFinIso = '24:00:00' THEN
            lstHoraFinIso := '00:00:00';
        END IF;
    INSERT INTO  ADMP.ADMP_PARRILLA_DET_TAB
        (ID_PARRILLA_DET,
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
        ATTRIBUTE_CATEGORY)
    VALUES
        (-1 ,
        linIdNuevoParrilla,
        ltbDetalle.ID_GENERO,
        ltbDetalle.DES_CICLO ,
        ltbDetalle.DES_HORA_INICIO,
        ltbDetalle.DES_HORA_FIN,
        ltbDetalle.DES_HORA_INICIO,
        ltbDetalle.DES_HORA_FIN,
        lstHoraInicioIso,
        lstHoraFinIso,
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
        ltbDetalle.ATTRIBUTE_CATEGORY)
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
        linIntervalo Number := 0;
        ldtFechaIntervalo date := TO_DATE(pistFechaIniDestino, 'dd/mm/yyyy');
        ldtFechaInicio date := TO_DATE(pistFechaIniOrigen, 'dd/mm/yyyy');
        linIdNuevoParrilla Number :=-1;
        linIdNuevoParrillaSig Number :=-1;
        linIdNuevoDetParrilla Number :=-1;
        linIdParrillaOrigen Number :=0;
        BEGIN
        FOR ltbRec IN(
            SELECT  ID_PARRILLA_DET
                FROM(
                SELECT * FROM ADMP.ADMP_PARRILLA_COPIA_VW
                WHERE   ID_CANAL = piinIdCanalDestino
                AND     FEC_PARRILLA
                BETWEEN TO_DATE(pistFechaIniDestino, 'dd/mm/yyyy')
                AND     TO_DATE(pistFechaFinDestino, 'dd/mm/yyyy')
                AND     ID_TIPO_PARRILLA = piinIdTipoParrillaDestino
                AND     DES_HORA_FIN <= '24:00:00'
                UNION
                SELECT * FROM ADMP.ADMP_PARRILLA_COPIA_VW
                WHERE   ID_CANAL = piinIdCanalDestino
                AND     FEC_PARRILLA
                BETWEEN (TO_DATE(pistFechaIniDestino, 'dd/mm/yyyy')-1)
                AND     TO_DATE(pistFechaFinDestino, 'dd/mm/yyyy')
                AND     ID_TIPO_PARRILLA = piinIdTipoParrillaDestino
                AND     DES_HORA_INICIO < '24:00:00'
                AND     DES_HORA_FIN > '24:00:00'
                UNION
                SELECT * FROM ADMP.ADMP_PARRILLA_COPIA_VW
                WHERE   ID_CANAL = piinIdCanalDestino
                AND     FEC_PARRILLA
                BETWEEN (TO_DATE(pistFechaIniDestino, 'dd/mm/yyyy')-1)
                AND     (TO_DATE(pistFechaFinDestino, 'dd/mm/yyyy')-1)
                AND     ID_TIPO_PARRILLA = piinIdTipoParrillaDestino
                AND     DES_HORA_INICIO >= '24:00:00'))
        LOOP
            DELETE ADMP.ADMP_TARGET_PARR_DET_TAB
                WHERE ID_PARRILLA_DET = ltbRec.id_parrilla_det;
            DELETE ADMP.ADMP_PARRILLA_DET_TAB
                WHERE ID_PARRILLA_DET = ltbRec.id_parrilla_det;
        END LOOP;
        SELECT TO_DATE(pistFechaFinOrigen, 'dd/mm/yyyy')
            - TO_DATE(pistFechaIniOrigen, 'dd/mm/yyyy')
            INTO linIntervalo FROM DUAL;
        LOOP
            BEGIN
                SELECT id_parrilla INTO linIdParrillaOrigen
                FROM ADMP.ADMP_PARRILLA_TAB
                WHERE fec_parrilla = ldtFechaInicio
                AND ID_CANAL = piinIdCanalOrigen
                AND ID_TIPO_PARRILLA = piinIdTipoParrilla;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            linIdParrillaOrigen := NULL;
        END;
        DECLARE
        ltbCab   ADMP.ADMP_PARRILLA_TAB%ROWTYPE;
        ltbNext  ADMP.ADMP_PARRILLA_TAB%ROWTYPE;
        lstHoraInicioTmp VARCHAR(8) :=-1;
        lstHoraFinTmp VARCHAR(8) :=-1;
        lstHoraInicioIso VARCHAR(8) :=-1;
        lstHoraFinIso VARCHAR(8) :=-1;
        lstHoraFinAux VARCHAR(8) :=-1;
        lstHoraFinIsoAux VARCHAR(8) :=-1;
        linHoraFinIsoNum NUMBER := -1;
        lstHoraInicioAux VARCHAR(8) :=-1;
        lstHoraInicioIsoAux VARCHAR(8) :=-1;
        linHoraIniIso NUMBER := 0;
        CURSOR lcurCabecero IS
            SELECT * FROM ADMP.ADMP_PARRILLA_TAB
            WHERE FEC_PARRILLA = ldtFechaIntervalo
            AND ID_CANAL = piinIdCanalDestino
            AND ID_TIPO_PARRILLA = piinIdTipoParrillaDestino;
        CURSOR lcurCabeceroSiguiente IS
            SELECT * FROM ADMP.ADMP_PARRILLA_TAB
            WHERE FEC_PARRILLA = (ldtFechaIntervalo - 1)
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
                        fec_creation_date,
                        num_last_update,
                        fec_last_update,
                        num_last_update_login,
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
                    returning id_parrilla into linIdNuevoParrilla;
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
                fec_creation_date,
                num_last_update,
                fec_last_update,
                num_last_update_login,
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
                (ldtFechaIntervalo - 1),
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
        FROM    ADMP.ADMP_PARRILLA_DET_TAB
        WHERE   ID_PARRILLA = linIdParrillaOrigen
        )
    LOOP
    IF TO_NUMBER(REPLACE(ltbDetalle.DES_HORA_FIN, ':','')) <= 10000 THEN
        IF SUBSTR(ltbDetalle.DES_HORA_INICIO, 1, 2) = '00' THEN
            lstHoraInicioTmp := CONCAT('24',
                                SUBSTR(ltbDetalle.DES_HORA_INICIO, 3));
            lstHoraInicioIso := CONCAT('23',
                                SUBSTR(ltbDetalle.DES_HORA_INICIO, 3));
        ELSIF SUBSTR(ltbDetalle.DES_HORA_INICIO, 1, 2) = '01' THEN
            lstHoraInicioTmp := CONCAT('25',
                                SUBSTR(ltbDetalle.DES_HORA_INICIO, 3));
            lstHoraInicioIso := CONCAT('00',
                                SUBSTR(ltbDetalle.DES_HORA_INICIO, 3));
        END IF;
        IF SUBSTR(ltbDetalle.DES_HORA_FIN, 1, 2) = '00' THEN
            lstHoraFinTmp := CONCAT('24', SUBSTR(ltbDetalle.DES_HORA_FIN, 3));
            lstHoraFinIso := CONCAT('23', SUBSTR(ltbDetalle.DES_HORA_FIN, 3));
        ELSIF SUBSTR(ltbDetalle.DES_HORA_FIN, 1, 2) = '01' THEN
            lstHoraFinTmp := CONCAT('25', SUBSTR(ltbDetalle.DES_HORA_FIN, 3));
            lstHoraFinIso := CONCAT('00', SUBSTR(ltbDetalle.DES_HORA_FIN, 3));
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
            lstHoraInicioIso,
            lstHoraFinIso,
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
    ELSIF TO_NUMBER(REPLACE(ltbDetalle.DES_HORA_INICIO, ':','')) < 060000
        AND TO_NUMBER(REPLACE(ltbDetalle.DES_HORA_FIN, ':','')) > 060000  THEN
        linHoraFinIsoNum := TO_NUMBER(SUBSTR(ltbDetalle.DES_HORA_FIN, 1, 2));
        lstHoraFinIsoAux := SUBSTR(ltbDetalle.DES_HORA_FIN, 1, 2);
        linHoraFinIsoNum := linHoraFinIsoNum-1;
        IF linHoraFinIsoNum < 10 THEN
           lstHoraFinAux := CONCAT('0', TO_CHAR(linHoraFinIsoNum));
         ELSE
            lstHoraFinAux := TO_CHAR(linHoraFinIsoNum);
        END IF;
        lstHoraFinIso := CONCAT(lstHoraFinAux,
                         SUBSTR(ltbDetalle.DES_HORA_FIN, 3));
        IF lstHoraFinIso = '24:00:00' THEN
        lstHoraFinIso := '00:00:00';
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
            '06:00:00',
            ltbDetalle.DES_HORA_FIN,
            '06:00:00',
            ltbDetalle.DES_HORA_FIN,
            '05:00:00',
            lstHoraFinIso,
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
    ELSIF TO_NUMBER(REPLACE(ltbDetalle.DES_HORA_INICIO, ':','')) >= 060000 THEN
        linHoraIniIso := TO_NUMBER(SUBSTR(ltbDetalle.DES_HORA_INICIO, 1, 2));
        lstHoraInicioIsoAux := SUBSTR(ltbDetalle.DES_HORA_INICIO, 1, 2);
        linHoraIniIso := linHoraIniIso -1;
        IF linHoraIniIso < 10 THEN
            lstHoraInicioAux := CONCAT('0', TO_CHAR(linHoraIniIso));
        ELSE
        lstHoraInicioAux := TO_CHAR(linHoraIniIso);
        END IF;
        lstHoraInicioIso := CONCAT(lstHoraInicioAux,
                            SUBSTR(ltbDetalle.DES_HORA_INICIO, 3));
        linHoraFinIsoNum := TO_NUMBER(SUBSTR(ltbDetalle.DES_HORA_FIN, 1, 2));
        lstHoraFinIsoAux := SUBSTR(ltbDetalle.DES_HORA_FIN, 1, 2);
        linHoraFinIsoNum := linHoraFinIsoNum-1;
        IF linHoraFinIsoNum < 10 then
           lstHoraFinAux := CONCAT('0', TO_CHAR(linHoraFinIsoNum));
         ELSE
            lstHoraFinAux := TO_CHAR(linHoraFinIsoNum);
        END IF;
        lstHoraFinIso := CONCAT(lstHoraFinAux,
                         SUBSTR(ltbDetalle.DES_HORA_FIN, 3));
        IF lstHoraFinIso = '24:00:00' THEN
        lstHoraFinIso := '00:00:00';
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
            ltbDetalle.DES_CICLO,
            ltbDetalle.DES_HORA_INICIO,
            ltbDetalle.DES_HORA_FIN,
            ltbDetalle.DES_HORA_INICIO,
            ltbDetalle.DES_HORA_FIN,
            lstHoraInicioIso,
            lstHoraFinIso,
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
        raise_application_error(-20001,
        'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
    END;
/
