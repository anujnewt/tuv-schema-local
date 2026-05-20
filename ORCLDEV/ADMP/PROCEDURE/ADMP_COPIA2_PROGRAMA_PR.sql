CREATE OR REPLACE EDITIONABLE PROCEDURE "ADMP"."ADMP_COPIA2_PROGRAMA_PR" ( IdAccion In Varchar2,
                                                               IdParrilla In Varchar2,
                                                               IdParrillaDet In Varchar2,
                                                               IdUsuario In Number,
                                                               IdCanalOrigen In Number,
                                                               FechaIniOrigen In Varchar2,
                                                               FechaFinOrigen In Varchar2,
                                                               IdCanalDestino In number,
                                                               FechaIniDestino In Varchar2,
                                                               FechaFinDestino In Varchar2,
                                                               HoraInicio In Varchar2,
                                                               HoraInicioReal In Varchar2,
                                                               HoraInicioIso In Varchar2,
                                                               HoraFinal    In Varchar2,
                                                               HoraFinalReal In Varchar2,
                                                               HoraFinalIso In Varchar2,
                                                               Lunes In Varchar2,
                                                               Martes In Varchar2,
                                                               Miercoles In Varchar2,
                                                               Jueves In Varchar2,
                                                               Viernes In Varchar2,
                                                               Sabado In Varchar2,
                                                               Domingo In Varchar2,
                                                               IdTipoParrilla In Number,
                                                               Mensaje out varchar2)
 is
-- PGV moved types end

-- PGV moved types end
    HoraIni Number := 0;
    HoraFin Number := 0;
    HoraIniMas Number := 0;
    HoraFinMenos Number := 0;
BEGIN
if idAccion = 'P' then
    HoraIni := to_NUMBER(REPLACE(HoraInicio, ':',''));
    HoraFin := to_NUMBER(REPLACE(HoraFinal, ':',''));
    HoraIniMas := to_NUMBER(REPLACE(HoraInicio, ':','')) + 1;
    HoraFinMenos := to_NUMBER(REPLACE(HoraFinal, ':','')) - 1;
    DECLARE
-- PGV moved types start

-- PGV moved types start
        v_Prg   ADMP_PARRILLA_DET_TAB%ROWTYPE;
        HoraIniPrg Number := 0;
        HoraFinPrg Number := 0;
        Duracion Number := 0;
        Intervalo Number := 0;
        FechaIntervalo date := TO_DATE(FechaIniDestino, 'dd/mm/yyyy');
        IdTipoParrilla Number :=0;
        IdNuevoParrilla Number :=-1;
        IdNuevoDetParrilla Number :=-1;
        IdNuevoRating Number :=-1;
        IdNumeroDia vARCHAR(5) :=-1;
        FlagInserta Number :=-1;
        CURSOR cPROGRAMA IS SELECT * FROM ADMP_PARRILLA_DET_TAB WHERE ID_PARRILLA_DET = IdParrillaDet;
    BEGIN
      SELECT ID_TIPO_PARRILLA into IdTipoParrilla FROM ADMP_PARRILLA_TAB where ID_PARRILLA = IdParrilla;
      OPEN cPROGRAMA;
      LOOP
        FETCH cPROGRAMA INTO v_Prg;
        EXIT WHEN cPROGRAMA%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE( v_Prg.ID_PARRILLA || ' ' ||
                                   v_Prg.ID_PARRILLA_DET );
        HoraIniPrg := to_NUMBER(REPLACE(v_Prg.DES_HORA_INICIO, ':',''));
        HoraFinPrg := to_NUMBER(REPLACE(v_Prg.DES_HORA_FIN, ':',''));
        Duracion := HoraFinPrg - HoraIniPrg;
        DBMS_OUTPUT.PUT_LINE('fechaaaa ' || FechaIntervalo);
        DBMS_OUTPUT.PUT_LINE( DURACION || ' : ' || Duracion);
        DBMS_OUTPUT.PUT_LINE( TO_DATE(FechaFinDestino, 'dd/mm/yyyy') || ' : ' || TO_DATE(FechaIniDestino, 'dd/mm/yyyy'));
        for rec in (
            SELECT  id_parrilla_det
            FROM    ADMP_PARRILLA_COPIA_VW
            WHERE   id_canal = IdCanalDestino
            AND     fec_parrilla BETWEEN TO_DATE(FechaIniDestino, 'dd/mm/yyyy') AND TO_DATE(FechaFinDestino, 'dd/mm/yyyy')
            AND     (
                           TO_NUMBER(REPLACE(DES_HORA_INICIO, ':','')) BETWEEN  HoraIni AND HoraFinMenos
                    OR     TO_NUMBER(REPLACE(DES_HORA_FIN, ':','')) BETWEEN  HoraIniMas AND HoraFin
                    OR   (     TO_NUMBER(REPLACE(DES_HORA_INICIO, ':','')) <  HoraIni
                           AND to_NUMBER(REPLACE(DES_HORA_FIN, ':','')) >  HoraFin))
            AND     Dia IN (CASE WHEN Lunes     IS NULL THEN Lunes       ELSE '1' END,
                            CASE WHEN Martes    IS NULL THEN Martes      ELSE '2' END,
                            CASE WHEN Miercoles IS NULL THEN Miercoles   ELSE '3' END,
                            CASE WHEN Jueves    IS NULL THEN Jueves      ELSE '4' END,
                            CASE WHEN Viernes   IS NULL THEN Viernes     ELSE '5' END,
                            CASE WHEN Sabado    IS NULL THEN Sabado      ELSE '6' END,
                            CASE WHEN Domingo   IS NULL THEN Domingo     ELSE '7' END)
            AND     ID_TIPO_PARRILLA = IdTipoParrilla
            )
        loop
            DELETE ADMP_TARGET_PARR_DET_TAB WHERE ID_PARRILLA_DET = rec.id_parrilla_det;
            DELETE ADMP_PARRILLA_DET_TAB WHERE ID_PARRILLA_DET = rec.id_parrilla_det;
            DBMS_OUTPUT.PUT_LINE ('Data Deleted: ' || rec.id_parrilla_det);
        end loop;
        SELECT TO_DATE(FechaFinDestino, 'dd/mm/yyyy') - TO_DATE(FechaIniDestino, 'dd/mm/yyyy') into Intervalo FROM DUAL;
        DBMS_OUTPUT.PUT_LINE ('Intervalo: ' || Intervalo);
        DBMS_OUTPUT.PUT_LINE ('Fecha Intervalo: ' || FechaIntervalo);
        LOOP
            DBMS_OUTPUT.PUT_LINE ('Intervalo Actual = ' || Intervalo);
            DBMS_OUTPUT.PUT_LINE ('Fecha Intervalo Actual: ' || FechaIntervalo);
            DECLARE
            v_Cab   ADMP_PARRILLA_TAB%ROWTYPE;
            CURSOR cCabecero IS SELECT * FROM ADMP_PARRILLA_TAB WHERE FEC_PARRILLA = FechaIntervalo and ID_CANAL = IdCanalDestino AND ID_TIPO_PARRILLA = IdTipoParrilla;
            BEGIN
             OPEN cCabecero;
             LOOP
                FETCH cCabecero INTO v_Cab;
                select 1 + TRUNC (FechaIntervalo) - TRUNC (FechaIntervalo, 'IW')  INTO IdNumeroDia  from dual;
               -- TO_CHAR(FechaIntervalo,'D','NLS_DATE_LANGUAGE=''MEXICAN SPANISH''')
                DBMS_OUTPUT.PUT_LINE ('eNTRO ULTIMO CICLO: ' || IdNumeroDia);
                 FlagInserta := -1;
                 IF IdNumeroDia = '1' THEN
                        IF Lunes     IS NOT NULL THEN
                            FlagInserta := 1;
                            dbms_output.put_line( 'LUNES ' || FlagInserta);
                        END IF;
                    END IF;
                    IF IdNumeroDia = '2' THEN
                        IF Martes     IS NOT NULL THEN
                            FlagInserta := 1;
                            dbms_output.put_line( 'MARTES' );
                        END IF;
                    END IF;
                    IF IdNumeroDia = '3' THEN
                        IF Miercoles     IS NOT NULL THEN
                            FlagInserta := 1;
                            dbms_output.put_line( 'MIERCOLES' );
                        END IF;
                    END IF;
                    IF IdNumeroDia = '4' THEN
                        IF Jueves     IS NOT NULL THEN
                            FlagInserta := 1;
                            dbms_output.put_line( 'JUEVES' );
                        END IF;
                    END IF;
                    IF IdNumeroDia = '5' THEN
                        IF Viernes     IS NOT NULL THEN
                            FlagInserta := 1;
                            dbms_output.put_line( 'VIERNES' );
                        END IF;
                    END IF;
                    IF IdNumeroDia = '6' THEN
                        IF Sabado     IS NOT NULL THEN
                            FlagInserta := 1;
                            dbms_output.put_line( 'SABADO' );
                        END IF;
                    END IF;
                    IF IdNumeroDia = '7' THEN
                        dbms_output.put_line( 'ENTRA EN DOMINGO' );
                        IF Domingo     IS NOT NULL THEN
                            FlagInserta := 1;
                            dbms_output.put_line( 'DOMINGO' );
                        END IF;
                    END IF;
                    DBMS_OUTPUT.PUT_LINE ('FLAG: ' || FlagInserta);
                     IF FlagInserta = '1' THEN
                        if cCabecero%NOTFOUND then
                           DBMS_OUTPUT.PUT_LINE('no existe' || v_Cab.ID_PARRILLA);
                             insert into ADMP_PARRILLA_TAB( id_parrilla,  fec_parrilla,         id_canal,num_version,id_estado,num_created_by,fec_creation_date, num_last_update, fec_last_update,num_last_update_login,atributo1,atributo2,atributo3,atributo4,atributo5,atributo6,atributo7,atributo8,atributo9,atributo10,atributo11,atributo12,atributo13,atributo14,atributo15,attribute_category, id_tipo_parrilla )
                             values(                                -1 ,FechaIntervalo,   IdCanalDestino,          1,        1,     IdUsuario,          sysdate,       IdUsuario,         sysdate,            IdUsuario,     null,     null,     null,     null,     null,     null,     null,     null,     null,      null,      null,      null,      null,      null,      null,              null,   IdTipoParrilla )
                             returning id_parrilla into IdNuevoParrilla;
                             dbms_output.put_line( 'inserto = ' || IdNuevoParrilla );
                        else
                            IdNuevoParrilla := v_Cab.ID_PARRILLA;
                            DBMS_OUTPUT.PUT_LINE('existe = ' || v_Cab.ID_PARRILLA);
                        end if;
                        INSERT INTO  ADMP_PARRILLA_DET_TAB  (
                                                                ID_PARRILLA_DET,
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
                                                                )
                                                         values( -1 ,
                                                                IdNuevoParrilla,
                                                                v_Prg.ID_GENERO,
                                                                v_Prg.DES_CICLO ,
                                                                HoraInicio,
                                                                HoraFinal,
                                                                HoraInicioReal,
                                                                HoraFinalReal,
                                                                HoraInicioIso,
                                                                HoraFinalIso,
                                                                v_Prg.ID_TIPO,
                                                                v_Prg.DES_PROGRAMA,
                                                                v_Prg.DES_PROGRAMA_ORIGINAL,
                                                                v_Prg.ID_CLASIFICACION,
                                                                v_Prg.ID_FORMATO,
                                                                v_Prg.ID_RESTRICCION,
                                                                v_Prg.DES_NOTAS,
                                                                v_Prg.NUM_TRANSMISIONES,
                                                                v_Prg.FEC_ULTIMA_TRANSMISION,
                                                                v_Prg.DES_ULTIMA_TRANSMISION,
                                                                v_Prg.NUM_COLOR,
                                                                v_Prg.NUM_SAP,
                                                                v_Prg.NUM_TEMPORADA,
                                                                v_Prg.NUM_REPETICION_TEMP,
                                                                v_Prg.COD_PROGRAMA_IBOPE,
                                                                v_Prg.DES_PROGRAMA_IBOPE,
                                                                v_Prg.ID_FUENTE,
                                                                v_Prg.ID_EVENTO,
                                                                v_Prg.DES_DESCRIPCION,
                                                                v_Prg.NUM_FUENTE_XLS,
                                                                v_Prg.NUM_CAMBIO_PROG,
                                                                v_Prg.FEC_CAMBIO_PROG,
                                                                v_Prg.DES_CAPITULO,
                                                                IdUsuario,
                                                                sysdate,
                                                                IdUsuario,
                                                                sysdate,
                                                                IdUsuario,
                                                                v_Prg.ATRIBUTO1,
                                                                v_Prg.ATRIBUTO2,
                                                                v_Prg.ATRIBUTO3,
                                                                v_Prg.ATRIBUTO4,
                                                                v_Prg.ATRIBUTO5,
                                                                v_Prg.ATRIBUTO6,
                                                                v_Prg.ATRIBUTO7,
                                                                v_Prg.ATRIBUTO8,
                                                                v_Prg.ATRIBUTO9,
                                                                v_Prg.ATRIBUTO10,
                                                                v_Prg.ATRIBUTO11,
                                                                v_Prg.ATRIBUTO12,
                                                                v_Prg.ATRIBUTO13,
                                                                v_Prg.ATRIBUTO14,
                                                                v_Prg.ATRIBUTO15,
                                                                v_Prg.ATTRIBUTE_CATEGORY
                                                                )
                                  returning ID_PARRILLA_DET into IdNuevoDetParrilla;
                                dbms_output.put_line( 'inserto detalle = ' || IdNuevoDetParrilla );
                                  /*SE genera el rating*/
                                   DECLARE
                                   v_Rat   ADMP_TARGET_PARR_DET_TAB%ROWTYPE;
                                  CURSOR cRating IS SELECT * FROM ADMP_TARGET_PARR_DET_TAB WHERE ID_PARRILLA_DET = IdParrillaDet;
                                    BEGIN
                                      OPEN cRating;
                                      LOOP
                                        FETCH cRating INTO v_Rat;
                                        EXIT WHEN cRating%NOTFOUND;
                                        DBMS_OUTPUT.PUT_LINE( v_Rat.ID_TARGET_PARR_DET || ' ' ||  v_Rat.ID_PARRILLA_DET || ' ' ||
                                                                   v_Rat.ID_TARGET );
                                        INSERT INTO  ADMP_TARGET_PARR_DET_TAB  (
                                                                ID_TARGET_PARR_DET,
                                                                ID_PARRILLA_DET,
                                                                ID_TARGET,
                                                                CAN_RATING ,
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
                                                         values( -1 ,
                                                                IdNuevoDetParrilla,
                                                                v_Rat.ID_TARGET,
                                                                v_Rat.CAN_RATING ,
                                                                IdUsuario,
                                                                sysdate,
                                                                IdUsuario,
                                                                sysdate,
                                                                IdUsuario,
                                                                v_Rat.ATRIBUTO1,
                                                                v_Rat.ATRIBUTO2,
                                                                v_Rat.ATRIBUTO3,
                                                                v_Rat.ATRIBUTO4,
                                                                v_Rat.ATRIBUTO5,
                                                                v_Rat.ATRIBUTO6,
                                                                v_Rat.ATRIBUTO7,
                                                                v_Rat.ATRIBUTO8,
                                                                v_Rat.ATRIBUTO9,
                                                                v_Rat.ATRIBUTO10,
                                                                v_Rat.ATRIBUTO11,
                                                                v_Rat.ATRIBUTO12,
                                                                v_Rat.ATRIBUTO13,
                                                                v_Rat.ATRIBUTO14,
                                                                v_Rat.ATRIBUTO15,
                                                                v_Rat.ATTRIBUTE_CATEGORY
                                                                )
                                        returning ID_TARGET_PARR_DET into IdNuevoRating;
                                        dbms_output.put_line( 'inserto rating = ' || IdNuevoRating );
                                      end loop;
                                      Close cRating;
                                      end;
                    END IF;
                     FechaIntervalo := FechaIntervalo + 1;
                     Intervalo := Intervalo - 1;
                      EXIT;
            END LOOP;
            CLOSE cCabecero;
             IF Intervalo < 0 THEN
              EXIT;
            END IF;
           END;
        END LOOP;
      END LOOP;
      CLOSE cPROGRAMA;
    END;
elsif idAccion = 'D' then
    declare
        Intervalo Number := 0;
        FechaIntervalo date := TO_DATE(FechaIniDestino, 'dd/mm/yyyy');
        FechaInicio date := TO_DATE(FechaIniOrigen, 'dd/mm/yyyy');
        IdNuevoParrilla Number :=-1;
        IdNuevoDetParrilla Number :=-1;
        IdNuevoRating Number :=-1;
        IdParrillaOrigen Number :=0;
        begin
        dbms_output.put_line( 'entro D'  );
        for rec in (
            SELECT  id_parrilla_det
            FROM    ADMP_PARRILLA_COPIA_VW
            WHERE   id_canal = IdCanalDestino
            AND     fec_parrilla BETWEEN TO_DATE(FechaIniDestino, 'dd/mm/yyyy') AND TO_DATE(FechaFinDestino, 'dd/mm/yyyy')
            AND     ID_TIPO_PARRILLA = IdTipoParrilla
            )
            loop
            DELETE ADMP_TARGET_PARR_DET_TAB WHERE ID_PARRILLA_DET = rec.id_parrilla_det;
            DELETE ADMP_PARRILLA_DET_TAB WHERE ID_PARRILLA_DET = rec.id_parrilla_det;
            DBMS_OUTPUT.PUT_LINE ('Data Deleted: ' || rec.id_parrilla_det);
        end loop;
        SELECT TO_DATE(FechaFinOrigen, 'dd/mm/yyyy') - TO_DATE(FechaIniOrigen, 'dd/mm/yyyy') into Intervalo FROM DUAL;
        --DBMS_OUTPUT.PUT_LINE ('Intervalo: ' || Intervalo);
        --DBMS_OUTPUT.PUT_LINE ('Fecha Intervalo: ' || FechaIntervalo);
        LOOP
            DBMS_OUTPUT.PUT_LINE ('Intervalo Actual = ' || Intervalo);
            DBMS_OUTPUT.PUT_LINE ('Fecha Intervalo Actual: ' || FechaIntervalo);
            DBMS_OUTPUT.PUT_LINE ('Fecha Inicio Actual: ' || FechaInicio );
            begin
                select id_parrilla into IdParrillaOrigen from ADMP_PARRILLA_TAB where fec_parrilla = FechaInicio and ID_CANAL = IdCanalOrigen and ID_TIPO_PARRILLA = IdTipoParrilla;
            exception
            when no_data_found then
                IdParrillaOrigen := null;
                 DBMS_OUTPUT.PUT_LINE ('ID Parrilla a copiar ES NULL ' || IdParrillaOrigen);
            end;
                        DBMS_OUTPUT.PUT_LINE ('ID Parrilla a copiar: ' || IdParrillaOrigen );
                        DECLARE
                        v_Cab   ADMP_PARRILLA_TAB%ROWTYPE;
                        CURSOR cCabecero IS SELECT * FROM ADMP_PARRILLA_TAB WHERE FEC_PARRILLA = FechaIntervalo and ID_CANAL = IdCanalDestino AND ID_TIPO_PARRILLA = IdTipoParrilla;
                        BEGIN
                         OPEN cCabecero;
                         LOOP
                            FETCH cCabecero INTO v_Cab;
                                    if cCabecero%NOTFOUND then
                                       DBMS_OUTPUT.PUT_LINE('no existe' || v_Cab.ID_PARRILLA);
                                       if IdParrillaOrigen is not null THEN
                                             insert into ADMP_PARRILLA_TAB( id_parrilla,   fec_parrilla,          id_canal, num_version,id_estado,num_created_by,fec_creation_date, num_last_update, fec_last_update,num_last_update_login,atributo1,atributo2,atributo3,atributo4,atributo5,atributo6,atributo7,atributo8,atributo9,atributo10,atributo11,atributo12,atributo13,atributo14,atributo15,attribute_category, id_tipo_parrilla )
                                             values(                                -1 , FechaIntervalo,    IdCanalDestino,           1,        1,     IdUsuario,          sysdate,       IdUsuario,         sysdate,            IdUsuario,     null,     null,     null,     null,     null,     null,     null,     null,     null,      null,      null,      null,      null,      null,      null,              null,   IdTipoParrilla )
                                             returning id_parrilla into IdNuevoParrilla;
                                             dbms_output.put_line( 'inserto = ' || IdNuevoParrilla );
                                         END IF;
                                    else
                                        IdNuevoParrilla := v_Cab.ID_PARRILLA;
                                        DBMS_OUTPUT.PUT_LINE('existe = ' || v_Cab.ID_PARRILLA);
                                    end if;
                                      if IdParrillaOrigen is not null THEN
                                                for det in (
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
                                            FROM    ADMP_PARRILLA_DET_TAB
                                            Where   ID_PARRILLA = IdParrillaOrigen
                                            )
                                            loop
                                            DBMS_OUTPUT.PUT_LINE('entro ultimo loop = ' || det.ID_PARRILLA);
                                            INSERT INTO  ADMP_PARRILLA_DET_TAB  (
                                                                                        ID_PARRILLA_DET,
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
                                                                                     )
                                                                     values (
                                                                             -1 ,
                                                                            IdNuevoParrilla,
                                                                            det.ID_GENERO,
                                                                            det.DES_CICLO ,
                                                                            det.DES_HORA_INICIO,
                                                                            det.DES_HORA_FIN,
                                                                            det.DES_HORA_INICIO_REAL,
                                                                            det.DES_HORA_FIN_REAL,
                                                                            det.DES_HORA_INICIO_ISO,
                                                                            det.DES_HORA_FIN_ISO,
                                                                            det.ID_TIPO,
                                                                            det.DES_PROGRAMA,
                                                                            det.DES_PROGRAMA_ORIGINAL,
                                                                            det.ID_CLASIFICACION,
                                                                            det.ID_FORMATO,
                                                                            det.ID_RESTRICCION,
                                                                            det.DES_NOTAS,
                                                                            det.NUM_TRANSMISIONES,
                                                                            det.FEC_ULTIMA_TRANSMISION,
                                                                            det.DES_ULTIMA_TRANSMISION,
                                                                            det.NUM_COLOR,
                                                                            det.NUM_SAP,
                                                                            det.NUM_TEMPORADA,
                                                                            det.NUM_REPETICION_TEMP,
                                                                            det.COD_PROGRAMA_IBOPE,
                                                                            det.DES_PROGRAMA_IBOPE,
                                                                            det.ID_FUENTE,
                                                                            det.ID_EVENTO,
                                                                            det.DES_DESCRIPCION,
                                                                            det.NUM_FUENTE_XLS,
                                                                            det.NUM_CAMBIO_PROG,
                                                                            det.FEC_CAMBIO_PROG,
                                                                            det.DES_CAPITULO,
                                                                            IdUsuario,
                                                                            sysdate,
                                                                            IdUsuario,
                                                                            sysdate,
                                                                            IdUsuario,
                                                                            det.ATRIBUTO1,
                                                                            det.ATRIBUTO2,
                                                                            det.ATRIBUTO3,
                                                                            det.ATRIBUTO4,
                                                                            det.ATRIBUTO5,
                                                                            det.ATRIBUTO6,
                                                                            det.ATRIBUTO7,
                                                                            det.ATRIBUTO8,
                                                                            det.ATRIBUTO9,
                                                                            det.ATRIBUTO10,
                                                                            det.ATRIBUTO11,
                                                                            det.ATRIBUTO12,
                                                                            det.ATRIBUTO13,
                                                                            det.ATRIBUTO14,
                                                                            det.ATRIBUTO15,
                                                                            det.ATTRIBUTE_CATEGORY
                                                                            )
                                                                returning ID_PARRILLA_DET into IdNuevoDetParrilla;
                                            DBMS_OUTPUT.PUT_LINE('detalle insertado = ' || IdNuevoDetParrilla);
                                                                INSERT INTO  ADMP_TARGET_PARR_DET_TAB  (
                                                                            ID_TARGET_PARR_DET,
                                                                            ID_PARRILLA_DET,
                                                                            ID_TARGET,
                                                                            CAN_RATING ,
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
                                                                     select -1 ,
                                                                            IdNuevoDetParrilla,
                                                                            ID_TARGET,
                                                                            CAN_RATING ,
                                                                            IdUsuario,
                                                                            sysdate,
                                                                            IdUsuario,
                                                                            sysdate,
                                                                            IdUsuario,
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
                                                                       from ADMP_TARGET_PARR_DET_TAB
                                                                       where id_parrilla_det = det.ID_PARRILLA_DET;
                                            DBMS_OUTPUT.PUT_LINE('inserto target = ');
                                        end loop;
                                 END IF;
                                 FechaIntervalo := FechaIntervalo + 1;
                                 FechaInicio := FechaInicio + 1;
                                 Intervalo := Intervalo - 1;
                                  EXIT;
                        END LOOP;
                        CLOSE cCabecero;
             IF Intervalo < 0 THEN
              EXIT;
            END IF;
           END;
        END LOOP;
        end;
end if;
commit;
Mensaje := 'ok';
Exception
WHEN OTHERS THEN
    rollback;
    raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;
/
