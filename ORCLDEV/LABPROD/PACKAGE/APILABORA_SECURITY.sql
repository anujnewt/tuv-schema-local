CREATE OR REPLACE NONEDITIONABLE PACKAGE "LABPROD"."APILABORA_SECURITY" AS
  FUNCTION get_hashapi (p_username  IN  VARCHAR2,
                     p_password  IN  VARCHAR2)
    RETURN VARCHAR2;
  PROCEDURE  agrega_usuario (p_usuario  IN  VARCHAR2,
                      p_password  IN  VARCHAR2,
                      p_nombre in varchar2,
                      p_rol in varchar2,
                      p_resp out number,
                      p_mensaje out varchar2) ;
  PROCEDURE activa_usuario(p_usuario IN VARCHAR2,
                            p_resp out number,
                            p_mensaje out varchar2);
  PROCEDURE cambia_password (p_usuario      IN  VARCHAR2,
                             p_old_password  IN  VARCHAR2,
                             p_new_password  IN  VARCHAR2,
                             p_resp out number,
                             p_mensaje out varchar2);
  PROCEDURE actualiza_usuario (p_usuario      IN  VARCHAR2,
                             p_new_password  IN  VARCHAR2,
                             p_nombre in varchar2,
                             p_estatus in varchar2,
                             p_rol in varchar2,
                             p_resp out number,
                             p_mensaje out varchar2);
  PROCEDURE valida_usuario (p_username  IN  VARCHAR2,
                        p_password  IN  VARCHAR2,
                        p_id out number,
                        p_role out VARCHAR2,
                        p_resp out number,
                        p_mensaje out varchar2);
END;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "LABPROD"."APILABORA_SECURITY" AS
  FUNCTION get_hashapi (p_username  IN  VARCHAR2,
                     p_password  IN  VARCHAR2)
    RETURN VARCHAR2 AS
    l_salt VARCHAR2(30) := '1b&?E@@%ntytA7iK';
  BEGIN
    RETURN sys.DBMS_CRYPTO.HASH(UTL_RAW.CAST_TO_RAW(UPPER(p_username) || l_salt || UPPER(p_password)),sys.DBMS_CRYPTO.HASH_SH1);
  END;
  PROCEDURE agrega_usuario (p_usuario  IN  VARCHAR2,
                      p_password  IN  VARCHAR2,
                      p_nombre in varchar2,
                      p_rol in varchar2,
                      p_resp out number,
                      p_mensaje out varchar2) AS
    v_code NUMBER;
    v_errm VARCHAR2(64);
    fila number;
  BEGIN
    p_resp := 1;
    p_mensaje := 'El usuario ' || p_usuario || ' se inserto con exito.';
    begin
    select id
    into fila
    from USUARIOAPI
    WHERE  USUARIO = UPPER(p_usuario);
    EXCEPTION
      when NO_DATA_FOUND then
       fila := 0;
    end;
    if ( fila = 0) then
        INSERT INTO USUARIOAPI (
          id,
          USUARIO,
          PASSWORD,
          NOMBRE,
          ESTATUS,
          ROL
        )
        VALUES (
          REQ_USUARIOAPI_SEQ.NEXTVAL,
          UPPER(p_usuario),
          get_hashapi(p_usuario, p_password),
          p_nombre,
          'A',
          p_rol
        );
    else
        begin
         p_resp := 0;
         p_mensaje := 'El usuario ya existe.';
        end;
    end if;
    COMMIT;
    EXCEPTION
        when others then
            v_code := SQLCODE;
            v_errm := SUBSTR(SQLERRM, 1 , 64);
            p_resp := 0;
            p_mensaje := v_code || ' ' || v_errm;
  END;
  PROCEDURE activa_usuario(p_usuario IN VARCHAR2,
                            p_resp out number,
                            p_mensaje out varchar2) AS
    v_code NUMBER;
    v_errm VARCHAR2(64);
  BEGIN
    p_resp := 1;
    p_mensaje := 'Se actualizo con exito.';
    UPDATE USUARIOAPI SET ESTATUS = 'A'
    WHERE USUARIO = UPPER(p_usuario);
    COMMIT;
    EXCEPTION
        when others then
            v_code := SQLCODE;
            v_errm := SUBSTR(SQLERRM, 1 , 64);
            p_resp := 0;
            p_mensaje := v_code || ' ' || v_errm;
  END;
  PROCEDURE cambia_password (p_usuario     IN  VARCHAR2,
                             p_old_password  IN  VARCHAR2,
                             p_new_password  IN  VARCHAR2,
                             p_resp out number,
                             p_mensaje out varchar2) AS
    v_rowid  number;
     v_code NUMBER;
    v_errm VARCHAR2(64);
  BEGIN
     p_resp := 1;
    p_mensaje := 'Se actualizo con exito.';
    SELECT ID
    INTO   v_rowid
    FROM   USUARIOAPI
    WHERE  USUARIO = UPPER(p_usuario)
    AND    password = get_hashapi(p_usuario, p_old_password)
    FOR UPDATE;
    UPDATE USUARIOAPI
    SET    PASSWORD = get_hashapi(p_usuario, p_new_password)
    WHERE  ID    = v_rowid;
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
  END;
  PROCEDURE actualiza_usuario (p_usuario      IN  VARCHAR2,
                             p_new_password  IN  VARCHAR2,
                             p_nombre in varchar2,
                             p_estatus in varchar2,
                             p_rol in varchar2,
                             p_resp out number,
                             p_mensaje out varchar2) AS
   v_rowid  number;
     v_code NUMBER;
    v_errm VARCHAR2(64);
  BEGIN
     p_resp := 1;
    p_mensaje := 'El usuario ' || p_usuario || ' se actualizo con exito.';
    SELECT ID
    INTO   v_rowid
    FROM   USUARIOAPI
    WHERE  USUARIO = UPPER(p_usuario)
    FOR UPDATE;
    UPDATE USUARIOAPI
    SET    PASSWORD = get_hashapi(p_usuario, p_new_password),
           NOMBRE = p_nombre,
           ROL = p_rol,
           ESTATUS = p_estatus
    WHERE  ID    = v_rowid;
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
  END;
  PROCEDURE valida_usuario (p_username  IN  VARCHAR2,
                        p_password  IN  VARCHAR2,
                        p_id out number,
                        p_role out VARCHAR2,
                        p_resp out number,
                        p_mensaje out varchar2) AS
    v_dummy  VARCHAR2(1);
     v_code NUMBER;
    v_errm VARCHAR2(64);
    veces number;
  BEGIN
    p_resp := 1;
    p_mensaje := 'Acceso.';
    SELECT '1',ID,ROL
    INTO   v_dummy,p_id,p_role
    FROM   USUARIOAPI
    WHERE  USUARIO = UPPER(p_username)
    AND    password = get_hashapi(p_username, p_password)
    and estatus = 'A';
    insert into APIRESTRICCIONACCESO VALUES(upper(p_username),sysdate,1);
    commit;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
       p_resp := 0;
       p_mensaje := 'Usuario invalido.';
       insert into APIRESTRICCIONACCESO VALUES(upper(p_username),sysdate,0);
       commit;
       SELECT count(USUARIO) INTO veces FROM APIRESTRICCIONACCESO
        where usuario = upper(p_username)
        and ROUND(( sysdate - fecha ) * 1440,0) between 0 and 3;
      -- p_resp := veces;
       if ( veces > 2 ) then
         p_resp := 0;
         p_mensaje := 'Usuario ' || p_username || ' fue bloqueado.';
         UPDATE USUARIOAPI SET ESTATUS = 'B'
          WHERE USUARIO = UPPER(p_username);
          commit;
        end if;
    when others then
         v_code := SQLCODE;
            v_errm := SUBSTR(SQLERRM, 1 , 64);
            p_resp := 0;
            p_mensaje := v_code || ' ' || v_errm;
  END;
END;
/;
