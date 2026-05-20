CREATE OR REPLACE NONEDITIONABLE PACKAGE "XX_BLOQUEOBAJAS"."BLOQUEOACCESOS" AS


    FUNCTION TipoUsuario (p_keyemp  IN  number)
    RETURN VARCHAR2;

    FUNCTION ValidaIntelectus(p_proceso in number)
    return number;

    FUNCTION ValidaEsJefe(p_empleado in number)
    return number;

    PROCEDURE REGISTRO(p_usuario  IN  VARCHAR2,
                      p_empleado in number,
                      p_social in varchar2,
                      p_correo in varchar2,
                      p_ip in varchar2,
                      p_mombrepc in varchar2,
                      p_rol out varchar2,
                      p_resp out number,
                      p_mensaje out varchar2) ;

    PROCEDURE SOLICITUD( p_empleado in number,
                      p_fechabaja in date,
                      p_motivobaja in varchar2,
                      p_tipo in varchar2,
                      p_usuario in varchar2,
                      p_ip in varchar2,
                      p_nombrepc in varchar2,
                      p_resp out number,
                      p_mensaje out varchar2) ;
    PROCEDURE SOLICITUDNORMAL( p_empleado in number,
                      p_fechabaja in date,
                      p_motivobaja in varchar2,
                      p_usuario in varchar2,
                      p_ip in varchar2,
                      p_nombrepc in varchar2,
                      p_resp out number,
                      p_mensaje out varchar2) ;

    PROCEDURE SOLICITUDFUERAESTRUCTURA( p_empleado in number,
                      p_fechabaja in date,
                      p_motivobaja in varchar2,
                      p_usuario in varchar2,
                      p_ip in varchar2,
                      p_nombrepc in varchar2,
                      p_resp out number,
                      p_mensaje out varchar2) ;

    PROCEDURE SOLICITUDKIOSCO( p_empleado in number,
                      p_fechabaja in date,
                      p_motivobaja in varchar2,
                      p_tipo in varchar2,
                      p_usuarioEmpleado in number,
                      p_ip in varchar2,
                      p_nombrepc in varchar2,
                      p_resp out number,
                      p_mensaje out varchar2) ;

    PROCEDURE AUTORIZACION (p_idsolicitud in number,
                          p_usuario in varchar2,
                          p_ip in varchar2,
                          p_nombrepc in varchar2,
                          p_resp out number,
                          p_mensaje out varchar2) ;

    PROCEDURE CANCELACION (p_idsolicitud in number,
                          p_usuario in varchar2,
                          p_ip in varchar2,
                          p_nombrepc in varchar2,
                          p_resp out number,
                          p_mensaje out varchar2) ;

    PROCEDURE CLAVESBAJA (p_result out SYS_REFCURSOR);

    PROCEDURE EMPLEADOSJEFE (p_usuario in varchar2,
                             p_result out SYS_REFCURSOR);

    PROCEDURE EMPLEADOFUERAESTRUCRTURA(p_nombre in varchar2,
                                       p_paterno in varchar2,
                                       p_materno in varchar2,
                                       p_empleado in number,
                                       p_result out SYS_REFCURSOR);


    PROCEDURE SOLICITUDESINTELECTUS( p_result out SYS_REFCURSOR);

    PROCEDURE DATOSEMPLEADO(p_empleado in number, p_result out SYS_REFCURSOR);

    PROCEDURE EXISTEUSUARIO(p_usuario in varchar2, p_valida out number);

    PROCEDURE INSERTAR_NOTIFICACIONES(p_idsolicitud IN NUMBER, p_tiposolicitud IN NUMBER, p_proceso IN NUMBER);

    PROCEDURE BITACORAACCESO(p_usuario in varchar2,
                             p_ip in varchar2,
                             p_nombrepc in varchar2,
                             p_tipo in number,
                             p_motivo in varchar2);

END BLOQUEOACCESOS;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "XX_BLOQUEOBAJAS"."BLOQUEOACCESOS" AS
    FUNCTION TipoUsuario (p_keyemp  IN  number)
        RETURN VARCHAR2 AS
        tipoRol varchar(20) := 'NORMAL';
        valida number;
      BEGIN
        /* c????digo para saber que rol le corresponde al empleado*/
        /*if (p_keyemp = 2031329 OR
            p_keyemp = 2031322 OR
            p_keyemp = 2031720 OR
            p_keyemp = 2017175 OR
            p_keyemp = 2041671 OR
            p_keyemp = 2042937 OR
            p_keyemp = 2043917) then
            tipoRol := 'REG_CONTROL';
        end if;
        */
        RETURN tipoRol;
      END;

    FUNCTION ValidaIntelectus(p_proceso in number)
    return number as
        valida number;
    begin
        /*if (p_proceso = 10 or p_proceso = 12) then
            valida := 1;
        else
            valida := 0;
        end if;*/

        RETURN 0;
    end;

    FUNCTION ValidaEsJefe(p_empleado in number)
    return number as
        valida number;
    begin
        select count(keyemp)
        into valida
        from XX_BLOQUEOBAJAS.EMPLEADOS_COMPLETO
        where KEYJEFE = p_empleado;
        return valida;
    end;

   PROCEDURE REGISTRO(p_usuario  IN  VARCHAR2,
                      p_empleado in number,
                      p_social in varchar2,
                      p_correo in varchar2,
                      p_ip in varchar2,
                      p_mombrepc in varchar2,
                      p_rol out varchar2,
                      p_resp out number,
                      p_mensaje out varchar2) as
        regims varchar(13);
        empleado number;
        rolUsuario varchar(20);
        v_code NUMBER;
        v_errm VARCHAR2(64);
        cuentaUsuario number;
        cuentaEmpleado number;
        nombre varchar(100);
        correo VARCHAR(100);
     begin
        p_resp := 1;
        p_rol := NULL;
        p_mensaje := 'El usuario ' || p_usuario || ' se cre???? con ????xito.';

        select KEYEMP, REGIMS,NOMBRE
        into empleado, regims,nombre
        from XX_BLOQUEOBAJAS.EMPLEADOS_COMPLETO
        WHERE KEYEMP = p_empleado
        and regims = p_social;

        if (ValidaEsJefe(p_empleado) > 0) then

            select count(USUARIO)
            INTO cuentaUsuario
            from XX_BLOQUEOBAJAS.USUARIOEMPLEADO
            WHERE USUARIO = upper(p_usuario);

            select count(keyemp)
            into cuentaEmpleado
            from XX_BLOQUEOBAJAS.USUARIOEMPLEADO
            WHERE keyemp = p_empleado;

            IF p_correo IS NULL THEN
              correo := lower(p_usuario)||'@televisa.com.mx';
            ELSE
              correo := p_correo;
            END IF;

            if (cuentaUsuario = 0 and cuentaEmpleado = 0 ) then
                --inserta usuario
                rolUsuario := TipoUsuario(p_empleado);
                p_rol := rolUsuario;
                insert into XX_BLOQUEOBAJAS.USUARIOEMPLEADO( USUARIO,KEYEMP,FECHAINGRESO,DIRIP,NOMBREPC,CORREO,ROL,NOMBREUSUARIO)
                VALUES(upper(p_usuario),
                p_empleado,SYSDATE ,
                p_ip,
                p_mombrepc,
                correo,
                rolUsuario,
                nombre);
            else
                -- usuario ya existe
                p_resp := 0;
                p_mensaje := 'El usuario ya esta registrado.';
            end if;
        else
            p_resp := 0;
            p_mensaje := 'El usuario '|| p_usuario ||' no es jefe. Es necesario que te comuniques con tu Jefe Inmediato para realizar el bloqueo de acceso por medio de la opci????n Fuera de Estructura. Adicionalmente comun????cate con Compensaciones para actualizar la estructura a tu cargo';
        end if;
        COMMIT;
        EXCEPTION
         WHEN NO_DATA_FOUND THEN
            p_resp := 0;
            p_mensaje := 'El usuario no existe.';

            when others then
                v_code := SQLCODE;
                v_errm := SUBSTR(SQLERRM, 1 , 64);
                p_resp := 0;
                p_mensaje := v_code || ' ' || v_errm;
     end;

     PROCEDURE SOLICITUD( p_empleado in number,
                      p_fechabaja in date,
                      p_motivobaja in varchar2,
                      p_tipo in varchar2,
                      p_usuario in varchar2,
                      p_ip in varchar2,
                      p_nombrepc in varchar2,
                      p_resp out number,
                      p_mensaje out varchar2) as
        v_code NUMBER;
        v_errm VARCHAR2(200);
        v_estatus number;
        v_proceso number;
        v_idSolicitud number;
     begin
       p_resp := 1;
       p_mensaje := 'Tu solicitud ha sido enviada, espera la notificaci??n en tu correo. De no recibirla, por favor comun??cate al CAT.';

       SELECT keypro
       INTO v_proceso
       FROM XX_BLOQUEOBAJAS.EMPLEADOS_COMPLETO
       WHERE KEYEMP = p_empleado;

       if (ValidaIntelectus(v_proceso) = 1 ) then
           v_estatus := 1;
           insert into XX_BLOQUEOBAJAS.SOLICITUDES(KEYEMP,FECHABAJA,MOTIVOBAJA,TIPO,ESTATUS,USUARIO,
           FECHACAPTURA,DIRIP,NOMBREPC)
           VALUES(p_empleado,
           p_fechabaja,
           p_motivobaja,
           p_tipo,
           v_estatus,
           upper( p_usuario),
           SYSDATE,
           p_ip,
           p_nombrepc)
           RETURNING IDSOLICITUD INTO v_idSolicitud;
       else
           v_estatus := 2;
           insert into XX_BLOQUEOBAJAS.SOLICITUDES(KEYEMP,FECHABAJA,MOTIVOBAJA,TIPO,ESTATUS,USUARIO,
           FECHACAPTURA,DIRIP,NOMBREPC,USUARIOACCION,FECHAACCION,DIRIPACCION,NOMBREPCACCION)
           VALUES(p_empleado,
           p_fechabaja,
           p_motivobaja,
           p_tipo,
           v_estatus,
           upper( p_usuario),
           SYSDATE,
           p_ip,
           p_nombrepc,
           upper( p_usuario),
           SYSDATE,
           p_ip,
           p_nombrepc)
           RETURNING IDSOLICITUD INTO v_idSolicitud;
       end if;

       INSERTAR_NOTIFICACIONES(v_idSolicitud,p_tipo,v_proceso);

        COMMIT;
        EXCEPTION
         WHEN NO_DATA_FOUND THEN
            p_resp := 0;
            p_mensaje := 'El usuario no existe.';

            when others then
                v_code := SQLCODE;
                v_errm := SUBSTR(SQLERRM, 1 , 200);
                p_resp := 0;
                p_mensaje := v_code || ' ' || v_errm;

     end;

  PROCEDURE SOLICITUDNORMAL( p_empleado in number,
                      p_fechabaja in date,
                      p_motivobaja in varchar2,
                      p_usuario in varchar2,
                      p_ip in varchar2,
                      p_nombrepc in varchar2,
                      p_resp out number,
                      p_mensaje out varchar2) as
     begin
        BLOQUEOACCESOS.SOLICITUD( p_empleado,
                      p_fechabaja,
                      p_motivobaja,
                      '1',
                      p_usuario,
                      p_ip,
                      p_nombrepc,
                      p_resp,
                      p_mensaje);
     end;

    PROCEDURE SOLICITUDFUERAESTRUCTURA( p_empleado in number,
                      p_fechabaja in date,
                      p_motivobaja in varchar2,
                      p_usuario in varchar2,
                      p_ip in varchar2,
                      p_nombrepc in varchar2,
                      p_resp out number,
                      p_mensaje out varchar2) as
     begin
          SOLICITUD( p_empleado,
                      p_fechabaja,
                      p_motivobaja,
                      '0',
                      p_usuario,
                      p_ip,
                      p_nombrepc,
                      p_resp,
                      p_mensaje);
     end;

     PROCEDURE SOLICITUDKIOSCO( p_empleado in number,
                      p_fechabaja in date,
                      p_motivobaja in varchar2,
                      p_tipo in varchar2,
                      p_usuarioEmpleado in number,
                      p_ip in varchar2,
                      p_nombrepc in varchar2,
                      p_resp out number,
                      p_mensaje out varchar2) as
    v_code NUMBER;
    v_errm VARCHAR2(200);
    v_estatus number;
    v_proceso number;
    v_idSolicitud number;
    v_usuario VARCHAR2(50);
    begin
        p_resp := 1;
        p_mensaje := 'Tu solicitud ha sido enviada, espera la notificaci??n en tu correo. De no recibirla, por favor comun??cate al CAT.';

        BEGIN
            SELECT IDSOLICITUD INTO v_idSolicitud
            FROM XX_BLOQUEOBAJAS.SOLICITUDES
            WHERE KEYEMP = p_empleado
            AND FECHABAJA = p_fechabaja
            AND ROWNUM = 1;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                v_idSolicitud := 0;
        END;

        IF v_idSolicitud <> 0 THEN
            p_resp := 1;
            p_mensaje := 'Tu solicitud ya hab??a sido generada con el folio '||v_idSolicitud;
            RETURN;
        END IF;

        BEGIN
            SELECT USUARIO INTO v_usuario
            FROM XX_BLOQUEOBAJAS.USUARIOEMPLEADO
            WHERE KEYEMP = p_usuarioEmpleado
            AND ROWNUM = 1;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                v_usuario := p_usuarioEmpleado;
        END;

        SELECT keypro
        INTO v_proceso
        FROM XX_BLOQUEOBAJAS.EMPLEADOS_COMPLETO
        WHERE KEYEMP = p_empleado;

        v_estatus := 2;

        INSERT INTO XX_BLOQUEOBAJAS.SOLICITUDES(KEYEMP,FECHABAJA,MOTIVOBAJA,TIPO,ESTATUS,USUARIO,
        FECHACAPTURA,DIRIP,NOMBREPC,USUARIOACCION,FECHAACCION,DIRIPACCION,NOMBREPCACCION)
        VALUES(p_empleado,
        p_fechabaja,
        p_motivobaja,
        p_tipo,
        v_estatus,
        upper(v_usuario),
        SYSDATE,
        p_ip,
        p_nombrepc,
        upper(v_usuario),
        SYSDATE,
        p_ip,
        p_nombrepc)
        RETURNING IDSOLICITUD INTO v_idSolicitud;

        INSERTAR_NOTIFICACIONES(v_idSolicitud,p_tipo,v_proceso);

        p_mensaje := 'Tu solicitud hab??a sido generada con el folio '||v_idSolicitud||', espera la notificaci??n en tu correo. De no recibirla, por favor comun??cate al CAT.';
        COMMIT;
        EXCEPTION
         WHEN NO_DATA_FOUND THEN
            p_resp := 0;
            p_mensaje := 'El usuario no existe.';
            when others then
                v_code := SQLCODE;
                v_errm := SUBSTR(SQLERRM, 1 , 200);
                p_resp := 0;
                p_mensaje := v_code || ' ' || v_errm;

     end;


    PROCEDURE AUTORIZACION (p_idsolicitud in number,
                          p_usuario in varchar2,
                          p_ip in varchar2,
                          p_nombrepc in varchar2,
                          p_resp out number,
                          p_mensaje out varchar2) As
        v_code NUMBER;
        v_errm VARCHAR2(64);
    begin
         p_resp := 1;
         p_mensaje := 'Solicitud autorizada.';

         --update XX_BLOQUEOBAJAS.SOLICITUDES SET ESTATUS = 2
         --where IDSOLICITUD = p_idsolicitud;

         update XX_BLOQUEOBAJAS.SOLICITUDES SET ESTATUS = 2, USUARIOACCION = upper(p_usuario), FECHAACCION = SYSDATE,
            DIRIPACCION = p_ip, NOMBREPCACCION = p_nombrepc
         where IDSOLICITUD = p_idsolicitud;

         commit;
         EXCEPTION
         WHEN NO_DATA_FOUND THEN
            p_resp := 0;
            p_mensaje := 'El usuario no existe.';

            when others then
                v_code := SQLCODE;
                v_errm := SUBSTR(SQLERRM, 1 , 64);
                p_resp := 0;
                p_mensaje := v_code || ' ' || v_errm;
    end;

    PROCEDURE CANCELACION (p_idsolicitud in number,
                          p_usuario in varchar2,
                          p_ip in varchar2,
                          p_nombrepc in varchar2,
                          p_resp out number,
                          p_mensaje out varchar2) As
         v_code NUMBER;
        v_errm VARCHAR2(64);
    begin
         p_resp := 1;
         p_mensaje := 'Solicitud Rechazada.';

         --update XX_BLOQUEOBAJAS.SOLICITUDES SET ESTATUS = 3
         --where IDSOLICITUD = p_idsolicitud;

         update XX_BLOQUEOBAJAS.SOLICITUDES SET ESTATUS = 3,USUARIOACCION = upper(p_usuario), FECHAACCION = SYSDATE,
            DIRIPACCION = p_ip, NOMBREPCACCION = p_nombrepc
         where IDSOLICITUD = p_idsolicitud;


         commit;
         EXCEPTION
         WHEN NO_DATA_FOUND THEN
            p_resp := 0;
            p_mensaje := 'El usuario no existe.';

            when others then
                v_code := SQLCODE;
                v_errm := SUBSTR(SQLERRM, 1 , 64);
                p_resp := 0;
                p_mensaje := v_code || ' ' || v_errm;
    end;

    PROCEDURE CLAVESBAJA (p_result out SYS_REFCURSOR) AS
    BEGIN
         open p_result for SELECT MOTIVOBAJA,DESCRIPCION FROM XX_BLOQUEOBAJAS.MOTIVOSBAJA ORDER BY MOTIVOBAJA;
    END;

    PROCEDURE EMPLEADOSJEFE (p_usuario in varchar2,
                             p_result out SYS_REFCURSOR) AS
        p_keyjefe number;
    BEGIN
        select KEYEMP
        into p_keyjefe
        from XX_BLOQUEOBAJAS.USUARIOEMPLEADO
        where USUARIO = UPPER(p_usuario);

        open p_result for
        SELECT KEYEMP,NOMBRE
        FROM XX_BLOQUEOBAJAS.EMPLEADOS_COMPLETO
        where KEYJEFE = p_keyjefe
        ORDER BY NOMBRE;

         EXCEPTION
         WHEN NO_DATA_FOUND THEN
            open p_result for
            SELECT ' ' AS KEYEMP,' ' AS NOMBRE,' ' AS DEPARTAMENTO,
            ' ' AS PUESTO
            FROM dual;

    END;

    PROCEDURE EMPLEADOFUERAESTRUCRTURA(p_nombre in varchar2,
                                       p_paterno in varchar2,
                                       p_materno in varchar2,
                                       p_empleado in number,
                                       p_result out SYS_REFCURSOR) as

    begin
    IF p_empleado IS NOT NULL THEN
        open p_result for SELECT KEYEMP,NOMBRE, KEYDEP || ' ' || DEPARTAMENTO AS DEPARTAMENTO,
        KEYPUE || ' ' || PUESTO AS PUESTO
        FROM XX_BLOQUEOBAJAS.EMPLEADOS_COMPLETO
        where  KEYEMP = p_empleado ;
    else
      IF p_nombre IS NOT NULL AND  p_paterno IS NOT NULL AND p_materno IS NULL THEN
          open p_result for SELECT KEYEMP,NOMBRE, KEYDEP || ' ' || DEPARTAMENTO AS DEPARTAMENTO,
          KEYPUE || ' ' || PUESTO AS PUESTO
          FROM XX_BLOQUEOBAJAS.EMPLEADOS_COMPLETO
          where  NOMBRES = UPPER(p_nombre) AND PATERNO = UPPER(p_paterno);
      END IF;

      IF p_nombre IS NOT NULL AND  p_paterno IS NOT NULL AND p_materno IS NOT NULL THEN
          open p_result for SELECT KEYEMP,NOMBRE, KEYDEP || ' ' || DEPARTAMENTO AS DEPARTAMENTO,
          KEYPUE || ' ' || PUESTO AS PUESTO
          FROM XX_BLOQUEOBAJAS.EMPLEADOS_COMPLETO
          where  NOMBRES = UPPER(p_nombre) AND PATERNO = UPPER(p_paterno) AND MATERNO = UPPER(p_materno);
      END IF;

      IF p_nombre IS NOT NULL AND  p_paterno IS NULL AND p_materno IS NOT NULL THEN
          open p_result for SELECT KEYEMP,NOMBRE, KEYDEP || ' ' || DEPARTAMENTO AS DEPARTAMENTO,
          KEYPUE || ' ' || PUESTO AS PUESTO
          FROM XX_BLOQUEOBAJAS.EMPLEADOS_COMPLETO
          where  NOMBRES = UPPER(p_nombre) AND MATERNO = UPPER(p_materno) ;
      END IF;

      IF p_nombre IS NULL AND  p_paterno IS NOT NULL AND p_materno IS NOT NULL THEN
          open p_result for SELECT KEYEMP,NOMBRE, KEYDEP || ' ' || DEPARTAMENTO AS DEPARTAMENTO,
          KEYPUE || ' ' || PUESTO AS PUESTO
          FROM XX_BLOQUEOBAJAS.EMPLEADOS_COMPLETO
          where  PATERNO = UPPER(p_paterno) AND MATERNO = UPPER(p_materno) ;
      END IF;

    END IF;


    end;
     PROCEDURE SOLICITUDESINTELECTUS( p_result out SYS_REFCURSOR) as
     begin
        open p_result for
            select sol.IDSOLICITUD, sol.KEYEMP,emp.NOMBRE, emp.KEYDEP || ' ' || emp.DEPARTAMENTO AS DEPARTAMENTO,
            emp.KEYPUE || ' ' || emp.PUESTO AS PUESTO,
            emp.KEYLOC || ' ' || emp.UBICACION AS UBICACION,
            emp.keypro || ' ' || emp.proceso as PROCESO,
            usu.KEYEMP || ' ' || usu.NOMBREUSUARIO AS usuario
            FROM XX_BLOQUEOBAJAS.SOLICITUDES sol
            JOIN XX_BLOQUEOBAJAS.EMPLEADOS_COMPLETO emp ON emp.KEYEMP = sol.keyemp
            JOIN XX_BLOQUEOBAJAS.USUARIOEMPLEADO usu on usu.USUARIO = sol.USUARIO
            WHERE sol.estatus = 1;
     end;

     PROCEDURE DATOSEMPLEADO(p_empleado in number, p_result out SYS_REFCURSOR) as
     begin
        open p_result for
        SELECT KEYDEP || ' ' || DEPARTAMENTO AS DEPARTAMENTO,
        KEYPUE || ' ' || PUESTO AS PUESTO
        FROM XX_BLOQUEOBAJAS.EMPLEADOS_COMPLETO
        where KEYEMP = p_empleado;
     end;

     PROCEDURE EXISTEUSUARIO(p_usuario in varchar2, p_valida out number) as
        actividad XX_BLOQUEOBAJAS.USUARIOEMPLEADO.ROL%TYPE;
        l_baseDatos varchar2(9);
        Correo varchar2(255);
     begin

        select ROL
        into actividad
        from XX_BLOQUEOBAJAS.USUARIOEMPLEADO
        where USUARIO = UPPER(p_usuario);
         p_valida := 1;

        SELECT GLOBAL_NAME INTO l_baseDatos FROM GLOBAL_NAME;

        IF l_baseDatos = 'TVNOMINA' OR l_baseDatos = 'TVNOMDES' THEN
        Correo:= p_usuario||'@televisa.com.mx';
        ELSE
        Correo:= p_usuario||'@izzi.mx';
        END IF;
        UPDATE XX_BLOQUEOBAJAS.USUARIOEMPLEADO SET CORREO = LOWER(EXISTEUSUARIO.Correo)
        WHERE USUARIO = UPPER(p_usuario) AND CORREO IS NULL;
        commit;
         EXCEPTION
         WHEN NO_DATA_FOUND THEN
            p_valida := 0;
     end;

     PROCEDURE INSERTAR_NOTIFICACIONES(p_idsolicitud IN NUMBER, p_tiposolicitud IN NUMBER, p_proceso IN NUMBER) as
     BEGIN
       --INSERTAR NOTIFICACIONES DE TIPO
       --1 NORMAL (Aplica para todas las solcitides. Se hace env????o de notificaci????n cada vez que se inserta una solicitud).
       INSERT INTO XX_BLOQUEOBAJAS.NOTIFICACIONES (IDSOLICITUD, TIPONOTIFICACION,FECHACREACION,ESTATUS,INTENTOS)
       VALUES (p_idsolicitud, 1, sysdate, 0, 0);

       --INSERTAR NOTIFICACIONES DE TIPO
       --2 COMPENSACIONES (Aplica para las solicitudes con tipo de solicitude igual a 0 FUERA DE ESTRUCTURA. Se hace env????o de notificiaci????n cada vez que se inserta una solicitud)
       IF p_tiposolicitud = 0 THEN
         INSERT INTO XX_BLOQUEOBAJAS.NOTIFICACIONES (IDSOLICITUD, TIPONOTIFICACION,FECHACREACION,ESTATUS,INTENTOS)
         VALUES (p_idsolicitud, 2, sysdate, 0, 0);
       END IF;

       --INSERTAR NOTIFICACIONES DE TIPO
       --3 INTELECTUS (Aplica para las solicitudes de los procesos de INTELECTUS. Se hace env????o de notificaciones cada vez que se inserta una solicitud)
       IF VALIDAINTELECTUS(p_proceso) = 1 THEN
         INSERT INTO XX_BLOQUEOBAJAS.NOTIFICACIONES (IDSOLICITUD, TIPONOTIFICACION,FECHACREACION,ESTATUS,INTENTOS)
         VALUES (p_idsolicitud, 3, sysdate, 0, 0);
       END IF;

       --INSERTAR NOTIFICACIONES DE TIPO
       --4 SYSADMIN (Aplica para todas las solicitudes. Se hace un solo env????o diario)
       INSERT INTO XX_BLOQUEOBAJAS.NOTIFICACIONES (IDSOLICITUD, TIPONOTIFICACION,FECHACREACION,ESTATUS,INTENTOS)
       VALUES (p_idsolicitud, 4, sysdate, 0, 0);

       --INSERTAR NOTIFICACIONES DE TIPO
       --5 SYSADMIN TELECOM (Aplica para todas las solicitudes. Se hace un solo env????o diario)
       INSERT INTO XX_BLOQUEOBAJAS.NOTIFICACIONES (IDSOLICITUD, TIPONOTIFICACION,FECHACREACION,ESTATUS,INTENTOS)
       VALUES (p_idsolicitud, 5, sysdate, 0, 0);
     END;

    PROCEDURE BITACORAACCESO(p_usuario in varchar2,
                             p_ip in varchar2,
                             p_nombrepc in varchar2,
                             p_tipo in number,
                             p_motivo in varchar2) as
        p_resp number;
        p_accion varchar2(10);
     begin
       if(p_tipo = 1 ) then
        p_accion := 'ACEPTADO';
        INSERT INTO XX_BLOQUEOBAJAS.BITACORAACCESO VALUES (p_usuario, SYSDATE, 'AE','Acceso correcto');
       else
        p_accion := 'DENEGADO';
        INSERT INTO XX_BLOQUEOBAJAS.BITACORAACCESO VALUES (p_usuario, SYSDATE, 'AF',p_motivo);
       end if;

       /*insert into LAB_BLOQUEO.BITACORAACCESO(USUARIO,ACCION,DIRIP,NOMBREPC,FECHA,MOTIVO)
       VALUES(
       upper( p_usuario),
         p_tipo,
         p_ip,
         p_nombrepc,
         SYSDATE,
         p_motivo
         );
       COMMIT;
       */
     end;
END;
/;
/;
