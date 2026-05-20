CREATE OR REPLACE EDITIONABLE PROCEDURE "FECI"."FECI_INSERTA_LOG_PR" 
(
        p_Message               CLOB,
        p_MessageTemplate       CLOB,
        p_Level                 NVARCHAR2,
        p_Timestamp             DATE,
        p_Exception             CLOB,
        p_LogEvent              CLOB
)
AS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    ID_REGISTRO NUMBER;
    feci_cursors SYS_REFCURSOR;
BEGIN
       INSERT INTO FECI_LOG_TAB (CLASE, MENSAJE, NIVEL, FECHA_HORA, EXCEPCION, CLAVE_RASTREO)
        VALUES ( p_Message, p_MessageTemplate, p_Level, p_Timestamp, p_Exception, p_LogEvent)
        returning ID_LOG INTO ID_REGISTRO;
         open feci_cursors for
               SELECT CLAVE_RASTREO FROM FECI_LOG_TAB WHERE ID_LOG =  ID_REGISTRO;
    DBMS_SQL.RETURN_RESULT(feci_cursors);
END FECI_INSERTA_LOG_PR ;
/
