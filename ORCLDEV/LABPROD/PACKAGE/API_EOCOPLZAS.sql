CREATE OR REPLACE NONEDITIONABLE PACKAGE "LABPROD"."API_EOCOPLZAS" AS
 PROCEDURE SetEocoplza
 (
    ID_TRANSACCION IN VARCHAR2,
    PLZ_KEYPLZ in NUMBER,
    PLZ_KEYSOL in NUMBER,
    PLZ_KEYPRO in NUMBER,
    PLZ_KEYEST in VARCHAR2,
    PLZ_KEYDEP in VARCHAR2,
    PLZ_KEYPUE in VARCHAR2,
    PLZ_KEYCEN in VARCHAR2,
    PLZ_KEYCAT in VARCHAR2,
    PLZ_KEYLOC in VARCHAR2,
    PLZ_KEYIMS in VARCHAR2,
    PLZ_TIPPLZ in VARCHAR2,
    PLZ_TIPCON in VARCHAR2,
    PLZ_CONTRA in VARCHAR2,
    PLZ_FECINI in DATE,
    PLZ_FECFIN in DATE,
    PLZ_TURNOP in NUMBER,
    PLZ_KEYHOR in VARCHAR2,
    PLZ_KEYEMP in NUMBER,
    PLZ_CVEUOC in NUMBER,
    PLZ_TITULA in NUMBER,
    PLZ_CVEREM in NUMBER,
    PLZ_STATUS in VARCHAR2,
    PLZ_KEYMOT in VARCHAR2,
    PLZ_FECMOV in DATE,
    PLZ_HORMOV in VARCHAR2,
    PLZ_COSPLZ in NUMBER,
    PLZ_KEYSUE in VARCHAR2,
    PLZ_TIPTAB in VARCHAR2,
    PLZ_SUENIV in NUMBER,
    PLZ_SUBNIV in NUMBER,
    PLZ_COBERT in VARCHAR2,
    PLZ_FECOCU in DATE,
    PLZ_SALPLZ in NUMBER,
    PLZ_ORIGEN in VARCHAR2,
    PLZ_CODOCU in VARCHAR2,
    PLZ_LIMOCU in DATE,
    PLZ_CA1AUX in VARCHAR2,
    PLZ_CA2AUX in VARCHAR2,
    PLZ_CA3AUX in VARCHAR2,
    PLZ_CA4AUX in VARCHAR2,
    PLZ_CA5AUX in VARCHAR2,
    PLZ_CA6AUX in VARCHAR2,
    PLZ_CA7AUX in VARCHAR2,
    PLZ_CA8AUX in VARCHAR2,
    STATUS out varchar2,
    CODE out varchar2,
    MESSAGE out varchar2,
    FECHA out date
 );
 PROCEDURE SetEocoplzaEnc
 (
    ID_TRANSACCION IN VARCHAR2,
    PLZ_KEYPLZ in VARCHAR2,
    PLZ_KEYSOL in VARCHAR2,
    PLZ_KEYPRO in VARCHAR2,
    PLZ_KEYEST in VARCHAR2,
    PLZ_KEYDEP in VARCHAR2,
    PLZ_KEYPUE in VARCHAR2,
    PLZ_KEYCEN in VARCHAR2,
    PLZ_KEYCAT in VARCHAR2,
    PLZ_KEYLOC in VARCHAR2,
    PLZ_KEYIMS in VARCHAR2,
    PLZ_TIPPLZ in VARCHAR2,
    PLZ_TIPCON in VARCHAR2,
    PLZ_CONTRA in VARCHAR2,
    PLZ_FECINI in VARCHAR2,
    PLZ_FECFIN in VARCHAR2,
    PLZ_TURNOP in VARCHAR2,
    PLZ_KEYHOR in VARCHAR2,
    PLZ_KEYEMP in VARCHAR2,
    PLZ_CVEUOC in VARCHAR2,
    PLZ_TITULA in VARCHAR2,
    PLZ_CVEREM in VARCHAR2,
    PLZ_STATUS in VARCHAR2,
    PLZ_KEYMOT in VARCHAR2,
    PLZ_FECMOV in VARCHAR2,
    PLZ_HORMOV in VARCHAR2,
    PLZ_COSPLZ in VARCHAR2,
    PLZ_KEYSUE in VARCHAR2,
    PLZ_TIPTAB in VARCHAR2,
    PLZ_SUENIV in VARCHAR2,
    PLZ_SUBNIV in VARCHAR2,
    PLZ_COBERT in VARCHAR2,
    PLZ_FECOCU in VARCHAR2,
    PLZ_SALPLZ in VARCHAR2,
    PLZ_ORIGEN in VARCHAR2,
    PLZ_CODOCU in VARCHAR2,
    PLZ_LIMOCU in VARCHAR2,
    PLZ_CA1AUX in VARCHAR2,
    PLZ_CA2AUX in VARCHAR2,
    PLZ_CA3AUX in VARCHAR2,
    PLZ_CA4AUX in VARCHAR2,
    PLZ_CA5AUX in VARCHAR2,
    PLZ_CA6AUX in VARCHAR2,
    PLZ_CA7AUX in VARCHAR2,
    PLZ_CA8AUX in VARCHAR2,
    STATUS out varchar2,
    CODE out varchar2,
    MESSAGE out varchar2,
    FECHA out date
 );
END;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "LABPROD"."API_EOCOPLZAS" AS
PROCEDURE SetEocoplza
(
ID_TRANSACCION IN VARCHAR2,
PLZ_KEYPLZ in NUMBER,
PLZ_KEYSOL in NUMBER,
PLZ_KEYPRO in NUMBER,
PLZ_KEYEST in VARCHAR2,
PLZ_KEYDEP in VARCHAR2,
PLZ_KEYPUE in VARCHAR2,
PLZ_KEYCEN in VARCHAR2,
PLZ_KEYCAT in VARCHAR2,
PLZ_KEYLOC in VARCHAR2,
PLZ_KEYIMS in VARCHAR2,
PLZ_TIPPLZ in VARCHAR2,
PLZ_TIPCON in VARCHAR2,
PLZ_CONTRA in VARCHAR2,
PLZ_FECINI in DATE,
PLZ_FECFIN in DATE,
PLZ_TURNOP in NUMBER,
PLZ_KEYHOR in VARCHAR2,
PLZ_KEYEMP in NUMBER,
PLZ_CVEUOC in NUMBER,
PLZ_TITULA in NUMBER,
PLZ_CVEREM in NUMBER,
PLZ_STATUS in VARCHAR2,
PLZ_KEYMOT in VARCHAR2,
PLZ_FECMOV in DATE,
PLZ_HORMOV in VARCHAR2,
PLZ_COSPLZ in NUMBER,
PLZ_KEYSUE in VARCHAR2,
PLZ_TIPTAB in VARCHAR2,
PLZ_SUENIV in NUMBER,
PLZ_SUBNIV in NUMBER,
PLZ_COBERT in VARCHAR2,
PLZ_FECOCU in DATE,
PLZ_SALPLZ in NUMBER,
PLZ_ORIGEN in VARCHAR2,
PLZ_CODOCU in VARCHAR2,
PLZ_LIMOCU in DATE,
PLZ_CA1AUX in VARCHAR2,
PLZ_CA2AUX in VARCHAR2,
PLZ_CA3AUX in VARCHAR2,
PLZ_CA4AUX in VARCHAR2,
PLZ_CA5AUX in VARCHAR2,
PLZ_CA6AUX in VARCHAR2,
PLZ_CA7AUX in VARCHAR2,
PLZ_CA8AUX in VARCHAR2,
STATUS out varchar2,
CODE out varchar2,
MESSAGE out varchar2,
FECHA out date
) as
plaza number;
proceso number;
departamento number;
puesto number;
centrocosto number;
localidad number;
imss number;
empleado number;
emp_plz number;
categoria number;
estructura number;
tabulador number;
motivo number;
KEYIMS varchar(5);
KEYCIA VARCHAR(5);
tipodato int ;
BEGIN
    FECHA := SYSDATE;
    KEYIMS :=  NULL;
    tipodato := null;
    IF ID_TRANSACCION = '0' THEN
    Status := 'OK';
    Code := '0';
    Message := 'PRUEBA DE SERVICIO';
    ELSE
    --VALIDACIONES
    Code  := '1';
    Status := 'OK';
    /*IF LENGTH(PLZ_KEYPLZ) > 38	THEN
        Message:= 'PLZ_KEYPLZ LONGITUD MAYOR A 38';
        Status := 'ERROR';
        Code := '2';
    END IF;
    IF LENGTH(PLZ_KEYSOL ) > 38	THEN
        Message:= 'PLZ_KEYSOL  LONGITUD MAYOR A 38';
        Status := 'ERROR';
        Code := '2';
    END IF;
    IF LENGTH(PLZ_KEYPRO) > 38	THEN
        Message:= 'PLZ_KEYPRO LONGITUD MAYOR A 38';
        Status := 'ERROR';
        Code := '2';
    END IF;
*/
    /*IF LENGTH(PLZ_KEYEST) > 38	THEN
        Message:= 'PLZ_KEYEST LONGITUD MAYOR A 3';
        Status := 'ERROR';
        Code := '2';
    END IF;
    */
  /*  IF LENGTH(PLZ_KEYDEP) > 16	THEN
        Message:= 'PLZ_KEYDEP LONGITUD MAYOR A 16';
        Status := 'ERROR';
        Code := '2';
    END IF;
    IF LENGTH(PLZ_KEYPUE) > 16	THEN
        Message:= 'PLZ_KEYPUE LONGITUD MAYOR A 16';
        Status := 'ERROR';
        Code := '2';
    END IF;
     IF LENGTH(PLZ_KEYIMS) > 14	THEN
        Message:= 'PLZ_KEYPUE LONGITUD MAYOR A 14';
        Status := 'ERROR';
        Code := '2';
    END IF;
*/
    SELECT COUNT(*) INTO proceso FROM LABPROD.NMLOPROC WHERE PRO_KEYPRO = SetEocoplza.PLZ_KEYPRO;
    if proceso  = 0 then
        Status := 'ERROR';
        Code := '001';
        Message := 'Proceso No existe';
    end if;
    SELECT COUNT(*) INTO departamento FROM LABPROD.NMCODEPS WHERE DEP_KEYDEP= SetEocoplza.PLZ_KEYDEP;
    if departamento  = 0 then
        Status := 'ERROR';
        Code := '002';
        Message := 'Departamento No existe';
    end if;
    SELECT COUNT(*) INTO puesto FROM LABPROD.NMCOPUES WHERE PUE_KEYPUE = SetEocoplza.PLZ_KEYPUE;
    if puesto  = 0 then
        Status := 'ERROR';
        Code := '003';
        Message := 'Puesto No existe';
    end if;
/*
    SELECT COUNT(*) INTO centrocosto FROM LABPROD.NMLOCENC WHERE CEN_KEYCEN= SetEocoplza.PLZ_KEYCEN;
    if centrocosto  = 0 then
        Status := 'ERROR';
        Code := '004';
        Message := 'Centro de Costos No existe';
    end if;
    SELECT COUNT(*) INTO localidad FROM LABPROD.NMLOLOCP WHERE LOC_KEYLOC= SetEocoplza.PLZ_KEYLOC;
    if localidad  = 0 then
        Status := 'ERROR';
        Code := '005';
        Message := 'Localidad No existe';
    end if;
    */
/*
    SELECT COUNT(*) INTO imss FROM LABPROD.NMLOIMSS WHERE IMS_KEYIMS= SetEocoplza.PLZ_KEYIMS;
    if imss  = 0 then
        Status := 'ERROR';
        Code := '2';
        Message := 'IMSS No existe';
    end if;
*/
     /*SELECT COUNT(*) INTO categoria FROM LABPROD.NMLOCATE WHERE CAT_KEYCAT= SetEocoplza.PLZ_KEYCAT;
    if categoria  = 0 then
        Status := 'ERROR';
        Code := '007';
        Message := 'Categoria No existe';
    end if;
*/
/*
if SetEocoplza.PLZ_KEYEMP != 0 then
    SELECT COUNT(*) INTO empleado FROM LABPROD.NMCOEMPL WHERE EMP_KEYEMP = SetEocoplza.PLZ_KEYEMP;
    if empleado = 0 then
        Status := 'ERROR';
        Code := '008';
        Message := 'Empleado no existe.';
    end if;
end if;
*/
/*
    SELECT COUNT(*) INTO estructura FROM LABPROD.EOLODEST WHERE DES_KEYEST = SetEocoplza.PLZ_KEYEST;
    if estructura = 0 then
        Status := 'ERROR';
        Code := '2';
        Message := 'Estructura no Existe.';
    end if;
*/
/*
    SELECT COUNT(*) INTO motivo FROM LABPROD.GLCOPAMS WHERE PAM_KEYPAR= 'MOT' AND PAM_CVESEC =  SetEocoplza.PLZ_KEYMOT;
    if motivo = 0 then
        Status := 'ERROR';
        Code := '009';
        Message := 'Motivo No existe.';
    end if;
*/
   -- IMSS:= null;
   if PLZ_KEYIMS is not null then
    SELECT COUNT(*) INTO IMSS  FROM LABPROD.NMLOIMSS WHERE NMLOIMSS.IMS_RFCIMS = SetEocoplza.PLZ_KEYIMS;
    IF IMSS = 0 THEN
        Status := 'ERROR';
        Code := '006';
        Message := 'Registro Patronal No existe.';
        else
        SELECT IMS_KEYIMS INTO KEYIMS FROM LABPROD.NMLOIMSS WHERE NMLOIMSS.IMS_RFCIMS = SetEocoplza.PLZ_KEYIMS;
    END IF;
end if;
    IF  Code = '1' THEN
        Status := 'OK';
        Code := '3';
        Message := 'SE INSERT? CORRECTAMENTE EN STAGING ';
        DBMS_OUTPUT.PUT_LINE (' ' ||  SetEocoplza.PLZ_KEYEST );
        Insert into LABPROD.API_EOCOPLZA
        (ID_TRANSACCION,PLZ_KEYPLZ,PLZ_KEYSOL,PLZ_KEYPRO,PLZ_KEYEST,PLZ_KEYDEP,PLZ_KEYPUE,PLZ_KEYCEN,PLZ_KEYCAT,PLZ_KEYLOC,PLZ_KEYIMS,PLZ_TIPPLZ,PLZ_TIPCON,PLZ_CONTRA,PLZ_FECINI,PLZ_FECFIN,
        PLZ_TURNOP,PLZ_KEYHOR,PLZ_KEYEMP,PLZ_CVEUOC,PLZ_TITULA,PLZ_CVEREM,PLZ_STATUS,PLZ_KEYMOT,PLZ_FECMOV,PLZ_HORMOV,PLZ_COSPLZ,PLZ_KEYSUE,PLZ_TIPTAB,PLZ_SUENIV,PLZ_SUBNIV,PLZ_COBERT,
        PLZ_FECOCU,PLZ_SALPLZ,PLZ_ORIGEN,PLZ_CODOCU,PLZ_LIMOCU,PLZ_CA1AUX,PLZ_CA2AUX,PLZ_CA3AUX,PLZ_CA4AUX,PLZ_CA5AUX,PLZ_CA6AUX,PLZ_CA7AUX,PLZ_CA8AUX,
        ESTATUS,CODE,MESSAGE,FECHA_INSERT)
        values (SetEocoplza.ID_TRANSACCION,SetEocoplza.PLZ_KEYPLZ,SetEocoplza.PLZ_KEYSOL,SetEocoplza.PLZ_KEYPRO,SetEocoplza.PLZ_KEYEST,SetEocoplza.PLZ_KEYDEP,SetEocoplza.PLZ_KEYPUE,SetEocoplza.PLZ_KEYCEN,
        SetEocoplza.PLZ_KEYCAT,SetEocoplza.PLZ_KEYLOC,SetEocoplza.PLZ_KEYIMS,SetEocoplza.PLZ_TIPPLZ,SetEocoplza.PLZ_TIPCON,SetEocoplza.PLZ_CONTRA,SetEocoplza.PLZ_FECINI,SetEocoplza.PLZ_FECFIN,
        SetEocoplza.PLZ_TURNOP,SetEocoplza.PLZ_KEYHOR,SetEocoplza.PLZ_KEYEMP,SetEocoplza.PLZ_CVEUOC,SetEocoplza.PLZ_TITULA,SetEocoplza.PLZ_CVEREM,SetEocoplza.PLZ_STATUS,SetEocoplza.PLZ_KEYMOT,
        SetEocoplza.PLZ_FECMOV,SetEocoplza.PLZ_HORMOV,SetEocoplza.PLZ_COSPLZ,SetEocoplza.PLZ_KEYSUE,SetEocoplza.PLZ_TIPTAB,SetEocoplza.PLZ_SUENIV,SetEocoplza.PLZ_SUBNIV,SetEocoplza.PLZ_COBERT,
        SetEocoplza.PLZ_FECOCU,SetEocoplza.PLZ_SALPLZ,SetEocoplza.PLZ_ORIGEN,SetEocoplza.PLZ_CODOCU,SetEocoplza.PLZ_LIMOCU,SetEocoplza.PLZ_CA1AUX,SetEocoplza.PLZ_CA2AUX,
        SetEocoplza.PLZ_CA3AUX,SetEocoplza.PLZ_CA4AUX,SetEocoplza.PLZ_CA5AUX,SetEocoplza.PLZ_CA6AUX,SetEocoplza.PLZ_CA7AUX,SetEocoplza.PLZ_CA8AUX,
        STATUS,CODE,MESSAGE,FECHA);
        COMMIT;
        select count(*) into plaza from labprod.eocoplza where  PLZ_KEYPLZ = SetEocoplza.PLZ_KEYPLZ;
        KEYCIA:= SetEocoplza.PLZ_KEYEST;
        if keycia is null or keycia = '' then
        SELECT CIA_KEYCIA INTO KEYCIA FROM LABPROD.NMLOPROC, LABPROD.NMLOCIAS WHERE PRO_KEYPRO = SetEocoplza.PLZ_KEYPRO AND PRO_KEYCIA = CIA_KEYCIA;
         DBMS_OUTPUT.PUT_LINE ('2 ' ||  KEYCIA );
        end if;
        if  plaza = 0 then
            BEGIN
            Insert into LABPROD.EOCOPLZA
            (PLZ_KEYPLZ,PLZ_KEYSOL,PLZ_KEYPRO,PLZ_KEYEST,PLZ_KEYDEP,PLZ_KEYPUE,PLZ_KEYCEN,PLZ_KEYCAT,PLZ_KEYLOC,PLZ_KEYIMS,PLZ_TIPPLZ,PLZ_TIPCON,PLZ_CONTRA,PLZ_FECINI,PLZ_FECFIN,
            PLZ_TURNOP,PLZ_KEYHOR,PLZ_CVEUOC,PLZ_TITULA,PLZ_CVEREM,PLZ_STATUS,PLZ_KEYMOT,PLZ_FECMOV,PLZ_HORMOV,PLZ_COSPLZ,PLZ_KEYSUE,PLZ_TIPTAB,PLZ_SUENIV,PLZ_SUBNIV,PLZ_COBERT,
            PLZ_FECOCU,PLZ_SALPLZ,PLZ_ORIGEN,PLZ_CODOCU,PLZ_LIMOCU,PLZ_CA1AUX,PLZ_CA2AUX,PLZ_CA3AUX,PLZ_CA4AUX,PLZ_CA5AUX,PLZ_CA6AUX,PLZ_CA7AUX,PLZ_CA8AUX)
            values (SetEocoplza.PLZ_KEYPLZ,SetEocoplza.PLZ_KEYSOL,SetEocoplza.PLZ_KEYPRO,KEYCIA,SetEocoplza.PLZ_KEYDEP,SetEocoplza.PLZ_KEYPUE,SetEocoplza.PLZ_KEYCEN,
            SetEocoplza.PLZ_KEYCAT,SetEocoplza.PLZ_KEYLOC,SetEocoplza.KEYIMS,SetEocoplza.PLZ_TIPPLZ,SetEocoplza.PLZ_TIPCON,SetEocoplza.PLZ_CONTRA,SetEocoplza.PLZ_FECINI,SetEocoplza.PLZ_FECFIN,
            SetEocoplza.PLZ_TURNOP,SetEocoplza.PLZ_KEYHOR,SetEocoplza.PLZ_CVEUOC,SetEocoplza.PLZ_TITULA,SetEocoplza.PLZ_CVEREM,SetEocoplza.PLZ_STATUS,SetEocoplza.PLZ_KEYMOT,
            SetEocoplza.PLZ_FECMOV,SetEocoplza.PLZ_HORMOV,SetEocoplza.PLZ_COSPLZ,SetEocoplza.PLZ_KEYSUE,SetEocoplza.PLZ_TIPTAB,SetEocoplza.PLZ_SUENIV,SetEocoplza.PLZ_SUBNIV,SetEocoplza.PLZ_COBERT,
            SetEocoplza.PLZ_FECOCU,SetEocoplza.PLZ_SALPLZ,SetEocoplza.PLZ_ORIGEN,SetEocoplza.PLZ_CODOCU,SetEocoplza.PLZ_LIMOCU,SetEocoplza.PLZ_CA1AUX,SetEocoplza.PLZ_CA2AUX,
            SetEocoplza.PLZ_CA3AUX,SetEocoplza.PLZ_CA4AUX,SetEocoplza.PLZ_CA5AUX,SetEocoplza.PLZ_CA6AUX,SetEocoplza.PLZ_CA7AUX,SetEocoplza.PLZ_CA8AUX);
            COMMIT;
            Status := 'OK';
            Code := '3';
            Message := 'Se proces? con ?xito';
            UPDATE LABPROD.API_EOCOPLZA SET ESTATUS=SetEocoplza.Status,CODE=SetEocoplza.Code,MESSAGE=SetEocoplza.Message,FECHA_PROC=SYSDATE
            WHERE API_EOCOPLZA.ID_TRANSACCION =SetEocoplza.ID_TRANSACCION;
            COMMIT;
            EXCEPTION when others then
            Status := 'ERROR';
            Code := SQLCODE;
            Message := SUBSTR(SQLERRM, 1 , 150);
            UPDATE LABPROD.API_EOCOPLZA SET ESTATUS=SetEocoplza.Status,CODE=SetEocoplza.Code,MESSAGE=SetEocoplza.Message,FECHA_PROC=SYSDATE
            WHERE API_EOCOPLZA.ID_TRANSACCION =SetEocoplza.ID_TRANSACCION;
            COMMIT;
            END;
        end if;
        if  plaza > 0 then
            BEGIN
            UPDATE LABPROD.EOCOPLZA SET
            EOCOPLZA.PLZ_KEYPLZ = SetEocoplza.PLZ_KEYPLZ, EOCOPLZA.PLZ_KEYSOL = SetEocoplza.PLZ_KEYSOL, EOCOPLZA.PLZ_KEYPRO = SetEocoplza.PLZ_KEYPRO,
            EOCOPLZA.PLZ_KEYEST = KEYCIA ,
            EOCOPLZA.PLZ_KEYDEP = SetEocoplza.PLZ_KEYDEP, EOCOPLZA.PLZ_KEYPUE = SetEocoplza.PLZ_KEYPUE,
            EOCOPLZA.PLZ_KEYCEN = SetEocoplza.PLZ_KEYCEN, EOCOPLZA.PLZ_KEYCAT = SetEocoplza.PLZ_KEYCAT, EOCOPLZA.PLZ_KEYLOC = SetEocoplza.PLZ_KEYLOC,
            EOCOPLZA.PLZ_KEYIMS = SetEocoplza.KEYIMS, EOCOPLZA.PLZ_TIPPLZ = SetEocoplza.PLZ_TIPPLZ, EOCOPLZA.PLZ_TIPCON = SetEocoplza.PLZ_TIPCON,
            EOCOPLZA.PLZ_CONTRA = SetEocoplza.PLZ_CONTRA, EOCOPLZA.PLZ_FECINI = SetEocoplza.PLZ_FECINI, EOCOPLZA.PLZ_FECFIN = SetEocoplza.PLZ_FECFIN,
            EOCOPLZA.PLZ_TURNOP = SetEocoplza.PLZ_TURNOP, EOCOPLZA.PLZ_KEYHOR = SetEocoplza.PLZ_KEYHOR,
            EOCOPLZA.PLZ_CVEUOC = SetEocoplza.PLZ_CVEUOC, EOCOPLZA.PLZ_TITULA = SetEocoplza.PLZ_TITULA, EOCOPLZA.PLZ_CVEREM = SetEocoplza.PLZ_CVEREM,
            EOCOPLZA.PLZ_STATUS = SetEocoplza.PLZ_STATUS, EOCOPLZA.PLZ_KEYMOT = SetEocoplza.PLZ_KEYMOT, EOCOPLZA.PLZ_FECMOV = SetEocoplza.PLZ_FECMOV,
            EOCOPLZA.PLZ_HORMOV = SetEocoplza.PLZ_HORMOV, EOCOPLZA.PLZ_COSPLZ = SetEocoplza.PLZ_COSPLZ, EOCOPLZA.PLZ_KEYSUE = SetEocoplza.PLZ_KEYSUE,
            EOCOPLZA.PLZ_TIPTAB = SetEocoplza.PLZ_TIPTAB, EOCOPLZA.PLZ_SUENIV = SetEocoplza.PLZ_SUENIV, EOCOPLZA.PLZ_SUBNIV = SetEocoplza.PLZ_SUBNIV,
            EOCOPLZA.PLZ_COBERT = SetEocoplza.PLZ_COBERT, EOCOPLZA.PLZ_FECOCU = SetEocoplza.PLZ_FECOCU, EOCOPLZA.PLZ_SALPLZ = SetEocoplza.PLZ_SALPLZ,
            EOCOPLZA.PLZ_ORIGEN = SetEocoplza.PLZ_ORIGEN, EOCOPLZA.PLZ_CODOCU = SetEocoplza.PLZ_CODOCU, EOCOPLZA.PLZ_LIMOCU = SetEocoplza.PLZ_LIMOCU,
            EOCOPLZA.PLZ_CA1AUX = SetEocoplza.PLZ_CA1AUX, EOCOPLZA.PLZ_CA2AUX = SetEocoplza.PLZ_CA2AUX, EOCOPLZA.PLZ_CA3AUX = SetEocoplza.PLZ_CA3AUX,
            EOCOPLZA.PLZ_CA4AUX = SetEocoplza.PLZ_CA4AUX, EOCOPLZA.PLZ_CA5AUX = SetEocoplza.PLZ_CA5AUX, EOCOPLZA.PLZ_CA6AUX = SetEocoplza.PLZ_CA6AUX,
            EOCOPLZA.PLZ_CA7AUX = SetEocoplza.PLZ_CA7AUX, EOCOPLZA.PLZ_CA8AUX = SetEocoplza.PLZ_CA8AUX
            where  EOCOPLZA.PLZ_KEYPLZ= SetEocoplza.PLZ_KEYPLZ;
            COMMIT;
            Status := 'OK';
            Code := '3';
            Message := 'Se proces? con ?xito';
            UPDATE LABPROD.API_EOCOPLZA SET ESTATUS=SetEocoplza.Status,CODE=SetEocoplza.Code,MESSAGE=SetEocoplza.Message,FECHA_PROC=SYSDATE WHERE API_EOCOPLZA.ID_TRANSACCION =SetEocoplza.ID_TRANSACCION;
            COMMIT;
            EXCEPTION when others then
            Status := 'ERROR';
            Code := SQLCODE;
            Message := SUBSTR(SQLERRM, 1 , 150);
            --UPDATE LABPROD.API_EOCOPLZA SET ESTATUS=SetEocoplza.Status,CODE=SetEocoplza.Code,MESSAGE=SetEocoplza.Message,FECHA_PROC=SYSDATE WHERE API_EOCOPLZA.ID_TRANSACCION =SetEocoplza.ID_TRANSACCION;
            COMMIT;
            END;
        end if;
        DELETE FROM LABPROD.wesuperv WHERE sup_keyemp = SetEocoplza.PLZ_KEYEMP;
        INSERT INTO LABPROD.wesuperv (sup_keysup,sup_keyemp) VALUES (NVL(SetEocoplza.PLZ_CVEREM,0),NVL(SetEocoplza.PLZ_KEYEMP,0));
        DELETE FROM LABPROD.wevaljef WHERE val_keyemp = SetEocoplza.PLZ_KEYEMP;
    END IF;
END IF;
END;
PROCEDURE SetEocoplzaEnc (
    ID_TRANSACCION IN VARCHAR2,
    PLZ_KEYPLZ in VARCHAR2,
    PLZ_KEYSOL in VARCHAR2,
    PLZ_KEYPRO in VARCHAR2,
    PLZ_KEYEST in VARCHAR2,
    PLZ_KEYDEP in VARCHAR2,
    PLZ_KEYPUE in VARCHAR2,
    PLZ_KEYCEN in VARCHAR2,
    PLZ_KEYCAT in VARCHAR2,
    PLZ_KEYLOC in VARCHAR2,
    PLZ_KEYIMS in VARCHAR2,
    PLZ_TIPPLZ in VARCHAR2,
    PLZ_TIPCON in VARCHAR2,
    PLZ_CONTRA in VARCHAR2,
    PLZ_FECINI in VARCHAR2,
    PLZ_FECFIN in VARCHAR2,
    PLZ_TURNOP in VARCHAR2,
    PLZ_KEYHOR in VARCHAR2,
    PLZ_KEYEMP in VARCHAR2,
    PLZ_CVEUOC in VARCHAR2,
    PLZ_TITULA in VARCHAR2,
    PLZ_CVEREM in VARCHAR2,
    PLZ_STATUS in VARCHAR2,
    PLZ_KEYMOT in VARCHAR2,
    PLZ_FECMOV in VARCHAR2,
    PLZ_HORMOV in VARCHAR2,
    PLZ_COSPLZ in VARCHAR2,
    PLZ_KEYSUE in VARCHAR2,
    PLZ_TIPTAB in VARCHAR2,
    PLZ_SUENIV in VARCHAR2,
    PLZ_SUBNIV in VARCHAR2,
    PLZ_COBERT in VARCHAR2,
    PLZ_FECOCU in VARCHAR2,
    PLZ_SALPLZ in VARCHAR2,
    PLZ_ORIGEN in VARCHAR2,
    PLZ_CODOCU in VARCHAR2,
    PLZ_LIMOCU in VARCHAR2,
    PLZ_CA1AUX in VARCHAR2,
    PLZ_CA2AUX in VARCHAR2,
    PLZ_CA3AUX in VARCHAR2,
    PLZ_CA4AUX in VARCHAR2,
    PLZ_CA5AUX in VARCHAR2,
    PLZ_CA6AUX in VARCHAR2,
    PLZ_CA7AUX in VARCHAR2,
    PLZ_CA8AUX in VARCHAR2,
    Status OUT  VARCHAR2,
    Code OUT  VARCHAR2,
    Message OUT  VARCHAR2,
    Fecha OUT DATE)
    as
    existe int ;
BEGIN
    Fecha := SYSDATE;
    IF ID_TRANSACCION = '0' THEN
    Status := 'OK';
    Code := '0';
    Message := 'PRUEBA DE SERVICIO';
    ELSE
    Code :=1;
        SELECT COUNT(ID_TRANSACCION) INTO  existe  FROM LABPROD.API_EOCOPLZA WHERE API_EOCOPLZA.ID_TRANSACCION = SetEocoplzaEnc.ID_TRANSACCION;
        if existe != 0  then
                Status := 'ERROR';
                Code := '006';
                Message := 'ID_TRANSACCI?N DUPLICADO';
        end if;
       IF PLZ_KEYPLZ IS NOT NULL THEN
           IF F_IS_INT(FN_DECODE(PLZ_KEYPLZ)) = 0 THEN
                Status := 'ERROR';
                Code := '006';
                Message := 'PLZ_KEYPLZ NO ES DE TIPO INT';
            END IF;
        END IF;
       IF PLZ_KEYSOL IS NOT NULL THEN
            IF F_IS_INT(FN_DECODE(PLZ_KEYSOL)) = 0 THEN
                Status := 'ERROR';
                Code := '006';
                Message := 'PLZ_KEYSOL NO ES DE TIPO INT';
            END IF;
        END IF;
        IF PLZ_KEYPRO IS NOT NULL THEN
            IF F_IS_INT(FN_DECODE(PLZ_KEYPRO)) = 0 THEN
                Status := 'ERROR';
                Code := '006';
                Message := 'PLZ_KEYPRO NO ES DE TIPO INT';
            END IF;
        END IF;
        IF PLZ_TURNOP IS NOT NULL THEN
            IF F_IS_INT(FN_DECODE(PLZ_TURNOP)) = 0 THEN
                Status := 'ERROR';
                Code := '006';
                Message := 'PLZ_TURNOP NO ES DE TIPO INT';
            END IF;
        END IF;
        IF PLZ_KEYEMP IS NOT NULL THEN
            IF F_IS_INT(FN_DECODE(PLZ_KEYEMP)) = 0 THEN
                Status := 'ERROR';
                Code := '006';
                Message := 'PLZ_KEYEMP NO ES DE TIPO INT';
            END IF;
        END IF;
        IF PLZ_CVEUOC  IS NOT NULL THEN
            IF F_IS_INT(FN_DECODE(PLZ_CVEUOC)) = 0 THEN
                Status := 'ERROR';
                Code := '006';
                Message := 'PLZ_CVEUOC NO ES DE TIPO INT';
            END IF;
        END IF;
        IF PLZ_TITULA IS NOT NULL THEN
            IF F_IS_INT(FN_DECODE(PLZ_TITULA)) = 0 THEN
                Status := 'ERROR';
                Code := '006';
                Message := 'PLZ_TITULA NO ES DE TIPO INT';
            END IF;
        END IF;
        IF PLZ_CVEREM IS NOT NULL THEN
            IF F_IS_INT(FN_DECODE(PLZ_CVEREM)) = 0 THEN
                Status := 'ERROR';
                Code := '006';
                Message := 'PLZ_CVEREM NO ES DE TIPO INT';
            END IF;
        END IF;
        IF PLZ_COSPLZ IS NOT NULL THEN
            IF F_IS_INT(FN_DECODE(PLZ_COSPLZ)) = 0 THEN
                Status := 'ERROR';
                Code := '006';
                Message := 'PLZ_COSPLZ NO ES DE TIPO INT';
            END IF;
        END IF;
        IF PLZ_SUENIV IS NOT NULL THEN
        IF F_IS_INT(FN_DECODE(PLZ_SUENIV)) = 0 THEN
            Status := 'ERROR';
            Code := '006';
            Message := 'PLZ_SUENIV NO ES DE TIPO INT';
        END IF;
        END IF;
       IF PLZ_SUBNIV IS NOT NULL THEN
        IF  F_IS_INT(FN_DECODE(PLZ_SUBNIV)) = 0   THEN
            Status := 'ERROR';
            Code := '006';
            Message := 'PLZ_SUBNIV NO ES DE TIPO INT';
        END IF;
     END IF;
     IF PLZ_SALPLZ IS NOT NULL THEN
          IF F_IS_INT(FN_DECODE(PLZ_SALPLZ)) = 0 THEN
            Status := 'ERROR';
            Code := '006';
            Message := 'PLZ_SALPLZ NO ES DE TIPO INT';
        END IF;
    END IF;
     IF PLZ_FECINI IS NOT NULL THEN
          IF ISDATE(FN_DECODE(PLZ_FECINI),'YYYY-MM-DD') = 'FALSE' THEN
            Status := 'ERROR';
            Code := '006';
            Message := 'PLZ_FECINI NO ES UNA FECHA VALIDA';
        END IF;
    END IF;
     IF PLZ_FECFIN IS NOT NULL THEN
          IF ISDATE(FN_DECODE(PLZ_FECFIN),'YYYY-MM-DD') = 'FALSE' THEN
            Status := 'ERROR';
            Code := '006';
            Message := 'PLZ_FECFIN NO ES ES UNA FECHA VALIDA';
        END IF;
    END IF;
    IF PLZ_FECMOV IS NOT NULL THEN
          IF ISDATE(FN_DECODE(PLZ_FECMOV),'YYYY-MM-DD') = 'FALSE' THEN
            Status := 'ERROR';
            Code := '006';
            Message := 'PLZ_FECMOV NO ES ES UNA FECHA VALIDA';
        END IF;
    END IF;
    IF  PLZ_FECOCU IS NOT NULL THEN
          IF ISDATE(FN_DECODE( PLZ_FECOCU),'YYYY-MM-DD') = 'FALSE' THEN
            Status := 'ERROR';
            Code := '006';
            Message := ' PLZ_FECOCU NO ES ES UNA FECHA VALIDA';
        END IF;
    END IF;
    IF  PLZ_LIMOCU IS NOT NULL THEN
          IF ISDATE(FN_DECODE( PLZ_LIMOCU),'YYYY-MM-DD') = 'FALSE' THEN
            Status := 'ERROR';
            Code := '006';
            Message := ' PLZ_LIMOCU NO ES ES UNA FECHA VALIDA';
        END IF;
    END IF;
    if code = 1 then
    BEGIN
        SetEocoplza (ID_TRANSACCION,FN_DECODE(PLZ_KEYPLZ),FN_DECODE(PLZ_KEYSOL),FN_DECODE(PLZ_KEYPRO),FN_DECODE(PLZ_KEYEST),FN_DECODE(PLZ_KEYDEP),FN_DECODE(PLZ_KEYPUE),FN_DECODE(PLZ_KEYCEN),
        FN_DECODE(PLZ_KEYCAT),FN_DECODE(PLZ_KEYLOC),FN_DECODE(PLZ_KEYIMS),FN_DECODE(PLZ_TIPPLZ),FN_DECODE(PLZ_TIPCON),FN_DECODE(PLZ_CONTRA),TO_DATE(FN_DECODE(PLZ_FECINI),'YYYY-MM-DD'),
        TO_DATE(FN_DECODE(PLZ_FECFIN),'YYYY-MM-DD') ,FN_DECODE(PLZ_TURNOP) ,FN_DECODE(PLZ_KEYHOR) ,FN_DECODE(PLZ_KEYEMP) ,FN_DECODE(PLZ_CVEUOC) ,FN_DECODE(PLZ_TITULA) ,FN_DECODE(PLZ_CVEREM) ,
        FN_DECODE(PLZ_STATUS) ,FN_DECODE(PLZ_KEYMOT) ,TO_DATE(FN_DECODE(PLZ_FECMOV),'YYYY-MM-DD'),FN_DECODE(PLZ_HORMOV) ,FN_DECODE(PLZ_COSPLZ) ,FN_DECODE(PLZ_KEYSUE) ,FN_DECODE(PLZ_TIPTAB) ,
        FN_DECODE(PLZ_SUENIV) ,FN_DECODE(PLZ_SUBNIV) ,FN_DECODE(PLZ_COBERT) ,TO_DATE(FN_DECODE(PLZ_FECOCU),'YYYY-MM-DD'),FN_DECODE(PLZ_SALPLZ) ,FN_DECODE(PLZ_ORIGEN) ,FN_DECODE(PLZ_CODOCU) ,
        TO_DATE(FN_DECODE(PLZ_LIMOCU),'YYYY-MM-DD'),FN_DECODE(PLZ_CA1AUX) ,FN_DECODE(PLZ_CA2AUX) ,FN_DECODE(PLZ_CA3AUX) ,FN_DECODE(PLZ_CA4AUX) ,FN_DECODE(PLZ_CA5AUX) ,FN_DECODE(PLZ_CA6AUX) ,
        FN_DECODE(PLZ_CA7AUX) ,FN_DECODE(PLZ_CA8AUX) ,SetEocoplzaEnc.Status ,SetEocoplzaEnc.Code ,SetEocoplzaEnc.Message ,SetEocoplzaEnc.Fecha);
    EXCEPTION WHEN OTHERS THEN
    CODE := SQLCODE;
    MESSAGE := SQLERRM;
    STATUS :='ERROR';
    END;
    end if;
    END IF;
END;
END;
/;
