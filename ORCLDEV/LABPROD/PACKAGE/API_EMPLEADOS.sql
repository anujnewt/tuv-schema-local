CREATE OR REPLACE NONEDITIONABLE PACKAGE "LABPROD"."API_EMPLEADOS" AS
 PROCEDURE SetEmpleados
 (
     ID_TRANSACCION IN VARCHAR2,
     ID_ORIGEN IN VARCHAR2,
     EMP_KEYEMP IN number,
     EMP_KEYDEP IN varchar2,
     EMP_KEYPUE IN varchar2,
     EMP_KEYCEN IN varchar2,
     EMP_KEYLOC IN varchar2,
     EMP_APEPAT IN varchar2,
     EMP_APEMAT IN varchar2,
     EMP_NOMBRE IN varchar2,
     EMP_DOMEMP in varchar2,
     EMP_NUMEXT in varchar2,
     EMP_NUMINT in varchar2,
     EMP_COLEMP in varchar2,
     EMP_CIDEMP in varchar2,
     EMP_MUNEMP in varchar2,
     EMP_ENTEMP in varchar2,
     EMP_CODEMP in varchar2,
     EMP_TELEMP in varchar2,
     EMP_REGRFC in varchar2,
     EMP_RECURP in varchar2,
     EMP_REGIMS in varchar2,
     EMP_CVESEX in varchar2,
     EMP_KEYIMS in varchar2,
     EMP_CVEZON in number,
     EMP_KEYPRO in number,
     EMP_TIPEMP in varchar2,
     EMP_TIPSAL in varchar2,
     EMP_STATUS in number,
     EMP_SALHOR in number,
     EMP_SALDIA in number,
     EMP_SALMES in number,
     EMP_FORPAG in varchar2,
     EMP_CTABAN in varchar2,
     EMP_CVEBAJ in varchar2,
     EMP_FECAUX in date,
     EMP_JORLAB in varchar2,
     EMP_UNIJOR in number,
     EMP_CA2AUX in varchar2,
     EMP_FECVEN in date,
     EMP_FECPLA in date,
     EMP_CA1AUX in varchar2,
     EMP_FECHA_MOV in date,
     EMP_FECHA_IMSS in date,
     EMP_TIPMOV in varchar2,
     EMP_SUBMOV in varchar2,
     EMP_KEYPLZ in number,
     STATUS out varchar2,
     CODE out varchar2,
     MESSAGE out varchar2,
     FECHA out date
 );
PROCEDURE SetEmpleadosEnc
 (
     ID_TRANSACCION IN VARCHAR2,
     ID_ORIGEN  IN VARCHAR2,
     EMP_KEYEMP IN varchar2,
     EMP_KEYDEP IN varchar2,
     EMP_KEYPUE IN varchar2,
     EMP_KEYCEN IN varchar2,
     EMP_KEYLOC IN varchar2,
     EMP_APEPAT IN varchar2,
     EMP_APEMAT IN varchar2,
     EMP_NOMBRE IN varchar2,
     EMP_DOMEMP in varchar2,
     EMP_NUMEXT in varchar2,
     EMP_NUMINT in varchar2,
     EMP_COLEMP in varchar2,
     EMP_CIDEMP in varchar2,
     EMP_MUNEMP in varchar2,
     EMP_ENTEMP in varchar2,
     EMP_CODEMP in varchar2,
     EMP_TELEMP in varchar2,
     EMP_REGRFC in varchar2,
     EMP_RECURP in varchar2,
     EMP_REGIMS in varchar2,
     EMP_CVESEX in varchar2,
     EMP_KEYIMS in varchar2,
     EMP_CVEZON in varchar2,
     EMP_KEYPRO in varchar2,
     EMP_TIPEMP in varchar2,
     EMP_TIPSAL in varchar2,
     EMP_STATUS in varchar2,
     EMP_SALHOR in varchar2,
     EMP_SALDIA in varchar2,
     EMP_SALMES in varchar2,
     EMP_FORPAG in varchar2,
     EMP_CTABAN in varchar2,
     EMP_CVEBAJ in varchar2,
     EMP_FECAUX in varchar2,
     EMP_JORLAB in varchar2,
     EMP_UNIJOR in varchar2,
     EMP_CA2AUX in varchar2,
     EMP_FECVEN in varchar2,
     EMP_FECPLA in varchar2,
     EMP_CA1AUX in varchar2,
     EMP_FECHA_MOV in varchar2,
     EMP_FECHA_IMSS in varchar2,
     EMP_TIPMOV in varchar2,
     EMP_SUBMOV in varchar2,
     EMP_KEYPLZ in  varchar2,
     STATUS out varchar2,
     CODE out varchar2,
     MESSAGE out varchar2,
     FECHA out date
 );
    PROCEDURE SetEmpleadosDA
    (
    ID_TRANSACCION IN VARCHAR2,
    DAT_KEYEMP IN INTEGER,
    DAT_KEYPAR IN VARCHAR2,
    DAT_VALPAR IN VARCHAR,
    STATUS out varchar2,
    CODE out varchar2,
    MESSAGE out varchar2,
    FECHA out date
    );
     PROCEDURE SetEmpleadosDAEnc
    (
    ID_TRANSACCION IN VARCHAR2,
    DAT_KEYEMP IN VARCHAR2,
    DAT_KEYPAR IN VARCHAR2,
    DAT_VALPAR IN VARCHAR,
    STATUS out varchar2,
    CODE out varchar2,
    MESSAGE out varchar2,
    FECHA out date
    );
END;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "LABPROD"."API_EMPLEADOS" AS
PROCEDURE SetEmpleados
(
    ID_TRANSACCION IN VARCHAR2,
    ID_ORIGEN IN VARCHAR2,
    EMP_KEYEMP IN number,
    EMP_KEYDEP IN varchar2,
    EMP_KEYPUE IN varchar2,
    EMP_KEYCEN IN varchar2,
    EMP_KEYLOC IN varchar2,
    EMP_APEPAT IN varchar2,
    EMP_APEMAT IN varchar2,
    EMP_NOMBRE IN varchar2,
    EMP_DOMEMP in varchar2,
    EMP_NUMEXT in varchar2,
    EMP_NUMINT in varchar2,
    EMP_COLEMP in varchar2,
    EMP_CIDEMP in varchar2,
    EMP_MUNEMP in varchar2,
    EMP_ENTEMP in varchar2,
    EMP_CODEMP in varchar2,
    EMP_TELEMP in varchar2,
    EMP_REGRFC in varchar2,
    EMP_RECURP in varchar2,
    EMP_REGIMS in varchar2,
    EMP_CVESEX in varchar2,
    EMP_KEYIMS in varchar2,
    EMP_CVEZON in number,
    EMP_KEYPRO in number,
    EMP_TIPEMP in varchar2,
    EMP_TIPSAL in varchar2,
    EMP_STATUS in number,
    EMP_SALHOR in number,
    EMP_SALDIA in number,
    EMP_SALMES in number,
    EMP_FORPAG in varchar2,
    EMP_CTABAN in varchar2,
    EMP_CVEBAJ in varchar2,
    EMP_FECAUX in date,
    EMP_JORLAB in varchar2,
    EMP_UNIJOR in number,
    EMP_CA2AUX in varchar2,
    EMP_FECVEN in date,
    EMP_FECPLA in date,
    EMP_CA1AUX in varchar2,
    EMP_FECHA_MOV in date,
    EMP_FECHA_IMSS in date,
    EMP_TIPMOV in varchar2,
    EMP_SUBMOV in varchar2,
    EMP_KEYPLZ in NUMBER,
    STATUS out varchar2,
    CODE out varchar2,
    MESSAGE out varchar2,
    FECHA out date
) as
    BAND NUMBER;
    DOMICILIO VARCHAR (100);
    NOMBRECOMP VARCHAR(60);
    EMP_KEYEMPBAND NUMBER;
    ESTATUS NUMBER;
    movimientos number;
    codeValida number;
    codeValida2 number;
    stEmp number;
    stMov varchar(3);
    stSub varchar (3);
    salmes  number;
    apemat varchar(60);
    KEYEMPSTGN number;
BEGIN
    FECHA := SYSDATE;
    stEmp := 0;
    salmes := SetEmpleados.EMP_SALMES;
        IF ID_TRANSACCION = 0 THEN
            Status := 'OK';
            Code := '0';
            Message := 'PRUEBA DE SERVICIO';
        ELSE
            CODE :='1';
            codeValida:='1';
            codeValida2:='1';
            apemat := SetEmpleados.EMP_APEMAT;
            SELECT COUNT(*) INTO EMP_KEYEMPBAND FROM LABPROD.NMCOEMPL WHERE NMCOEMPL.EMP_KEYEMP = SetEmpleados.EMP_KEYEMP;
             select count(*) INTO KEYEMPSTGN FROM LABPROD.API_MOVIMIENTOSPER WHERE
             API_MOVIMIENTOSPER.ESTATUS  IN ('1','4','5') and  API_MOVIMIENTOSPER.EMP_KEYEMP  = SetEmpleados.EMP_KEYEMP AND API_MOVIMIENTOSPER.EMP_TIPMOV = '1';
            IF EMP_KEYEMPBAND = '1' THEN
                select NMCOEMPL.EMP_STATUS INTO ESTATUS  FROM LABPROD.NMCOEMPL WHERE NMCOEMPL.EMP_KEYEMP = SetEmpleados.EMP_KEYEMP;
            END IF;
            IF EMP_KEYEMPBAND = '0' THEN
                ESTATUS:='0';
            end if;
            select count(*) into movimientos from labprod.api_movimientosper where id_transaccion = SetEmpleados.id_transaccion ;
            -- valida si existe una alta en stagin y si existe el empleado en laborad
            INTERFACES.VALIDAEMP(EMP_TIPMOV,EMP_SUBMOV,STATUS,codeValida,Message,Fecha);
            IF  codeValida = '1' THEN
                 Code := '1';
            else
                Code := codeValida;
                Status := STATUS;
                MESSAGE := MESSAGE;
            END IF;
            if code = '1' then
            INTERFACES.VALIDAEMP2(EMP_KEYEMP,EMP_KEYDEP,EMP_KEYPUE ,EMP_KEYLOC ,EMP_KEYCEN,EMP_KEYIMS,EMP_KEYPRO ,EMP_MUNEMP ,EMP_ENTEMP,EMP_KEYPLZ,
            STATUS,code,MESSAGE ,FECHA );
            end if;
            if EMP_KEYEMPBAND = 1 AND  SetEmpleados.EMP_TIPMOV = '1' then
                Message:= 'EL EMPLEADO YA EXISTE EN LABORA';
                Status := 'ERROR';
                Code := '3';
            end if;
            if KEYEMPSTGN >= 1 AND  SetEmpleados.EMP_TIPMOV = '1' then
                Message:= 'EL EMPLEADO YA SE ENCUENTRA EN STAGIN';
                Status := 'ERROR';
                Code := '3';
            end if;
            IF EMP_KEYDEP IS NULL THEN
                Message:= 'EMP_KEYDEP  NO PUEDE SER NULL ';
                Status := 'ERROR';
                Code := '3';
            END IF;
            IF EMP_JORLAB IS NULL THEN
                Message:= 'EMP_JORLAB  NO PUEDE SER NULL ';
                Status := 'ERROR';
                Code := '3';
            END IF;
            IF EMP_KEYPUE IS NULL THEN
                Message:= 'EMP_KEYPUE  NO PUEDE SER NULL ';
                Status := 'ERROR';
                Code := '3';
            END IF;
            IF EMP_KEYLOC IS NULL THEN
                Message:= 'EMP_KEYLOC  NO PUEDE SER NULL ';
                Status := 'ERROR';
                Code := '3';
            END IF;
            IF EMP_KEYCEN IS NULL THEN
                Message:= 'EMP_KEYCEN  NO PUEDE SER NULL ';
                Status := 'ERROR';
                Code := '3';
            END IF;
            IF EMP_KEYIMS IS NULL THEN
                Message:= 'EMP_KEYIMS  NO PUEDE SER NULL ';
                Status := 'ERROR';
                Code := '3';
            END IF;
            IF EMP_REGRFC IS NULL THEN
                Message:= 'EMP_REGRFC  NO PUEDE SER NULL ';
                Status := 'ERROR';
                Code := '3';
            END IF;
            IF EMP_RECURP IS NULL	THEN
                Message:= 'EMP_RECURP  NO PUEDE SER NULL';
                Status := 'ERROR';
                Code := '3';
            END IF;
            IF EMP_REGIMS IS NULL	THEN
                Message:= 'EMP_REGIMS  NO PUEDE SER NULL';
                Status := 'ERROR';
                Code := '3';
            END IF;
            if EMP_FECHA_IMSS IS NULL THEN
                Message:= 'EMP_FECHA_IMSS  NO PUEDE SER NULL';
                Status := 'ERROR';
                Code := '3';
            END IF;
             IF LENGTH(EMP_KEYEMP) > 10	THEN
                Message:= 'EMP_KEYEMP  LONGITUD MAYOR A 10 ';
                Status := 'ERROR';
                Code := '3';
            END IF;
            IF LENGTH(EMP_KEYDEP) > 16	THEN
                Message:= 'EMP_KEYDEP  LONGITUD MAYOR A 16 ';
                Status := 'ERROR';
                Code := '3';
            END IF;
            IF LENGTH(EMP_KEYPUE) > 16	THEN
                Message:= 'EMP_KEYPUE  LONGITUD MAYOR A 16 ';
                Status := 'ERROR';
                Code := '3';
            END IF;
            IF LENGTH(EMP_KEYCEN) > 16	THEN
                Message:= 'EMP_KEYCEN  LONGITUD MAYOR A 16 ';
                Status := 'ERROR';
                Code := '3';
            END IF;
            IF LENGTH(EMP_KEYLOC) > 16	THEN
                Message:= 'EMP_KEYLOC  LONGITUD MAYOR A 16 ';
                Status := 'ERROR';
                Code := '3';
            END IF;
            IF LENGTH(EMP_APEPAT) > 90	THEN
                Message:= 'EMP_APEPAT  LONGITUD MAYOR A 90';
                Status := 'ERROR';
                Code := '3';
            END IF;
            IF LENGTH(EMP_APEMAT) > 90	THEN
                Message:= 'EMP_APEMAT  LONGITUD MAYOR A 90';
                Status := 'ERROR';
                Code := '3';
            END IF;
            IF apemat = 'X' OR  apemat = '.' OR apemat = 'x' THEN
                apemat := null;
            end if;
            IF LENGTH(EMP_NOMBRE) > 90	THEN
                Message:= 'EMP_NOMBRE  LONGITUD MAYOR A 90';
                Status := 'ERROR';
                Code := '3';
            END IF;
            IF LENGTH(EMP_DOMEMP) > 100	THEN
                Message:= 'EMP_DOMEMP  LONGITUD MAYOR A 100';
                Status := 'ERROR';
                Code := '3';
            END IF;
            IF LENGTH(EMP_NUMEXT) > 10	THEN
                Message:= 'EMP_NUMEXT  LONGITUD MAYOR A 10';
                Status := 'ERROR';
                Code := '3';
            END IF;
            IF LENGTH(EMP_NUMINT) > 10	THEN
                Message:= 'EMP_NUMINT  LONGITUD MAYOR A 10';
                Status := 'ERROR';
                Code := '3';
            END IF;
            IF LENGTH(EMP_COLEMP) > 100	THEN
                Message:= 'EMP_COLEMP  LONGITUD MAYOR A 100';
                Status := 'ERROR';
                Code := '3';
            END IF;
            IF LENGTH(EMP_MUNEMP) > 6	THEN
                Message:= 'EMP_MUNEMP  LONGITUD MAYOR A 6';
                Status := 'ERROR';
                Code := '3';
            END IF;
            IF LENGTH(EMP_ENTEMP) > 2	THEN
                Message:= 'EMP_ENTEMP  LONGITUD MAYOR A 2';
                Status := 'ERROR';
                Code := '3';
            END IF;
            IF LENGTH(EMP_CODEMP) > 5	THEN
                Message:= 'EMP_CODEMP  LONGITUD MAYOR A 5';
                Status := 'ERROR';
                Code := '3';
            END IF;
            IF LENGTH(EMP_TELEMP) > 60	THEN
                Message:= 'EMP_TELEMP  LONGITUD MAYOR A 60';
                Status := 'ERROR';
                Code := '3';
            END IF;
            IF LENGTH(EMP_REGRFC) > 13	THEN
                Message:= 'EMP_REGRFC  LONGITUD MAYOR A 13';
                Status := 'ERROR';
                Code := '3';
            END IF;
            IF LENGTH(EMP_RECURP) > 18	THEN
                Message:= 'EMP_RECURP  LONGITUD MAYOR A 18';
                Status := 'ERROR';
                Code := '3';
            END IF;
            IF LENGTH(EMP_REGIMS) > 12	THEN
                Message:= 'EMP_REGIMS  LONGITUD MAYOR A 12';
                Status := 'ERROR';
                Code := '3';
            END IF;
            IF LENGTH(EMP_CVESEX) > 1	THEN
                Message:= 'EMP_CVESEX  LONGITUD MAYOR A 1';
                Status := 'ERROR';
                Code := '3';
            END IF;
            IF LENGTH(EMP_KEYIMS) > 16	THEN
                Message:= 'EMP_KEYIMS  LONGITUD MAYOR A 16';
                Status := 'ERROR';
                Code := '3';
            END IF;
            IF LENGTH(EMP_TIPEMP) > 6	THEN
                Message:= 'EMP_TIPEMP  LONGITUD MAYOR A 6';
                Status := 'ERROR';
                Code := '3';
            END IF;
            IF LENGTH(EMP_TIPSAL) > 1	THEN
                Message:= 'EMP_TIPSAL  LONGITUD MAYOR A 1';
                Status := 'ERROR';
                Code := '3';
            END IF;
            IF LENGTH(EMP_FORPAG) > 2	THEN
                Message:= 'EMP_FORPAG  LONGITUD MAYOR A 2';
                Status := 'ERROR';
                Code := '3';
            END IF;
            IF LENGTH(EMP_CTABAN) > 18	THEN
                Message:= 'EMP_CTABAN  LONGITUD MAYOR A 18';
                Status := 'ERROR';
                Code := '3';
            END IF;
            IF LENGTH(EMP_CVEBAJ) > 4	THEN
                Message:= 'EMP_CVEBAJ  LONGITUD MAYOR A 4';
                Status := 'ERROR';
                Code := '3';
            END IF;
            IF LENGTH(EMP_JORLAB) > 1	THEN
                Message:= 'EMP_JORLAB  LONGITUD MAYOR A 1';
                Status := 'ERROR';
                Code := '3';
            END IF;
            IF LENGTH(EMP_CA2AUX) > 10	THEN
                Message:= 'EMP_CA2AUX  LONGITUD MAYOR A 10';
                Status := 'ERROR';
                Code := '3';
            END IF;
            IF LENGTH(EMP_CA1AUX) > 10	THEN
                Message:= 'EMP_CA1AUX  LONGITUD MAYOR A 10';
                Status := 'ERROR';
                Code := '3';
            END IF;
            IF LENGTH(EMP_TIPMOV) > 2	THEN
                Message:= 'EMP_TIPMOV  LONGITUD MAYOR A 2';
                Status := 'ERROR';
                Code := '3';
            END IF;
            IF LENGTH(EMP_SUBMOV) > 6	THEN
                Message:= 'EMP_SUBMOV  LONGITUD MAYOR A 6';
                Status := 'ERROR';
                Code := '2';
            END IF;
            IF EMP_TIPMOV = '2'	THEN
                if emp_cvebaj is null then
                    Message:= 'EMP_CVEBAJ  NO PUEDE SER NULL';
                    Status := 'ERROR';
                    Code := '3';
                end if;
            END IF;
            IF  salmes is null  then
                salmes := 0;
            end if;
            if  movimientos > 0 then
                Status := 'ERROR';
                Code := '3';
                Message := 'ID_TRANSACCION DUPLICADO';
            end if;
            if Code !='1' then
                INSERT INTO LABPROD.API_MOVIMIENTOSPER (ID_TRANSACCION,ID_ORIGEN,EMP_KEYEMP,EMP_KEYDEP,EMP_KEYPUE,EMP_KEYCEN,EMP_KEYLOC,EMP_APEPAT,EMP_APEMAT,EMP_NOMBRE,EMP_DOMEMP,EMP_NUMEXT,EMP_NUMINT,EMP_COLEMP,EMP_CIDEMP,EMP_MUNEMP,EMP_ENTEMP,EMP_CODEMP,EMP_TELEMP,EMP_REGRFC,EMP_RECURP,EMP_REGIMS,EMP_CVESEX,EMP_KEYIMS,EMP_CVEZON,EMP_KEYPRO,EMP_TIPEMP,EMP_TIPSAL,EMP_STATUS,EMP_SALHOR,EMP_SALDIA,EMP_SALMES,EMP_FORPAG,EMP_CTABAN,EMP_CVEBAJ,EMP_FECAUX,EMP_JORLAB,EMP_UNIJOR,EMP_CA2AUX,EMP_FECVEN,EMP_FECPLA,EMP_CA1AUX,EMP_FECHA_MOV,EMP_FECHA_IMSS,EMP_TIPMOV,EMP_SUBMOV,FECHA_INSERT,FECHA_PROC,EMP_SALINT,KEYPER,ESTATUS,CODE,MESSAGE,
                EMP_SALIVC,EMP_SALINF,EMP_INTSIN,EMP_INFSIN,EMP_KEYPLZ)
                VALUES (ID_TRANSACCION,ID_ORIGEN,EMP_KEYEMP,EMP_KEYDEP,EMP_KEYPUE,EMP_KEYCEN,EMP_KEYLOC,EMP_APEPAT,apemat,EMP_NOMBRE,EMP_DOMEMP,EMP_NUMEXT,EMP_NUMINT,EMP_COLEMP,EMP_CIDEMP,EMP_MUNEMP,EMP_ENTEMP,EMP_CODEMP,EMP_TELEMP,EMP_REGRFC,EMP_RECURP,EMP_REGIMS,EMP_CVESEX,EMP_KEYIMS,EMP_CVEZON,EMP_KEYPRO,EMP_TIPEMP,EMP_TIPSAL,EMP_STATUS,EMP_SALHOR,EMP_SALDIA,SALMES,EMP_FORPAG,EMP_CTABAN,EMP_CVEBAJ,EMP_FECAUX,EMP_JORLAB,EMP_UNIJOR,EMP_CA2AUX,EMP_FECVEN,EMP_FECPLA,EMP_CA1AUX,EMP_FECHA_MOV,EMP_FECHA_IMSS,EMP_TIPMOV,EMP_SUBMOV,SYSDATE,NULL,0,NULL,SetEmpleados.Code,SetEmpleados.Status,SetEmpleados.Message,
                0,0,0,0,EMP_KEYPLZ);
                COMMIT;
            end if;
            IF Code = '1' then
                Status := 'OK';
                Code := '1';
                Message := 'SE INSERT?? A STAGGING CON ??XITO';
                BEGIN
                INSERT INTO LABPROD.API_MOVIMIENTOSPER (ID_TRANSACCION,ID_ORIGEN,EMP_KEYEMP,EMP_KEYDEP,EMP_KEYPUE,EMP_KEYCEN,EMP_KEYLOC,EMP_APEPAT,EMP_APEMAT,EMP_NOMBRE,EMP_DOMEMP,EMP_NUMEXT,EMP_NUMINT,EMP_COLEMP,EMP_CIDEMP,EMP_MUNEMP,EMP_ENTEMP,EMP_CODEMP,EMP_TELEMP,EMP_REGRFC,EMP_RECURP,EMP_REGIMS,EMP_CVESEX,EMP_KEYIMS,EMP_CVEZON,EMP_KEYPRO,EMP_TIPEMP,EMP_TIPSAL,EMP_STATUS,EMP_SALHOR,EMP_SALDIA,EMP_SALMES,EMP_FORPAG,EMP_CTABAN,EMP_CVEBAJ,EMP_FECAUX,EMP_JORLAB,EMP_UNIJOR,EMP_CA2AUX,EMP_FECVEN,EMP_FECPLA,EMP_CA1AUX,EMP_FECHA_MOV,EMP_FECHA_IMSS,EMP_TIPMOV,EMP_SUBMOV,FECHA_INSERT,FECHA_PROC,EMP_SALINT,KEYPER,ESTATUS,CODE,MESSAGE,
                EMP_SALIVC,EMP_SALINF,EMP_INTSIN,EMP_INFSIN,EMP_KEYPLZ)
                VALUES (ID_TRANSACCION,ID_ORIGEN,EMP_KEYEMP,EMP_KEYDEP,EMP_KEYPUE,EMP_KEYCEN,EMP_KEYLOC,EMP_APEPAT,apemat,EMP_NOMBRE,EMP_DOMEMP,EMP_NUMEXT,EMP_NUMINT,EMP_COLEMP,EMP_CIDEMP,EMP_MUNEMP,EMP_ENTEMP,EMP_CODEMP,EMP_TELEMP,EMP_REGRFC,EMP_RECURP,EMP_REGIMS,EMP_CVESEX,EMP_KEYIMS,EMP_CVEZON,EMP_KEYPRO,EMP_TIPEMP,EMP_TIPSAL,EMP_STATUS,EMP_SALHOR,EMP_SALDIA,SALMES,EMP_FORPAG,EMP_CTABAN,EMP_CVEBAJ,EMP_FECAUX,EMP_JORLAB,EMP_UNIJOR,EMP_CA2AUX,EMP_FECVEN,EMP_FECPLA,EMP_CA1AUX,EMP_FECHA_MOV,EMP_FECHA_IMSS,EMP_TIPMOV,EMP_SUBMOV,SYSDATE,NULL,0,NULL,Code,Status,Message,
                0,0,0,0,EMP_KEYPLZ);
                --AGREGADO POR EHC
                IF EMP_TIPMOV = '2' THEN
                  INSERT INTO LABPROD.SCCOBAJA (BAJ_KEYEMP,BAJ_STATUS,BAJ_FECBAJ,BAJ_FECIMS,BAJ_CVEBAJ,BAJ_CVEMOT,BAJ_PERBAJ,BAJ_FECCAP,BAJ_HORCAP,BAJ_KEYUSU,baj_idplz)
                  VALUES (EMP_KEYEMP,1,EMP_FECHA_MOV,EMP_FECHA_MOV,EMP_SUBMOV,EMP_CVEBAJ,'',SYSDATE,TO_CHAR (SYSDATE, 'HH24:MI:SS'),0,EMP_KEYPLZ);
                END IF;
                COMMIT;
                    EXCEPTION WHEN OTHERS THEN
                    BEGIN
                        STATUS := 'ERROR';
                        CODE := 'ERR-ORA'||SQLCODE;
                        MESSAGE := SUBSTR(SQLERRM, 1 , 149);
                    END;
                END;
            END IF;
        end if;
END;
PROCEDURE SetEmpleadosEnc  (
     ID_TRANSACCION IN VARCHAR2,
     ID_ORIGEN  IN VARCHAR2,
     EMP_KEYEMP IN varchar2,
     EMP_KEYDEP IN varchar2,
     EMP_KEYPUE IN varchar2,
     EMP_KEYCEN IN varchar2,
     EMP_KEYLOC IN varchar2,
     EMP_APEPAT IN varchar2,
     EMP_APEMAT IN varchar2,
     EMP_NOMBRE IN varchar2,
     EMP_DOMEMP in varchar2,
     EMP_NUMEXT in varchar2,
     EMP_NUMINT in varchar2,
     EMP_COLEMP in varchar2,
     EMP_CIDEMP in varchar2,
     EMP_MUNEMP in varchar2,
     EMP_ENTEMP in varchar2,
     EMP_CODEMP in varchar2,
     EMP_TELEMP in varchar2,
     EMP_REGRFC in varchar2,
     EMP_RECURP in varchar2,
     EMP_REGIMS in varchar2,
     EMP_CVESEX in varchar2,
     EMP_KEYIMS in varchar2,
     EMP_CVEZON in varchar2,
     EMP_KEYPRO in varchar2,
     EMP_TIPEMP in varchar2,
     EMP_TIPSAL in varchar2,
     EMP_STATUS in varchar2,
     EMP_SALHOR in varchar2,
     EMP_SALDIA in varchar2,
     EMP_SALMES in varchar2,
     EMP_FORPAG in varchar2,
     EMP_CTABAN in varchar2,
     EMP_CVEBAJ in varchar2,
     EMP_FECAUX in varchar2,
     EMP_JORLAB in varchar2,
     EMP_UNIJOR in varchar2,
     EMP_CA2AUX in varchar2,
     EMP_FECVEN in varchar2,
     EMP_FECPLA in varchar2,
     EMP_CA1AUX in varchar2,
     EMP_FECHA_MOV in varchar2,
     EMP_FECHA_IMSS in varchar2,
     EMP_TIPMOV in varchar2,
     EMP_SUBMOV in varchar2,
     EMP_KEYPLZ in VARCHAR2,
     Status OUT  VARCHAR2,
     Code OUT  VARCHAR2,
     Message OUT  VARCHAR2,
     Fecha OUT DATE)
     as
     FECPLA DATE;
BEGIN
    Fecha := SYSDATE;
    IF ID_TRANSACCION = 0 THEN
    Status := 'OK';
    Code := '0';
    Message := 'PRUEBA DE SERVICIO';
    ELSE
    Code := '1';
     IF EMP_KEYEMP IS NOT NULL THEN
           IF F_IS_INT(FN_DECODE(EMP_KEYEMP)) = 0 THEN
                Status := 'ERROR';
                Code := '3';
                Message := 'EMP_KEYEMP NO ES DE TIPO INT';
            END IF;
    END IF;
    IF EMP_CVEZON IS NOT NULL THEN
           IF F_IS_INT(FN_DECODE(EMP_CVEZON)) = 0 THEN
                Status := 'ERROR';
                Code := '3';
                Message := 'EMP_CVEZON NO ES DE TIPO INT';
            END IF;
    END IF;
    IF EMP_KEYPRO IS NOT NULL THEN
           IF F_IS_INT(FN_DECODE(EMP_KEYPRO)) = 0 THEN
                Status := 'ERROR';
                Code := '3';
                Message := 'EMP_KEYPRO NO ES DE TIPO INT';
            END IF;
    END IF;
    IF EMP_STATUS IS NOT NULL THEN
           IF F_IS_INT(FN_DECODE(EMP_STATUS)) = 0 THEN
                Status := 'ERROR';
                Code := '3';
                Message := 'EMP_STATUS NO ES DE TIPO INT';
            END IF;
    END IF;
    IF EMP_SALMES IS NOT NULL THEN
           IF F_IS_INT(FN_DECODE(EMP_SALMES)) = 0 THEN
                Status := 'ERROR';
                Code := '3';
                Message := 'EMP_SALMES NO ES DE TIPO INT';
            END IF;
    END IF;
    IF EMP_SALDIA IS NOT NULL THEN
           IF F_IS_INT(FN_DECODE(EMP_SALDIA)) = 0 THEN
                Status := 'ERROR';
                Code := '3';
                Message := 'EMP_SALDIA NO ES DE TIPO INT';
            END IF;
    END IF;
     IF EMP_UNIJOR IS NOT NULL THEN
           IF F_IS_INT(FN_DECODE(EMP_UNIJOR)) = 0 THEN
                Status := 'ERROR';
                Code := '3';
                Message := 'EMP_UNIJOR NO ES DE TIPO INT';
            END IF;
    END IF;
    IF  EMP_FECAUX IS NOT NULL THEN
          IF ISDATE(FN_DECODE( EMP_FECAUX),'YYYY-MM-DD') = 'FALSE' THEN
            Status := 'ERROR';
            Code := '3';
            Message := ' EMP_FECAUX NO ES ES UNA FECHA VALIDA';
        END IF;
    END IF;
     IF  EMP_FECVEN IS NOT NULL THEN
          IF ISDATE(FN_DECODE( EMP_FECVEN),'YYYY-MM-DD') = 'FALSE' THEN
            Status := 'ERROR';
            Code := '3';
            Message := ' EMP_FECVEN NO ES ES UNA FECHA VALIDA';
        END IF;
    END IF;
    IF  EMP_FECPLA IS NOT NULL THEN
          IF ISDATE(FN_DECODE( EMP_FECPLA),'YYYY-MM-DD') = 'FALSE' THEN
            Status := 'ERROR';
            Code := '3';
            Message := ' EMP_FECPLA NO ES ES UNA FECHA VALIDA';
        END IF;
    END IF;
    IF  EMP_FECHA_MOV IS NOT NULL THEN
          IF ISDATE(FN_DECODE( EMP_FECHA_MOV),'YYYY-MM-DD') = 'FALSE' THEN
            Status := 'ERROR';
            Code := '3';
            Message := ' EMP_FECHA_MOV NO ES ES UNA FECHA VALIDA';
        END IF;
    END IF;
      IF  EMP_FECHA_IMSS IS NOT NULL THEN
          IF ISDATE(FN_DECODE( EMP_FECHA_IMSS),'YYYY-MM-DD') = 'FALSE' THEN
            Status := 'ERROR';
            Code := '3';
            Message := ' EMP_FECHA_IMSS NO ES ES UNA FECHA VALIDA';
        END IF;
    END IF;
    IF  EMP_TIPMOV IS  NULL THEN
            Status := 'ERROR';
            Code := '3';
            Message := ' EMP_TIPMOV NO PUEDE SER NULL';
    END IF;
    IF  EMP_SUBMOV IS  NULL THEN
            Status := 'ERROR';
            Code := '3';
            Message := ' EMP_SUBMOV NO PUEDE SER NULL';
    END IF;
    IF  FN_DECODE(EMP_FECHA_IMSS) IS  NULL THEN
            Status := 'ERROR';
            Code := '3';
            Message := ' EMP_FECHA_IMSS NO PUEDE SER NULL';
    END IF;
    IF  FN_DECODE(EMP_FECHA_MOV) IS  NULL THEN
            Status := 'ERROR';
            Code := '3';
            Message := ' EMP_FECHA_MOV NO PUEDE SER NULL';
    END IF;
    if Code = '1' then
    BEGIN
        SetEmpleados(ID_TRANSACCION,FN_DECODE(ID_ORIGEN),FN_DECODE(EMP_KEYEMP) ,FN_DECODE(EMP_KEYDEP) ,FN_DECODE(EMP_KEYPUE) ,FN_DECODE(EMP_KEYCEN) ,FN_DECODE(EMP_KEYLOC) ,FN_DECODE(EMP_APEPAT) ,
        FN_DECODE(EMP_APEMAT) ,FN_DECODE(EMP_NOMBRE) ,FN_DECODE(EMP_DOMEMP) ,FN_DECODE(EMP_NUMEXT) ,FN_DECODE(EMP_NUMINT) ,FN_DECODE(EMP_COLEMP) ,FN_DECODE(EMP_CIDEMP) ,
        FN_DECODE(EMP_MUNEMP) ,FN_DECODE(EMP_ENTEMP) ,FN_DECODE(EMP_CODEMP) ,FN_DECODE(EMP_TELEMP) ,FN_DECODE(EMP_REGRFC) ,FN_DECODE(EMP_RECURP) ,FN_DECODE(EMP_REGIMS) ,
        FN_DECODE(EMP_CVESEX) ,FN_DECODE(EMP_KEYIMS) ,FN_DECODE(EMP_CVEZON) ,FN_DECODE(EMP_KEYPRO) ,FN_DECODE(EMP_TIPEMP) ,FN_DECODE(EMP_TIPSAL) ,FN_DECODE(EMP_STATUS) ,
        FN_DECODE(EMP_SALHOR) ,FN_DECODE(EMP_SALDIA) ,FN_DECODE(EMP_SALMES) ,FN_DECODE(EMP_FORPAG) ,FN_DECODE(EMP_CTABAN) ,FN_DECODE(EMP_CVEBAJ) ,TO_DATE(FN_DECODE(EMP_FECAUX),'YYYY-MM-DD') ,
        FN_DECODE(EMP_JORLAB) ,FN_DECODE(EMP_UNIJOR) ,FN_DECODE(EMP_CA2AUX) ,TO_DATE(FN_DECODE(EMP_FECVEN),'YYYY-MM-DD'),TO_DATE(FN_DECODE(EMP_FECPLA),'YYYY-MM-DD'),
        FN_DECODE(EMP_CA1AUX) ,TO_DATE(FN_DECODE(EMP_FECHA_MOV),'YYYY-MM-DD'),TO_DATE(FN_DECODE(EMP_FECHA_IMSS),'YYYY-MM-DD'),FN_DECODE(EMP_TIPMOV) ,FN_DECODE(EMP_SUBMOV) ,
        FN_DECODE(EMP_KEYPLZ),SetEmpleadosEnc.Status ,SetEmpleadosEnc.Code ,SetEmpleadosEnc.Message ,SetEmpleadosEnc.Fecha);
    EXCEPTION WHEN OTHERS THEN
        CODE := SQLCODE;
        MESSAGE := SUBSTR(SQLERRM, 1 , 149);
        STATUS :='ERROR';
    END;
    END IF;
    END IF;
END;
PROCEDURE SetEmpleadosDA
(
    ID_TRANSACCION IN VARCHAR2,
    DAT_KEYEMP IN INTEGER,
    DAT_KEYPAR IN VARCHAR2,
    DAT_VALPAR IN VARCHAR,
    STATUS out varchar2,
    CODE out varchar2,
    MESSAGE out varchar2,
    FECHA out date) AS
    BAND NUMBER;
    BANDEMP NUMBER;
    BEGIN
    FECHA := SYSDATE;
    CODE := '1';
        IF ID_TRANSACCION = '0' THEN
            STATUS := 'OK';
            CODE := '0';
            MESSAGE := 'PRUEBA DE SERVICIO';
        ELSE
        IF CODE = '1' THEN
            BEGIN
            INSERT INTO LABPROD.api_empleadosda (id_transaccion,dat_keyemp,dat_keypar,dat_valpar,status,code,message,fechA)
            VALUES (ID_TRANSACCION,DAT_KEYEMP,DAT_KEYPAR,DAT_VALPAR,'PENDIENTE','0','PENDIENTE A PROCESAR',SYSDATE);
            commit ;
            select COUNT(*) INTO BAND from LABPROD.NMLODATA WHERE NMLODATA.DAT_KEYEMP=SetEmpleadosDA.DAT_KEYEMP AND NMLODATA.DAT_KEYPAR=SetEmpleadosDA.DAT_KEYPAR;
            IF BAND = 1 THEN
                update LABPROD.NMLODATA set Nmlodata.Dat_Valpar=SetEmpleadosDA.DAT_VALPAR,NMLODATA.DAT_KEYPAR=SetEmpleadosDA.DAT_KEYPAR
                WHERE Nmlodata.Dat_Keyemp=SetEmpleadosDA.DAT_KEYEMP AND NMLODATA.DAT_KEYPAR=SetEmpleadosDA.DAT_KEYPAR;
                commit;
                update  LABPROD.api_empleadosda set STATUS='OK', MESSAGE = 'Se proces?? con ??xito', CODE='3' where id_transaccion=SetEmpleadosDA.ID_TRANSACCION;
                commit;
                Status:= 'OK';
                Code:='3';
                Message:='Se proces?? con ??xito';
            END IF;
            IF BAND = 0 THEN
                INSERT INTO LABPROD.nmlodata (dat_keyemp,dat_keypar,dat_valpar) VALUES (DAT_KEYEMP,DAT_KEYPAR,DAT_VALPAR);
                commit ;
                update  LABPROD.api_empleadosda set STATUS='OK', MESSAGE = 'Se proces?? con ??xito', CODE='3' where id_transaccion=SetEmpleadosDA.ID_TRANSACCION;
                commit ;
                Status:= 'OK';
                Code:='3';
                Message:='Se proces?? con ??xito';
            END IF;
            IF DAT_KEYPAR = '133' THEN
              UPDATE LABPROD.NMCOEMPL SET emp_pobemp = DAT_VALPAR WHERE emp_keyemp = DAT_KEYEMP;
            END IF;
        EXCEPTION WHEN OTHERS THEN
            BEGIN
                Status := 'ERROR';
                Code :=  SQLCODE;
                Message := SUBSTR(SQLERRM, 1 , 149);
                END;
            END;
        END IF;
        END IF;
    END;
PROCEDURE SetEmpleadosDAEnc (
    ID_TRANSACCION IN VARCHAR2,
    DAT_KEYEMP IN VARCHAR2,
    DAT_KEYPAR IN VARCHAR2,
    DAT_VALPAR IN VARCHAR,
    Status OUT  VARCHAR2,
    Code OUT  VARCHAR2,
    Message OUT  VARCHAR2,
    Fecha OUT DATE)
    as
    existe int;
BEGIN
    Fecha := SYSDATE;
    IF ID_TRANSACCION = '0' THEN
    Status := 'OK';
    Code := '0';
    Message := 'PRUEBA DE SERVICIO';
    ELSE
    Code := '1';
    Select count(id_transaccion) into existe from LABPROD.API_EMPLEADOSDA WHERE API_EMPLEADOSDA.ID_TRANSACCION = SetEmpleadosDAEnc.ID_TRANSACCION;
    if existe != 0  then
                Status := 'ERROR';
                Code := '006';
                Message := 'ID_TRANSACCI??N DUPLICADO';
    end if;
    if Code = '1' then
    BEGIN
    SetEmpleadosDA(ID_TRANSACCION ,FN_DECODE(DAT_KEYEMP) ,FN_DECODE(DAT_KEYPAR) ,FN_DECODE(DAT_VALPAR) ,SetEmpleadosDAEnc.Status ,
    SetEmpleadosDAEnc.Code ,SetEmpleadosDAEnc.Message ,SetEmpleadosDAEnc.Fecha);
    EXCEPTION WHEN OTHERS THEN
    CODE := SQLCODE;
    MESSAGE := SUBSTR(SQLERRM, 1 , 149);
    STATUS :='ERROR';
    END;
    END IF;
    END IF;
END;
END;
/;
