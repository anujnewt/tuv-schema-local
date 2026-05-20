CREATE OR REPLACE NONEDITIONABLE PACKAGE "XX_BLOQUEOBAJAS"."PKG_NOTIFICACIONES" AS
    --PAQUETE CON LAS FUNCIONES REQUERIDAS PARA NOTIFICACIONES
    PROCEDURE GET_NOTIFICACIONES_PENDIENTES (p_tipo in number, p_result out SYS_REFCURSOR);
    PROCEDURE GET_DESTINATARIOS (p_tipo in number, p_result out SYS_REFCURSOR);
    PROCEDURE ACTUALIZA_NOTIFICACION (P_IDNOTIFICACION in number, P_ESTATUS in number, P_MENSAJE in VARCHAR2);
    PROCEDURE GET_NOTIFICACIONES_SYSADMIN (p_tipo in number,p_fecha DATE, p_result out SYS_REFCURSOR);
    PROCEDURE ACTUALIZA_NOTIFICACION_SYS (p_tipo in number,p_fecha DATE, P_ESTATUS in number, P_MENSAJE in VARCHAR2);
END PKG_NOTIFICACIONES;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "XX_BLOQUEOBAJAS"."PKG_NOTIFICACIONES" AS
    PROCEDURE GET_DESTINATARIOS (p_tipo in number, p_result out SYS_REFCURSOR) AS
    BEGIN
        OPEN p_result FOR
        SELECT TIPODESTINATARIO,DESTINATARIO
        FROM XX_BLOQUEOBAJAS.DESTINATARIOS
        WHERE TIPONOTIFICACION = p_tipo;
    END;
    PROCEDURE GET_NOTIFICACIONES_PENDIENTES (p_tipo in number, p_result out SYS_REFCURSOR) AS
    BEGIN
        OPEN p_result FOR
            SELECT
            NOTI.IDNOTIFICACION,
            SOL.IDSOLICITUD,  --Folio de la Solicitud
            USU.KEYEMP NUMERO_SOLICITANTE, --Numero de Empleado del solicitante
            USU.NOMBREUSUARIO NOMBRE_SOLICITANTE, --Nombre del Solicitante
            NVL(USU.CORREO,'@') CORREO_SOLICITANTE,  --Correo del Solicitante
            EMP.KEYCIA,   --Clave de la compa?ia en Labora
            EMP.COMPANIA, --Descripcion de la compa?ia en Labora
            EMP.KEYPRO,   --Clave del Proceso
            EMP.PROCESO,  --Descripcion del Proceso
            SOL.FECHABAJA,  --Fecha de Baja
            SOL.FECHACAPTURA,  --Fecha de Captura
            EMP.NOMBRE,  --Nombre del empleado al que se le bloquearan los accesos
            SOL.KEYEMP,  --Numero del empleado al que se le bloquearan los accesos
            NVL(EMP.KEYJEFE,0) KEYJEFE, --Numero del Jefe del Empleado al que se le bloquearan los accesos
            NVL(JEFE.NOMBRE,'SIN JEFE AUTORIZADOR') NOMBRE_JEFE, --Nombre del Jefe del Empleado al que se le bloquearan los accesos
            EMP.PUESTO,  --Puesto del empleado al se le bloquearan los accesos
            EMP.UBICACION, --Ubicacion del empleado al se le bloquearan los accesos
            MOT.DESCRIPCION MOTIVO_BAJA  ----Motivo de Baja
            FROM XX_BLOQUEOBAJAS.SOLICITUDES SOL
            INNER JOIN XX_BLOQUEOBAJAS.NOTIFICACIONES NOTI ON SOL.IDSOLICITUD = NOTI.IDSOLICITUD
            INNER JOIN XX_BLOQUEOBAJAS.USUARIOEMPLEADO USU ON USU.USUARIO = SOL.USUARIO
            INNER JOIN XX_BLOQUEOBAJAS.EMPLEADOS_COMPLETO EMP ON EMP.KEYEMP = SOL.KEYEMP
            INNER JOIN XX_BLOQUEOBAJAS.MOTIVOSBAJA MOT ON MOT.MOTIVOBAJA = SOL.MOTIVOBAJA
            LEFT JOIN XX_BLOQUEOBAJAS.EMPLEADOS JEFE ON JEFE.KEYEMP = EMP.KEYJEFE
            WHERE NOTI.ESTATUS = 0
            AND NOTI.INTENTOS < 3
            AND NOTI.TIPONOTIFICACION = p_tipo
            AND ((p_tipo = 3 AND SOL.ESTATUS = 1) OR SOL.ESTATUS = 2);
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            OPEN p_result FOR SELECT
            -1 IDNOTIFICACION,
            -1 IDSOLICITUD,  --Folio de la Solicitud
            0 NUMERO_SOLICITANTE, --Numero de Empleado del solicitante
            ' ' NOMBRE_SOLICITANTE, --Nombre del Solicitante
            NULL CORREO_SOLICITANTE,  --Correo del Solicitante
            NULL KEYCIA,   --Clave de la compa?ia en Labora
            NULL COMPANIA, --Descripcion de la compa?ia en Labora
            0 KEYPRO,   --Clave del Proceso
            NULL PROCESO,  --Descripcion del Proceso
            '01/01/2021' FECHABAJA,  --Fecha de Baja
            '01/01/2021' FECHACAPTURA,  --Fecha de Captura
            NULL NOMBRE,  --Nombre del empleado al que se le bloquearan los accesos
            0 KEYEMP,  --Numero del empleado al que se le bloquearan los accesos
            0 KEYJEFE, --Numero de empleado del Jefe del Empleado al que se le bloquearan los accesos
            NULL NOMBRE_JEFE, --Nombre del Jefe del Empleado al que se le bloquearan los accesos
            NULL PUESTO,  --Puesto del empleado al se le bloquearan los accesos
            NULL UBICACION, --Ubicacion del empleado al se le bloquearan los accesos
            NULL MOTIVO_BAJA  ----Motivo de Baja
            FROM DUAL;
    END;
    PROCEDURE ACTUALIZA_NOTIFICACION (P_IDNOTIFICACION in number, P_ESTATUS in number, P_MENSAJE in VARCHAR2) AS
    BEGIN
        UPDATE XX_BLOQUEOBAJAS.NOTIFICACIONES
            SET ESTATUS = CASE WHEN P_ESTATUS = 2 AND INTENTOS < 3 THEN 0 ELSE P_ESTATUS END,
                MENSAJE = P_MENSAJE,
                INTENTOS = INTENTOS + 1
        WHERE IDNOTIFICACION = P_IDNOTIFICACION;
    END;
    PROCEDURE GET_NOTIFICACIONES_SYSADMIN (p_tipo in number,p_fecha DATE, p_result out SYS_REFCURSOR) AS
    BEGIN
         OPEN p_result FOR
            SELECT
            NOTI.IDNOTIFICACION,
            SOL.IDSOLICITUD,  --Folio de la Solicitud
            USU.KEYEMP NUMERO_SOLICITANTE, --Numero de Empleado del solicitante
            USU.NOMBREUSUARIO NOMBRE_SOLICITANTE, --Nombre del Solicitante
            NVL(USU.CORREO, 'SIN CORREO') CORREO_SOLICITANTE,  --Correo del Solicitante
            EMP.KEYCIA,   --Clave de la compa?ia en Labora
            EMP.COMPANIA, --Descripcion de la compa?ia en Labora
            EMP.KEYPRO,   --Clave del Proceso
            EMP.PROCESO,  --Descripcion del Proceso
            SOL.FECHABAJA,  --Fecha de Baja
            SOL.FECHACAPTURA,  --Fecha de Captura
            EMP.NOMBRE,  --Nombre del empleado al que se le bloquearan los accesos
            SOL.KEYEMP,  --Numero del empleado al que se le bloquearan los accesos
            NVL(EMP.KEYJEFE,0) KEYJEFE, --Numero del Jefe del Empleado al que se le bloquearan los accesos
            NVL(JEFE.NOMBRE,'SIN JEFE AUTORIZADOR') NOMBRE_JEFE, --Nombre del Jefe del Empleado al que se le bloquearan los accesos
            EMP.PUESTO,  --Puesto del empleado al se le bloquearan los accesos
            EMP.UBICACION, --Ubicacion del empleado al se le bloquearan los accesos
            MOT.DESCRIPCION MOTIVO_BAJA  ----Motivo de Baja
            FROM XX_BLOQUEOBAJAS.SOLICITUDES SOL
            INNER JOIN XX_BLOQUEOBAJAS.NOTIFICACIONES NOTI ON SOL.IDSOLICITUD = NOTI.IDSOLICITUD
            INNER JOIN XX_BLOQUEOBAJAS.USUARIOEMPLEADO USU ON USU.USUARIO = SOL.USUARIO
            INNER JOIN XX_BLOQUEOBAJAS.EMPLEADOS_COMPLETO EMP ON EMP.KEYEMP = SOL.KEYEMP
            INNER JOIN XX_BLOQUEOBAJAS.MOTIVOSBAJA MOT ON MOT.MOTIVOBAJA = SOL.MOTIVOBAJA
            LEFT JOIN XX_BLOQUEOBAJAS.EMPLEADOS JEFE ON JEFE.KEYEMP = EMP.KEYJEFE
            WHERE NOTI.ESTATUS = 0
            AND NOTI.INTENTOS < 3
            AND NOTI.TIPONOTIFICACION = p_tipo
            AND SOL.ESTATUS = 2
            AND SOL.FECHABAJA < P_FECHA;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            OPEN p_result FOR SELECT
            -1 IDNOTIFICACION,
            -1 IDSOLICITUD,  --Folio de la Solicitud
            0 NUMERO_SOLICITANTE, --Numero de Empleado del solicitante
            NULL NOMBRE_SOLICITANTE, --Nombre del Solicitante
            NULL CORREO_SOLICITANTE,  --Correo del Solicitante
            NULL KEYCIA,   --Clave de la compa?ia en Labora
            NULL COMPANIA, --Descripcion de la compa?ia en Labora
            0 KEYPRO,   --Clave del Proceso
            NULL PROCESO,  --Descripcion del Proceso
            '01/01/2021' FECHABAJA,  --Fecha de Baja
            '01/01/2021' FECHACAPTURA,  --Fecha de Captura
            NULL NOMBRE,  --Nombre del empleado al que se le bloquearan los accesos
            0 KEYEMP,  --Numero del empleado al que se le bloquearan los accesos
            0 KEYJEFE, --Numero de empleado del Jefe del Empleado al que se le bloquearan los accesos
            NULL NOMBRE_JEFE, --Nombre del Jefe del Empleado al que se le bloquearan los accesos
            NULL PUESTO,  --Puesto del empleado al se le bloquearan los accesos
            NULL UBICACION, --Ubicacion del empleado al se le bloquearan los accesos
            NULL MOTIVO_BAJA  ----Motivo de Baja
            FROM DUAL;
    END;
    PROCEDURE ACTUALIZA_NOTIFICACION_SYS (p_tipo in number,p_fecha DATE, P_ESTATUS in number, P_MENSAJE in VARCHAR2) AS
    BEGIN
        UPDATE XX_BLOQUEOBAJAS.NOTIFICACIONES
            SET ESTATUS = CASE WHEN P_ESTATUS = 2 AND INTENTOS < 3 THEN 1 ELSE P_ESTATUS END,
                MENSAJE = P_MENSAJE,
                INTENTOS = INTENTOS + 1
        WHERE IDNOTIFICACION IN
            (SELECT IDNOTIFICACION
                FROM XX_BLOQUEOBAJAS.SOLICITUDES SOL
                INNER JOIN XX_BLOQUEOBAJAS.NOTIFICACIONES NOTI ON SOL.IDSOLICITUD = NOTI.IDSOLICITUD
                WHERE NOTI.ESTATUS = 0
                    AND NOTI.INTENTOS < 3
                    AND NOTI.TIPONOTIFICACION = p_tipo
                    AND SOL.ESTATUS = 2
                    AND SOL.FECHABAJA < P_FECHA);
    END;
END;
/;
