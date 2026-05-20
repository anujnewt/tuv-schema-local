CREATE OR REPLACE NONEDITIONABLE PACKAGE "LABPROD"."API_CATALOGOS" AS
PROCEDURE SetDepartamento
(
    ID_TRANSACCION IN VARCHAR2,
    DEP_KEYDEP IN VARCHAR2,
    DEP_DESDEP IN VARCHAR2,
    DEP_REFCON IN VARCHAR2,
    DEP_KEYCEN IN VARCHAR2,
    DEP_TIPDEP IN VARCHAR2,
    DEP_NU1AUX IN VARCHAR2,
    DEP_NU2AUX IN VARCHAR2,
    DEP_NU3AUX IN VARCHAR2,
    DEP_NU4AUX IN VARCHAR2,
    DEP_NU5AUX IN VARCHAR2,
    DEP_CA1AUX IN VARCHAR2,
    DEP_CA2AUX IN VARCHAR2,
    DEP_CA3AUX IN VARCHAR2,
    DEP_CA4AUX IN VARCHAR2,
    DEP_CA5AUX IN VARCHAR2,
    Status OUT  VARCHAR2,
    Code OUT  VARCHAR2,
    Message OUT  VARCHAR2,
    Fecha OUT DATE
);
PROCEDURE SetDepartamentoEnc
(
    ID_TRANSACCION IN VARCHAR2,
    DEP_KEYDEP IN VARCHAR2,
    DEP_DESDEP IN VARCHAR2,
    DEP_REFCON IN VARCHAR2,
    DEP_KEYCEN IN VARCHAR2,
    DEP_TIPDEP IN VARCHAR2,
    DEP_NU1AUX IN VARCHAR2,
    DEP_NU2AUX IN VARCHAR2,
    DEP_NU3AUX IN VARCHAR2,
    DEP_NU4AUX IN VARCHAR2,
    DEP_NU5AUX IN VARCHAR2,
    DEP_CA1AUX IN VARCHAR2,
    DEP_CA2AUX IN VARCHAR2,
    DEP_CA3AUX IN VARCHAR2,
    DEP_CA4AUX IN VARCHAR2,
    DEP_CA5AUX IN VARCHAR2,
    Status OUT  VARCHAR2,
    Code OUT  VARCHAR2,
    Message OUT  VARCHAR2,
    Fecha OUT DATE
);
PROCEDURE SetPuesto
(
    ID_TRANSACCION IN VARCHAR2,
    PUE_KEYPUE IN VARCHAR2,
    PUE_DESPUE IN VARCHAR2,
    PUE_REFCON IN VARCHAR2,
    PUE_NU1AUX IN VARCHAR2,
    PUE_NU2AUX IN VARCHAR2,
    PUE_NU3AUX IN VARCHAR2,
    PUE_NU4AUX IN VARCHAR2,
    PUE_NU5AUX IN VARCHAR2,
    PUE_CA1AUX IN VARCHAR2,
    PUE_CA2AUX IN VARCHAR2,
    PUE_CA3AUX IN VARCHAR2,
    PUE_CA4AUX IN VARCHAR2,
    PUE_CA5AUX IN VARCHAR2,
    PUE_SUENIV IN NUMBER,
    PUE_SUBNIV IN NUMBER,
    PUE_KEYSUE IN VARCHAR2,
    PUE_COBERT IN VARCHAR2,
    PUE_AREPUE IN VARCHAR2,
    PUE_SUBARE IN VARCHAR2 ,
    PUE_NIVPUE IN NUMBER,
    PUE_GRPPUE IN VARCHAR2,
    PUE_SUBGRP IN VARCHAR2,
    PUE_TIPPUE IN VARCHAR2,
    Status OUT  VARCHAR2,
    Code OUT  VARCHAR2,
    Message OUT  VARCHAR2,
    Fecha OUT DATE
);
PROCEDURE SetPuestoEnc
(
    ID_TRANSACCION IN VARCHAR2,
    PUE_KEYPUE IN VARCHAR2,
    PUE_DESPUE IN VARCHAR2,
    PUE_REFCON IN VARCHAR2,
    PUE_NU1AUX IN VARCHAR2,
    PUE_NU2AUX IN VARCHAR2,
    PUE_NU3AUX IN VARCHAR2,
    PUE_NU4AUX IN VARCHAR2,
    PUE_NU5AUX IN VARCHAR2,
    PUE_CA1AUX IN VARCHAR2,
    PUE_CA2AUX IN VARCHAR2,
    PUE_CA3AUX IN VARCHAR2,
    PUE_CA4AUX IN VARCHAR2,
    PUE_CA5AUX IN VARCHAR2,
    PUE_SUENIV IN VARCHAR2,
    PUE_SUBNIV IN VARCHAR2,
    PUE_KEYSUE IN VARCHAR2,
    PUE_COBERT IN VARCHAR2,
    PUE_AREPUE IN VARCHAR2,
    PUE_SUBARE IN VARCHAR2,
    PUE_NIVPUE IN VARCHAR2,
    PUE_GRPPUE IN VARCHAR2,
    PUE_SUBGRP IN VARCHAR2,
    PUE_TIPPUE IN VARCHAR2,
    Status OUT  VARCHAR2,
    Code OUT  VARCHAR2,
    Message OUT  VARCHAR2,
    Fecha OUT DATE
);
PROCEDURE SetLocPago (
    ID_TRANSACCION IN VARCHAR2,
    LOC_KEYLOC  IN   VARCHAR2,
    LOC_DESLOC  IN   VARCHAR2,
    LOC_DOMLOC  IN   VARCHAR2,
    LOC_COLLOC  IN   VARCHAR2,
    LOC_CIULOC  IN   VARCHAR2,
    LOC_ESTLOC  IN   VARCHAR2,
    LOC_CODPOS  IN   VARCHAR2,
    LOC_LARDIS  IN   VARCHAR2,
    LOC_TELUNO  IN   VARCHAR2,
    LOC_TELDOS  IN   VARCHAR2,
    LOC_TELTRE  IN   VARCHAR2,
    LOC_CVEZON  IN   NUMBER,
    LOC_REGGEO  IN   VARCHAR2,
    LOC_KEYBAN  IN   VARCHAR2,
    LOC_KEYSUC  IN   VARCHAR2,
    LOC_CA1AUX  IN   VARCHAR2,
    LOC_CA2AUX  IN   VARCHAR2,
    LOC_CA3AUX  IN   VARCHAR2,
    LOC_CA4AUX  IN   VARCHAR2,
    LOC_CA5AUX  IN   VARCHAR2,
    LOC_REFCON  IN   VARCHAR2,
    Status OUT  VARCHAR2,
    Code OUT  VARCHAR2,
    Message OUT  VARCHAR2,
    Fecha OUT DATE
);
PROCEDURE SetLocPagoEnc (
    ID_TRANSACCION IN VARCHAR2,
    LOC_KEYLOC  IN   VARCHAR2,
    LOC_DESLOC  IN   VARCHAR2,
    LOC_DOMLOC  IN   VARCHAR2,
    LOC_COLLOC  IN   VARCHAR2,
    LOC_CIULOC  IN   VARCHAR2,
    LOC_ESTLOC  IN   VARCHAR2,
    LOC_CODPOS  IN   VARCHAR2,
    LOC_LARDIS  IN   VARCHAR2,
    LOC_TELUNO  IN   VARCHAR2,
    LOC_TELDOS  IN   VARCHAR2,
    LOC_TELTRE  IN   VARCHAR2,
    LOC_CVEZON  IN   VARCHAR2,
    LOC_REGGEO  IN   VARCHAR2,
    LOC_KEYBAN  IN   VARCHAR2,
    LOC_KEYSUC  IN   VARCHAR2,
    LOC_CA1AUX  IN   VARCHAR2,
    LOC_CA2AUX  IN   VARCHAR2,
    LOC_CA3AUX  IN   VARCHAR2,
    LOC_CA4AUX  IN   VARCHAR2,
    LOC_CA5AUX  IN   VARCHAR2,
    LOC_REFCON  IN   VARCHAR2,
    Status OUT  VARCHAR2,
    Code OUT  VARCHAR2,
    Message OUT  VARCHAR2,
    Fecha OUT DATE
);
PROCEDURE SetRegPat_Imss
(
    ID_TRANSACCION IN VARCHAR2,
    IMS_KEYIMS IN   VARCHAR2,
    IMS_RFCIMS IN   VARCHAR2,
    IMS_RAZSOC IN   VARCHAR2,
    IMS_DIRLOC IN   VARCHAR2,
    IMS_NUMEXT IN   VARCHAR2,
    IMS_NUMINT IN   VARCHAR2,
    IMS_COLLOC IN   VARCHAR2,
    IMS_CODPOS IN   VARCHAR2,
    IMS_MUNLOC IN   VARCHAR2,
    IMS_ENTLOC IN   VARCHAR2,
    IMS_NUMBAN IN   VARCHAR2,
    IMS_PRIRIE IN   NUMBER,
    IMS_TIPRIE IN   VARCHAR2,
    IMS_LUGGUI IN   NUMBER,
    IMS_ACTLOC IN   VARCHAR2,
    IMS_KEYBAN IN   VARCHAR2,
    IMS_NUMCOT IN   NUMBER,
    IMS_BASCAL IN   NUMBER,
    IMS_TOTPAG IN   NUMBER,
    IMS_KEYCIA IN   VARCHAR2,
    IMS_CVEEDI IN   VARCHAR2,
    IMS_CA1AUX IN   VARCHAR2,
    IMS_CA2AUX IN   VARCHAR2,
    IMS_CA3AUX IN   VARCHAR2,
    IMS_CA4AUX IN   VARCHAR2,
    IMS_FRANUM IN   VARCHAR2,
    Status OUT  VARCHAR2,
    Code   OUT  VARCHAR2,
    Message  OUT  VARCHAR2,
    Fecha    OUT DATE
);
PROCEDURE SetRegPat_ImssEnc
(
    ID_TRANSACCION IN VARCHAR2,
    IMS_KEYIMS IN   VARCHAR2,
    IMS_RFCIMS IN   VARCHAR2,
    IMS_RAZSOC IN   VARCHAR2,
    IMS_DIRLOC IN   VARCHAR2,
    IMS_NUMEXT IN   VARCHAR2,
    IMS_NUMINT IN   VARCHAR2,
    IMS_COLLOC IN   VARCHAR2,
    IMS_CODPOS IN   VARCHAR2,
    IMS_MUNLOC IN   VARCHAR2,
    IMS_ENTLOC IN   VARCHAR2,
    IMS_NUMBAN IN   VARCHAR2,
    IMS_PRIRIE IN   VARCHAR2,
    IMS_TIPRIE IN   VARCHAR2,
    IMS_LUGGUI IN   VARCHAR2,
    IMS_ACTLOC IN   VARCHAR2,
    IMS_KEYBAN IN   VARCHAR2,
    IMS_NUMCOT IN   VARCHAR2,
    IMS_BASCAL IN   VARCHAR2,
    IMS_TOTPAG IN   VARCHAR2,
    IMS_KEYCIA IN   VARCHAR2,
    IMS_CVEEDI IN   VARCHAR2,
    IMS_CA1AUX IN   VARCHAR2,
    IMS_CA2AUX IN   VARCHAR2,
    IMS_CA3AUX IN   VARCHAR2,
    IMS_CA4AUX IN   VARCHAR2,
    IMS_FRANUM IN   VARCHAR2,
    Status OUT  VARCHAR2,
    Code   OUT  VARCHAR2,
    Message  OUT  VARCHAR2,
    Fecha    OUT DATE
);
PROCEDURE SetCatalogo
(
    ID_TRANSACCION  IN  varchar2,
    PAM_KEYPAR in varchar2,
    PAM_CVESEC in varchar2,
    PAM_NOMPAR in varchar2,
    PAM_FOLINI in varchar2,
    PAM_FOLFIN in varchar2,
    Status out varchar2,
    Code out varchar2,
    Message out varchar2,
    Fecha out date
) ;
PROCEDURE SetCatalogoEnc
(
    ID_TRANSACCION  IN  varchar2,
    PAM_KEYPAR in varchar2,
    PAM_CVESEC in varchar2,
    PAM_NOMPAR in varchar2,
    PAM_FOLINI in varchar2,
    PAM_FOLFIN in varchar2,
    Status out varchar2,
    Code out varchar2,
    Message out varchar2,
    Fecha out date
) ;
END;
/
CREATE OR REPLACE NONEDITIONABLE PACKAGE BODY "LABPROD"."API_CATALOGOS" AS
PROCEDURE SetDepartamento
(
    ID_TRANSACCION IN VARCHAR2,
    DEP_KEYDEP IN VARCHAR2,
    DEP_DESDEP IN VARCHAR2,
    DEP_REFCON IN VARCHAR2,
    DEP_KEYCEN IN VARCHAR2,
    DEP_TIPDEP IN VARCHAR2,
    DEP_NU1AUX IN VARCHAR2,
    DEP_NU2AUX IN VARCHAR2,
    DEP_NU3AUX IN VARCHAR2,
    DEP_NU4AUX IN VARCHAR2,
    DEP_NU5AUX IN VARCHAR2,
    DEP_CA1AUX IN VARCHAR2,
    DEP_CA2AUX IN VARCHAR2,
    DEP_CA3AUX IN VARCHAR2,
    DEP_CA4AUX IN VARCHAR2,
    DEP_CA5AUX IN VARCHAR2,
    Status OUT  VARCHAR2,
    Code OUT  VARCHAR2,
    Message OUT  VARCHAR2,
    Fecha OUT DATE
)   AS
    BANDDEPS NUMBER;
    BEGIN
    Fecha := SYSDATE;
        IF ID_TRANSACCION = '0' THEN
            Status := 'OK';
            Code := '0';
            Message := 'PRUEBA DE SERVICIO';
        ELSE
        Status := 'OK';
        Code := '1';
        IF LENGTH(DEP_KEYDEP)>	16 THEN Message := 'DEP_KEYDEP LONGITUD MAYOR A 16'; Status := 'ERROR'; Code := '4'; END IF;
        IF LENGTH(DEP_DESDEP)>	40 THEN Message := 'DEP_DESDEP LONGITUD MAYOR A 40'; Status := 'ERROR'; Code := '4'; END IF;
        IF LENGTH(DEP_REFCON)>	52 THEN Message := 'DEP_REFCON LONGITUD MAYOR A 52'; Status := 'ERROR'; Code := '4'; END IF;
        IF LENGTH(DEP_KEYCEN)>  16 THEN Message := 'DEP_KEYCEN LONGITUD MAYOR A 16'; Status := 'ERROR'; Code := '4'; END IF;
        IF LENGTH(DEP_TIPDEP)>	1  THEN Message := 'DEP_TIPDEP LONGITUD MAYOR A 16'; Status := 'ERROR'; Code := '4'; END IF;
        IF LENGTH(DEP_NU1AUX) >	10 THEN	Message := 'DEP_NU1AUX LONGITUD MAYOR A 10'; Status := 'ERROR'; Code := '4'; END IF;
        IF LENGTH(DEP_NU2AUX) >	10 THEN Message := 'DEP_NU2AUX LONGITUD MAYOR A 10'; Status := 'ERROR'; Code := '4'; END IF;
        IF LENGTH(DEP_NU3AUX) >	10 THEN Message := 'DEP_NU3AUX LONGITUD MAYOR A 10'; Status := 'ERROR'; Code := '4'; END IF;
        IF LENGTH(DEP_NU4AUX) >	10 THEN	Message := 'DEP_NU4AUX LONGITUD MAYOR A 10'; Status := 'ERROR'; Code := '4'; END IF;
        IF LENGTH(DEP_NU5AUX) >	10 THEN	Message := 'DEP_NU5AUX LONGITUD MAYOR A 10'; Status := 'ERROR'; Code := '4'; END IF;
        IF LENGTH(DEP_CA1AUX) > 10 THEN Message := 'DEP_CA1AUX LONGITUD MAYOR A 10'; Status := 'ERROR'; Code := '4'; END IF;
        IF LENGTH(DEP_CA2AUX)>	10 THEN Message := 'DEP_CA2AUX LONGITUD MAYOR A 10'; Status := 'ERROR'; Code := '4'; END IF;
        IF LENGTH(DEP_CA3AUX) >	10 THEN Message := 'DEP_CA3AUX LONGITUD MAYOR A 10'; Status := 'ERROR'; Code := '4'; END IF;
        IF LENGTH(DEP_CA4AUX) >	10 THEN Message := 'DEP_CA4AUX LONGITUD MAYOR A 10'; Status := 'ERROR'; Code := '4'; END IF;
        IF LENGTH(DEP_CA5AUX) >	10 THEN Message := 'DEP_CA5AUX LONGITUD MAYOR A 10'; Status := 'ERROR'; Code := '4'; END IF;
        IF  Code = '1' then
            begin
            INSERT INTO LABPROD.api_departamento (
            ID_TRANSACCION,
            DEP_KEYDEP ,DEP_DESDEP ,DEP_REFCON ,DEP_KEYCEN ,DEP_TIPDEP ,DEP_NU1AUX ,
            DEP_NU2AUX ,DEP_NU3AUX ,DEP_NU4AUX ,DEP_NU5AUX ,DEP_CA1AUX ,DEP_CA2AUX ,
            DEP_CA3AUX ,DEP_CA4AUX ,DEP_CA5AUX ,STATUS,CODE,MESSAGE,FECHA,FECHA_INSERT,FECHA_PROC)
            VALUES (
            ID_TRANSACCION,
            DEP_KEYDEP ,DEP_DESDEP ,DEP_REFCON ,DEP_KEYCEN ,DEP_TIPDEP ,DEP_NU1AUX ,
            DEP_NU2AUX ,DEP_NU3AUX ,DEP_NU4AUX ,DEP_NU5AUX ,DEP_CA1AUX ,DEP_CA2AUX ,
            DEP_CA3AUX ,DEP_CA4AUX ,DEP_CA5AUX ,'PENDIENTE','1','PENDIENTE A PROCESAR',
            SYSDATE,SYSDATE,SYSDATE);
            COMMIT ;
            EXCEPTION when others then
                Status := 'ERROR';
                Code := SQLCODE;
                Message := SUBSTR(SQLERRM, 1, 149);
            end ;
            BEGIN
            SELECT COUNT(*) INTO BANDDEPS FROM LABPROD.NMCODEPS WHERE DEP_KEYDEP = SetDepartamento.DEP_KEYDEP;
            IF  BANDDEPS = 1 THEN
                UPDATE nmcodeps SET
                nmcodeps.DEP_DESDEP =SetDepartamento.DEP_DESDEP ,
                nmcodeps.DEP_REFCON =SetDepartamento.DEP_REFCON ,
                nmcodeps.DEP_KEYCEN =SetDepartamento.DEP_KEYCEN ,
                nmcodeps.DEP_TIPDEP =SetDepartamento.DEP_TIPDEP ,
                nmcodeps.DEP_NU1AUX =SetDepartamento.DEP_NU1AUX ,
                nmcodeps.DEP_NU2AUX =SetDepartamento.DEP_NU2AUX ,
                nmcodeps.DEP_NU3AUX =SetDepartamento.DEP_NU3AUX ,
                nmcodeps.DEP_NU4AUX =SetDepartamento.DEP_NU4AUX ,
                nmcodeps.DEP_NU5AUX =SetDepartamento.DEP_NU5AUX ,
                nmcodeps.DEP_CA1AUX =SetDepartamento.DEP_CA1AUX ,
                nmcodeps.DEP_CA2AUX =SetDepartamento.DEP_CA2AUX ,
                nmcodeps.DEP_CA3AUX =SetDepartamento.DEP_CA3AUX ,
                nmcodeps.DEP_CA4AUX =SetDepartamento.DEP_CA4AUX ,
                nmcodeps.DEP_CA5AUX =SetDepartamento.DEP_CA5AUX
                WHERE nmcodeps.dep_keydep =SetDepartamento.DEP_KEYDEP;
                commit;
                update  api_departamento set STATUS='OK' , MESSAGE='Se proceso con exito', CODE ='3'
                where api_departamento.ID_TRANSACCION=SetDepartamento.ID_TRANSACCION;
                commit ;
                Status := 'OK';
                Code := '3';
                Message :='Se proceso con exito';
            END IF;
            IF BANDDEPS = 0 THEN
                INSERT INTO nmcodeps (
                dep_keydep,dep_desdep,dep_refcon,dep_keycen,dep_tipdep,dep_nu1aux,dep_nu2aux,dep_nu3aux,dep_nu4aux,dep_nu5aux,
                dep_ca1aux,dep_ca2aux,dep_ca3aux,dep_ca4aux,dep_ca5aux)
                VALUES (
                DEP_KEYDEP ,DEP_DESDEP ,DEP_REFCON ,DEP_KEYCEN ,DEP_TIPDEP ,DEP_NU1AUX ,DEP_NU2AUX ,DEP_NU3AUX ,DEP_NU4AUX ,DEP_NU5AUX ,
                DEP_CA1AUX ,DEP_CA2AUX ,DEP_CA3AUX ,DEP_CA4AUX ,DEP_CA5AUX  );
                commit;
                update  api_departamento set STATUS='OK' , MESSAGE='Se proceso con exito', CODE ='3'
                where api_departamento.ID_TRANSACCION=SetDepartamento.ID_TRANSACCION;
                COMMIT;
                Status := 'OK';
                Code := '3';
                Message :='Se proceso con exito';
            END IF;
            COMMIT;
            EXCEPTION when others then
            Status := 'ERROR';
            Code := SQLCODE;
            Message := SUBSTR(SQLERRM, 1, 149);
            END;
            END IF;
    END IF;
    EXCEPTION when others then
        Status := 'ERROR';
        Code  := SQLCODE;
        Message := SUBSTR(SQLERRM, 1 , 149);
    END;
PROCEDURE SetDepartamentoEnc
(
    ID_TRANSACCION IN VARCHAR2,
    DEP_KEYDEP IN VARCHAR2,
    DEP_DESDEP IN VARCHAR2,
    DEP_REFCON IN VARCHAR2,
    DEP_KEYCEN IN VARCHAR2,
    DEP_TIPDEP IN VARCHAR2,
    DEP_NU1AUX IN VARCHAR2,
    DEP_NU2AUX IN VARCHAR2,
    DEP_NU3AUX IN VARCHAR2,
    DEP_NU4AUX IN VARCHAR2,
    DEP_NU5AUX IN VARCHAR2,
    DEP_CA1AUX IN VARCHAR2,
    DEP_CA2AUX IN VARCHAR2,
    DEP_CA3AUX IN VARCHAR2,
    DEP_CA4AUX IN VARCHAR2,
    DEP_CA5AUX IN VARCHAR2,
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
    Select count(id_transaccion) into existe from LABPROD.API_DEPARTAMENTO WHERE API_DEPARTAMENTO.ID_TRANSACCION = SetDepartamentoEnc.ID_TRANSACCION;
    if existe != 0  then
                Status := 'ERROR';
                Code := '006';
                Message := 'ID_TRANSACCION DUPLICADO';
    end if;
    if Code = '1' then
        BEGIN
        SetDepartamento (ID_TRANSACCION,FN_DECODE(DEP_KEYDEP) ,FN_DECODE(DEP_DESDEP) ,FN_DECODE(DEP_REFCON) ,FN_DECODE(DEP_KEYCEN) ,FN_DECODE(DEP_TIPDEP) ,
        FN_DECODE(DEP_NU1AUX) ,FN_DECODE(DEP_NU2AUX) ,FN_DECODE(DEP_NU3AUX) ,FN_DECODE(DEP_NU4AUX) ,FN_DECODE(DEP_NU5AUX) ,FN_DECODE(DEP_CA1AUX) ,FN_DECODE(DEP_CA2AUX) ,
        FN_DECODE(DEP_CA3AUX) ,FN_DECODE(DEP_CA4AUX) ,FN_DECODE(DEP_CA5AUX) ,SetDepartamentoEnc.Status ,SetDepartamentoEnc.Code ,SetDepartamentoEnc.Message,SetDepartamentoEnc.Fecha);
        EXCEPTION WHEN OTHERS THEN
        CODE := SQLCODE;
        MESSAGE := SUBSTR(SQLERRM, 1 , 149);
        STATUS :='ERROR';
        END;
    END IF;
    END IF;
END;
PROCEDURE SetPuesto (
    ID_TRANSACCION IN VARCHAR2,
    PUE_KEYPUE IN VARCHAR2,
    PUE_DESPUE IN VARCHAR2,
    PUE_REFCON IN VARCHAR2,
    PUE_NU1AUX IN VARCHAR2,
    PUE_NU2AUX IN VARCHAR2,
    PUE_NU3AUX IN VARCHAR2,
    PUE_NU4AUX IN VARCHAR2,
    PUE_NU5AUX IN VARCHAR2,
    PUE_CA1AUX IN VARCHAR2,
    PUE_CA2AUX IN VARCHAR2,
    PUE_CA3AUX IN VARCHAR2,
    PUE_CA4AUX IN VARCHAR2,
    PUE_CA5AUX IN VARCHAR2,
    PUE_SUENIV IN NUMBER,
    PUE_SUBNIV IN NUMBER,
    PUE_KEYSUE IN VARCHAR2,
    PUE_COBERT IN VARCHAR2,
    PUE_AREPUE IN VARCHAR2,
    PUE_SUBARE IN VARCHAR2 ,
    PUE_NIVPUE IN NUMBER,
    PUE_GRPPUE IN VARCHAR2,
    PUE_SUBGRP IN VARCHAR2,
    PUE_TIPPUE IN VARCHAR2,
    Status OUT  VARCHAR2,
    Code OUT  VARCHAR2,
    Message OUT  VARCHAR2,
    Fecha OUT DATE)
    AS
    BANDPUES NUMBER;
    BEGIN
    Fecha := SYSDATE;
    IF ID_TRANSACCION = '0' THEN
        Status:= 'OK';
        Code := '0';
        Message:= 'PRUEBA DE SERVICIO';
    ELSE
    Status := 'ok';
    Code := '1';
    IF LENGTH(PUE_KEYPUE) >	16	THEN Message:='PUE_KEYPUE LONGITUD MAYOR A 16' ; Status := 'ERROR'; Code := '4'; end if;
    IF LENGTH(PUE_DESPUE) >	60	THEN Message:='PUE_DESPUE LONGITUD MAYOR A 60' ; Status := 'ERROR'; Code := '4'; end if;
    IF LENGTH(PUE_REFCON) >	20	THEN Message:='PUE_REFCON LONGITUD MAYOR A 20' ; Status := 'ERROR'; Code := '4'; end if;
    IF LENGTH(PUE_NU1AUX) >  10	THEN Message:='PUE_NU1AUX LONGITUD MAYOR A 10' ; Status := 'ERROR'; Code := '4'; end if;
    IF LENGTH(PUE_NU2AUX) >	10	THEN Message:='PUE_NU2AUX LONGITUD MAYOR A 10' ; Status := 'ERROR'; Code := '4'; end if;
    IF LENGTH(PUE_NU3AUX) >	10	THEN Message:='PUE_NU3AUX LONGITUD MAYOR A 10' ; Status := 'ERROR'; Code := '4'; end if;
    IF LENGTH(PUE_NU4AUX) >	10	THEN Message:='PUE_NU4AUX LONGITUD MAYOR A 10' ; Status := 'ERROR'; Code := '4'; end if;
    IF LENGTH(PUE_NU5AUX) >	10	THEN Message:='PUE_NU5AUX LONGITUD MAYOR A 10' ; Status := 'ERROR'; Code := '4'; end if;
    IF LENGTH(PUE_CA1AUX) >	10	THEN Message:='PUE_CA1AUX LONGITUD MAYOR A 10' ; Status := 'ERROR'; Code := '4'; end if;
    IF LENGTH(PUE_CA2AUX) >	10	THEN Message:='PUE_CA2AUX LONGITUD MAYOR A 10' ; Status := 'ERROR'; Code := '4'; end if;
    IF LENGTH(PUE_CA3AUX) >	10	THEN Message:='PUE_CA3AUX LONGITUD MAYOR A 10' ; Status := 'ERROR'; Code := '4'; end if;
    IF LENGTH(PUE_CA4AUX) >	10	THEN Message:='PUE_CA4AUX LONGITUD MAYOR A 10' ; Status := 'ERROR'; Code := '4'; end if;
    IF LENGTH(PUE_CA5AUX) >	10	THEN Message:='PUE_CA5AUX LONGITUD MAYOR A 10' ; Status := 'ERROR'; Code := '4'; end if;
    IF LENGTH(PUE_KEYSUE) >	4	THEN Message:='PUE_KEYSUE LONGITUD MAYOR A 4' ;  Status := 'ERROR'; Code := '4'; end if;
    IF LENGTH(PUE_COBERT) >	2	THEN Message:='PUE_COBERT LONGITUD MAYOR A 2' ;  Status := 'ERROR'; Code := '4'; end if;
    IF LENGTH(PUE_AREPUE) >	6	THEN Message:='PUE_AREPUE LONGITUD MAYOR A 6' ;  Status := 'ERROR'; Code := '4'; end if;
    IF LENGTH(PUE_SUBARE) >	6	THEN Message:='PUE_SUBARE LONGITUD MAYOR A 6' ;  Status := 'ERROR'; Code := '4'; end if;
    IF LENGTH(PUE_GRPPUE) >	16	THEN Message:='PUE_GRPPUE LONGITUD MAYOR A 16' ; Status := 'ERROR'; Code := '4'; end if;
    IF LENGTH(PUE_SUBGRP) >	16	THEN Message:='PUE_SUBGRP LONGITUD MAYOR A 16' ; Status := 'ERROR'; Code := '4'; end if;
    IF LENGTH(PUE_TIPPUE) >	2	THEN Message:='PUE_TIPPUE LONGITUD MAYOR A 2' ;  Status := 'ERROR'; Code := '4'; end if;
    if code = '1' then
        INSERT INTO api_puesto (ID_TRANSACCION,PUE_KEYPUE ,PUE_DESPUE ,PUE_REFCON ,PUE_NU1AUX ,PUE_NU2AUX ,PUE_NU3AUX ,PUE_NU4AUX ,PUE_NU5AUX ,PUE_CA1AUX ,PUE_CA2AUX ,PUE_CA3AUX ,PUE_CA4AUX ,PUE_CA5AUX ,
        PUE_SUENIV ,PUE_SUBNIV ,PUE_KEYSUE ,PUE_COBERT ,PUE_AREPUE ,PUE_SUBARE ,PUE_NIVPUE ,
        PUE_GRPPUE ,PUE_SUBGRP ,PUE_TIPPUE,status,code,message,fecha,FECHA_INSERT,FECHA_PROC)
        VALUES (ID_TRANSACCION,PUE_KEYPUE ,PUE_DESPUE ,PUE_REFCON ,PUE_NU1AUX ,PUE_NU2AUX ,PUE_NU3AUX ,
        PUE_NU4AUX ,PUE_NU5AUX ,PUE_CA1AUX ,PUE_CA2AUX ,PUE_CA3AUX ,PUE_CA4AUX ,PUE_CA5AUX ,
        PUE_SUENIV ,PUE_SUBNIV ,PUE_KEYSUE ,PUE_COBERT ,PUE_AREPUE ,PUE_SUBARE ,PUE_NIVPUE ,
        PUE_GRPPUE ,PUE_SUBGRP ,PUE_TIPPUE ,'PENDIENTE','0','PENDIENTE A PROCESAR',SYSDATE,SYSDATE,SYSDATE);
        COMMIT ;
        BEGIN
        SELECT COUNT(*) INTO BANDPUES FROM LABPROD.NMCOPUES WHERE nmcopues.pue_keypue= SetPuesto.PUE_KEYPUE;
        IF BANDPUES = 1 THEN
            UPDATE LABPROD.NMCOPUES SET
            NMCOPUES.PUE_DESPUE = SetPuesto.PUE_DESPUE,
            NMCOPUES.PUE_REFCON = SetPuesto.PUE_REFCON,
            NMCOPUES.PUE_NU1AUX = SetPuesto.PUE_NU1AUX,
            NMCOPUES.PUE_NU2AUX = SetPuesto.PUE_NU2AUX,
            NMCOPUES.PUE_NU3AUX = SetPuesto.PUE_NU3AUX,
            NMCOPUES.PUE_NU4AUX = SetPuesto.PUE_NU4AUX,
            NMCOPUES.PUE_NU5AUX = SetPuesto.PUE_NU5AUX,
            NMCOPUES.PUE_CA1AUX = SetPuesto.PUE_CA1AUX,
            NMCOPUES.PUE_CA2AUX = SetPuesto.PUE_CA2AUX,
            NMCOPUES.PUE_CA3AUX = SetPuesto.PUE_CA3AUX,
            NMCOPUES.PUE_CA4AUX = SetPuesto.PUE_CA4AUX,
            NMCOPUES.PUE_CA5AUX = SetPuesto.PUE_CA5AUX,
            NMCOPUES.PUE_SUENIV = SetPuesto.PUE_SUENIV,
            NMCOPUES.PUE_SUBNIV = SetPuesto.PUE_SUBNIV,
            NMCOPUES.PUE_KEYSUE = SetPuesto.PUE_KEYSUE,
            NMCOPUES.PUE_COBERT = SetPuesto.PUE_COBERT,
            NMCOPUES.PUE_AREPUE = SetPuesto.PUE_AREPUE,
            NMCOPUES.PUE_SUBARE = SetPuesto.PUE_SUBARE,
            NMCOPUES.PUE_NIVPUE = SetPuesto.PUE_NIVPUE,
            NMCOPUES.PUE_GRPPUE = SetPuesto.PUE_GRPPUE,
            NMCOPUES.PUE_SUBGRP = SetPuesto.PUE_SUBGRP,
            NMCOPUES.PUE_TIPPUE = SetPuesto.PUE_TIPPUE
            WHERE NMCOPUES.PUE_KEYPUE=SetPuesto.PUE_KEYPUE;
            COMMIT ;
            update  api_puesto set STATUS='OK', MESSAGE ='Se proceso con exito', CODE= '3'
            where api_puesto.ID_TRANSACCION=ID_TRANSACCION;
            COMMIT;
            Status:= 'OK';
            Code:='3';
            Message:='Se proceso con exito';
        END IF;
        IF BANDPUES = 0 THEN
            INSERT INTO nmcopues (pue_keypue,pue_despue,pue_refcon,pue_nu1aux,pue_nu2aux,pue_nu3aux,pue_nu4aux,pue_nu5aux,
            pue_ca1aux,pue_ca2aux,pue_ca3aux,pue_ca4aux,pue_ca5aux,pue_sueniv,pue_subniv,pue_keysue,pue_cobert,pue_arepue,pue_subare,
            pue_nivpue,pue_grppue,pue_subgrp,pue_tippue)
            VALUES (PUE_KEYPUE ,PUE_DESPUE ,PUE_REFCON ,PUE_NU1AUX ,PUE_NU2AUX ,PUE_NU3AUX ,PUE_NU4AUX ,PUE_NU5AUX ,
            PUE_CA1AUX ,PUE_CA2AUX ,PUE_CA3AUX ,PUE_CA4AUX ,PUE_CA5AUX ,PUE_SUENIV ,PUE_SUBNIV ,PUE_KEYSUE ,
            PUE_COBERT ,PUE_AREPUE ,PUE_SUBARE ,PUE_NIVPUE ,PUE_GRPPUE ,PUE_SUBGRP ,PUE_TIPPUE);
            Commit;
            update  api_puesto set STATUS='OK', MESSAGE ='Se proceso con exito', CODE= '3' where api_puesto.ID_TRANSACCION=ID_TRANSACCION;
            COMMIT;
            Status:= 'OK';
            Code:='3';
            Message:='Se proceso con exito';
        END IF;
        COMMIT;
    EXCEPTION   when others then
    Status := 'ERROR';
    Code := SQLCODE;
    Message := SUBSTR(SQLERRM, 1 , 149);
    END;
    end if;
    END IF;
    EXCEPTION when others then
    Status := 'ERROR';
    Code := SQLCODE;
    Message := SUBSTR(SQLERRM, 1 , 149);
    END;
   PROCEDURE SetPuestoEnc (
    ID_TRANSACCION IN VARCHAR2,
    PUE_KEYPUE IN VARCHAR2,
    PUE_DESPUE IN VARCHAR2,
    PUE_REFCON IN VARCHAR2,
    PUE_NU1AUX IN VARCHAR2,
    PUE_NU2AUX IN VARCHAR2,
    PUE_NU3AUX IN VARCHAR2,
    PUE_NU4AUX IN VARCHAR2,
    PUE_NU5AUX IN VARCHAR2,
    PUE_CA1AUX IN VARCHAR2,
    PUE_CA2AUX IN VARCHAR2,
    PUE_CA3AUX IN VARCHAR2,
    PUE_CA4AUX IN VARCHAR2,
    PUE_CA5AUX IN VARCHAR2,
    PUE_SUENIV IN VARCHAR2,
    PUE_SUBNIV IN VARCHAR2,
    PUE_KEYSUE IN VARCHAR2,
    PUE_COBERT IN VARCHAR2,
    PUE_AREPUE IN VARCHAR2,
    PUE_SUBARE IN VARCHAR2 ,
    PUE_NIVPUE IN VARCHAR2,
    PUE_GRPPUE IN VARCHAR2,
    PUE_SUBGRP IN VARCHAR2,
    PUE_TIPPUE IN VARCHAR2,
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
    Code :=  '1';
     SELECT COUNT(ID_TRANSACCION) INTO  existe  FROM LABPROD.API_PUESTO WHERE API_PUESTO.ID_TRANSACCION = SetPuestoEnc.ID_TRANSACCION;
        if existe != 0  then
                Status := 'ERROR';
                Code := '006';
                Message := 'ID_TRANSACCION DUPLICADO';
        end if;
       IF PUE_SUENIV IS NOT NULL THEN
           IF F_IS_INT(FN_DECODE(PUE_SUENIV)) = 0 THEN
                Status := 'ERROR';
                Code := '006';
                Message := 'PUE_SUENIV NO ES DE TIPO INT';
            END IF;
        END IF;
         IF PUE_SUBNIV IS NOT NULL THEN
           IF F_IS_INT(FN_DECODE(PUE_SUBNIV)) = 0 THEN
                Status := 'ERROR';
                Code := '006';
                Message := 'PUE_SUBNIV NO ES DE TIPO INT';
            END IF;
        END IF;
        IF PUE_NIVPUE IS NOT NULL THEN
           IF F_IS_INT(FN_DECODE(PUE_NIVPUE)) = 0 THEN
                Status := 'ERROR';
                Code := '006';
                Message := 'PUE_NIVPUE NO ES DE TIPO INT';
            END IF;
        END IF;
        if Code = '1' then
        BEGIN
        SetPuesto(ID_TRANSACCION ,FN_DECODE(PUE_KEYPUE),FN_DECODE(PUE_DESPUE),FN_DECODE(PUE_REFCON),FN_DECODE(PUE_NU1AUX),FN_DECODE(PUE_NU2AUX),FN_DECODE(PUE_NU3AUX),
        FN_DECODE(PUE_NU4AUX),FN_DECODE(PUE_NU5AUX),FN_DECODE(PUE_CA1AUX),FN_DECODE(PUE_CA2AUX),FN_DECODE(PUE_CA3AUX),FN_DECODE(PUE_CA4AUX),FN_DECODE(PUE_CA5AUX),
        FN_DECODE(PUE_SUENIV),FN_DECODE(PUE_SUBNIV),FN_DECODE(PUE_KEYSUE),FN_DECODE(PUE_COBERT),FN_DECODE(PUE_AREPUE),FN_DECODE(PUE_SUBARE),FN_DECODE(PUE_NIVPUE),
        FN_DECODE(PUE_GRPPUE),FN_DECODE(PUE_SUBGRP),FN_DECODE(PUE_TIPPUE),SetPuestoEnc.Status ,SetPuestoEnc.Code ,SetPuestoEnc.Message,SetPuestoEnc.Fecha);
        EXCEPTION WHEN OTHERS THEN
        CODE := SQLCODE;
        MESSAGE := SUBSTR(SQLERRM, 1 , 149);
        STATUS :='ERROR';
        END;
    END IF;
    END IF;
END;
PROCEDURE SetLocPago (
    ID_TRANSACCION IN VARCHAR2,
    LOC_KEYLOC   IN   VARCHAR2,
    LOC_DESLOC  IN   VARCHAR2,
    LOC_DOMLOC  IN   VARCHAR2,
    LOC_COLLOC  IN   VARCHAR2,
    LOC_CIULOC  IN   VARCHAR2,
    LOC_ESTLOC  IN   VARCHAR2,
    LOC_CODPOS  IN   VARCHAR2,
    LOC_LARDIS  IN   VARCHAR2,
    LOC_TELUNO  IN   VARCHAR2,
    LOC_TELDOS  IN   VARCHAR2,
    LOC_TELTRE  IN   VARCHAR2,
    LOC_CVEZON  IN   NUMBER,
    LOC_REGGEO  IN   VARCHAR2,
    LOC_KEYBAN  IN   VARCHAR2,
    LOC_KEYSUC  IN   VARCHAR2,
    LOC_CA1AUX  IN   VARCHAR2,
    LOC_CA2AUX  IN   VARCHAR2,
    LOC_CA3AUX  IN   VARCHAR2,
    LOC_CA4AUX  IN   VARCHAR2,
    LOC_CA5AUX  IN   VARCHAR2,
    LOC_REFCON  IN   VARCHAR2,
    Status OUT  VARCHAR2,
    Code OUT  VARCHAR2,
    Message OUT  VARCHAR2,
    Fecha OUT DATE) AS
    BANDLOC NUMBER ;
    BEGIN
    FECHA := SYSDATE;
    IF ID_TRANSACCION = '0' THEN
        Status := 'OK';
        Code := '0';
        Message := 'PRUEBA DE SERVICIO';
    ELSE
    Status := 'OK';
    Code := '1';
    IF LENGTH(LOC_KEYLOC) >	16 THEN Message := 'LOC_KEYLOC LONGITUD MAYOR A 12 '; Status := 'ERROR'; Code := '4'; END IF;
    IF LENGTH(LOC_DESLOC) >	40 THEN Message := 'LOC_DESLOC LONGITUD MAYOR A 40 '; Status := 'ERROR'; Code := '4'; END IF;
    IF LENGTH(LOC_DOMLOC) >	30 THEN Message := 'LOC_DOMLOC LONGITUD MAYOR A 30 '; Status := 'ERROR'; Code := '4'; END IF;
    IF LENGTH(LOC_COLLOC) >	20 THEN Message := 'LOC_COLLOC LONGITUD MAYOR A 20 '; Status := 'ERROR'; Code := '4'; END IF;
    IF LENGTH(LOC_CIULOC) >	6  THEN Message := 'LOC_CIULOC LONGITUD MAYOR A 6 ';  Status := 'ERROR'; Code := '4'; END IF;
    IF LENGTH(LOC_ESTLOC) >	6  THEN Message := 'LOC_ESTLOC LONGITUD MAYOR A 6 ';  Status := 'ERROR'; Code := '4'; END IF;
    IF LENGTH(LOC_CODPOS) >	6  THEN Message := 'LOC_CODPOS LONGITUD MAYOR A 6  '; Status := 'ERROR'; Code := '4'; END IF;
    IF LENGTH(LOC_LARDIS) >	5  THEN Message := 'LOC_LARDIS LONGITUD MAYOR A 5';   Status := 'ERROR'; Code := '4'; END IF;
    IF LENGTH(LOC_TELUNO) >	10 THEN Message := 'LOC_TELUNO LONGITUD MAYOR A 10 '; Status := 'ERROR'; Code := '4'; END IF;
    IF LENGTH(LOC_TELDOS) >	10 THEN Message := 'LOC_TELDOS LONGITUD MAYOR A 10 '; Status := 'ERROR'; Code := '4'; END IF;
    IF LENGTH(LOC_TELTRE) >	10 THEN Message := 'LOC_TELTRE LONGITUD MAYOR A 10 '; Status := 'ERROR'; Code := '4'; END IF;
    IF LENGTH(LOC_REGGEO) >	10 THEN Message := 'LOC_REGGEO LONGITUD MAYOR A 10 '; Status := 'ERROR'; Code := '4'; END IF;
    IF LENGTH(LOC_KEYBAN) >	3  THEN Message := 'LOC_KEYBAN LONGITUD MAYOR A 3 ';  Status := 'ERROR'; Code := '4'; END IF;
    IF LENGTH(LOC_KEYSUC) >	4  THEN Message := 'LOC_KEYSUC LONGITUD MAYOR A 4 ';  Status := 'ERROR'; Code := '4'; END IF;
    IF LENGTH(LOC_CA1AUX) >	10 THEN Message := 'LOC_CA1AUX LONGITUD MAYOR A 10 '; Status := 'ERROR'; Code := '4'; END IF;
    IF LENGTH(LOC_CA2AUX) >	10 THEN Message := 'LOC_CA2AUX LONGITUD MAYOR A 10 '; Status := 'ERROR'; Code := '4'; END IF;
    IF LENGTH(LOC_CA3AUX) >	10 THEN Message := 'LOC_CA3AUX LONGITUD MAYOR A 10 '; Status := 'ERROR'; Code := '4'; END IF;
    IF LENGTH(LOC_CA4AUX) >	10 THEN Message := 'LOC_CA4AUX LONGITUD MAYOR A 10 '; Status := 'ERROR'; Code := '4'; END IF;
    IF LENGTH(LOC_CA5AUX) >	10 THEN Message := 'LOC_CA5AUX LONGITUD MAYOR A 10 '; Status := 'ERROR'; Code := '4'; END IF;
    IF LENGTH(LOC_REFCON) >	30 THEN Message := 'LOC_REFCON LONGITUD MAYOR A 30 '; Status := 'ERROR'; Code := '4'; END IF;
    IF  Code = '1' then
        INSERT INTO api_locpago (id_transaccion,LOC_KEYLOC,LOC_DESLOC,LOC_DOMLOC,LOC_COLLOC,LOC_CIULOC,
        LOC_ESTLOC,LOC_CODPOS ,LOC_LARDIS,LOC_TELUNO,LOC_TELDOS,LOC_TELTRE,
        LOC_CVEZON,LOC_REGGEO,LOC_KEYBAN,LOC_KEYSUC,LOC_CA1AUX,LOC_CA2AUX,LOC_CA3AUX,
        LOC_CA4AUX,LOC_CA5AUX,LOC_REFCON,status,code,message,fecha,FECHA_INSERT,FECHA_PROC)
        VALUES (ID_TRANSACCION,LOC_KEYLOC,LOC_DESLOC,LOC_DOMLOC,LOC_COLLOC,LOC_CIULOC,
        LOC_ESTLOC,LOC_CODPOS,LOC_LARDIS,LOC_TELUNO,LOC_TELDOS,LOC_TELTRE,LOC_CVEZON,
        LOC_REGGEO,LOC_KEYBAN,LOC_KEYSUC,LOC_CA1AUX,LOC_CA2AUX,LOC_CA3AUX,LOC_CA4AUX,
        LOC_CA5AUX,LOC_REFCON,'PENDIENTE','0','PENDIENTE A PROCESAR',SYSDATE,SYSDATE,SYSDATE);
        commit ;
        BEGIN
        select count(*) into BANDLOC from nmlolocp  where LOC_KEYLOC = SetLocPago.LOC_KEYLOC;
        IF  BANDLOC = 1 THEN
            update nmlolocp set
            nmlolocp.LOC_DESLOC =SetLocPago.LOC_DESLOC
            where nmlolocp.loc_keyloc=SetLocPago.LOC_KEYLOC;
            COMMIT WORK;
            update  api_locpago set STATUS='OK', MESSAGE='Se proceso con exito', CODE='3'
            where api_locpago.ID_TRANSACCION=SetLocPago.ID_TRANSACCION;
            DBMS_OUTPUT.PUT_LINE ('api_locpago');
            Commit;
            Status:= 'OK';
            Code:='3';
            Message:='Se proceso con exito';
        END IF;
        IF BANDLOC = 0 THEN
            INSERT INTO nmlolocp (loc_keyloc,loc_desloc,loc_domloc,loc_colloc,loc_ciuloc,loc_estloc,loc_codpos,loc_lardis,
            loc_teluno,loc_teldos,loc_teltre,loc_cvezon,loc_reggeo,loc_keyban,loc_keysuc,loc_ca1aux,loc_ca2aux,loc_ca3aux,
            loc_ca4aux,loc_ca5aux,loc_refcon)
            VALUES (
            LOC_KEYLOC,LOC_DESLOC,LOC_DOMLOC,LOC_COLLOC,LOC_CIULOC,LOC_ESTLOC,LOC_CODPOS ,LOC_LARDIS  ,
            LOC_TELUNO,LOC_TELDOS,LOC_TELTRE,LOC_CVEZON,LOC_REGGEO,LOC_KEYBAN,LOC_KEYSUC,LOC_CA1AUX,
            LOC_CA2AUX,LOC_CA3AUX,LOC_CA4AUX,LOC_CA5AUX,LOC_REFCON );
            COMMIT;
            update  api_locpago set STATUS='OK', MESSAGE='Se proceso con exito', CODE='3'
            where api_locpago.ID_TRANSACCION=SetLocPago.ID_TRANSACCION;
            Commit;
            Status:= 'OK';
            Code:='3';
            Message:='Se proceso con exito';
        END IF;
        COMMIT;
        EXCEPTION when others then
            Status := 'ERROR';
            Code :=SQLCODE;
            Message := SUBSTR(SQLERRM, 1 , 149);
        END;
    END IF;
    END IF;
    EXCEPTION when others then
    Status := 'ERROR';
    Code := SQLCODE;
    Message := SUBSTR(SQLERRM, 1 , 149);
END;
   PROCEDURE SetLocPagoEnc (
    ID_TRANSACCION IN VARCHAR2,
    LOC_KEYLOC  IN   VARCHAR2,
    LOC_DESLOC  IN   VARCHAR2,
    LOC_DOMLOC  IN   VARCHAR2,
    LOC_COLLOC  IN   VARCHAR2,
    LOC_CIULOC  IN   VARCHAR2,
    LOC_ESTLOC  IN   VARCHAR2,
    LOC_CODPOS  IN   VARCHAR2,
    LOC_LARDIS  IN   VARCHAR2,
    LOC_TELUNO  IN   VARCHAR2,
    LOC_TELDOS  IN   VARCHAR2,
    LOC_TELTRE  IN   VARCHAR2,
    LOC_CVEZON  IN   VARCHAR2,
    LOC_REGGEO  IN   VARCHAR2,
    LOC_KEYBAN  IN   VARCHAR2,
    LOC_KEYSUC  IN   VARCHAR2,
    LOC_CA1AUX  IN   VARCHAR2,
    LOC_CA2AUX  IN   VARCHAR2,
    LOC_CA3AUX  IN   VARCHAR2,
    LOC_CA4AUX  IN   VARCHAR2,
    LOC_CA5AUX  IN   VARCHAR2,
    LOC_REFCON  IN   VARCHAR2,
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
    Code := '1';
    SELECT COUNT(ID_TRANSACCION) INTO  existe  FROM LABPROD.API_LOCPAGO WHERE API_LOCPAGO.ID_TRANSACCION = SetLocPagoEnc.ID_TRANSACCION;
        if existe != 0  then
                Status := 'ERROR';
                Code := '006';
                Message := 'ID_TRANSACCION DUPLICADO';
        end if;
       IF LOC_CVEZON IS NOT NULL THEN
           IF F_IS_INT(FN_DECODE(LOC_CVEZON)) = 0 THEN
                Status := 'ERROR';
                Code := '006';
                Message := 'LOC_CVEZON NO ES DE TIPO INT';
            END IF;
        END IF;
    if Code = '1' then
    BEGIN
        SetLocPago(ID_TRANSACCION ,FN_DECODE(LOC_KEYLOC)  ,FN_DECODE(LOC_DESLOC)  ,FN_DECODE(LOC_DOMLOC)  ,FN_DECODE(LOC_COLLOC)  ,FN_DECODE(LOC_CIULOC)  ,
        FN_DECODE(LOC_ESTLOC)  ,FN_DECODE(LOC_CODPOS)  ,FN_DECODE(LOC_LARDIS)  ,FN_DECODE(LOC_TELUNO)  ,FN_DECODE(LOC_TELDOS)  ,FN_DECODE(LOC_TELTRE)  ,
        FN_DECODE(LOC_CVEZON)  ,FN_DECODE(LOC_REGGEO)  ,FN_DECODE(LOC_KEYBAN)  ,FN_DECODE(LOC_KEYSUC)  ,FN_DECODE(LOC_CA1AUX)  ,FN_DECODE(LOC_CA2AUX)  ,
        FN_DECODE(LOC_CA3AUX)  ,FN_DECODE(LOC_CA4AUX)  ,FN_DECODE(LOC_CA5AUX)  ,FN_DECODE(LOC_REFCON)  ,SetLocPagoEnc.Status ,SetLocPagoEnc.Code ,SetLocPagoEnc.Message ,
        SetLocPagoEnc.Fecha);
    EXCEPTION WHEN OTHERS THEN
    CODE := SQLCODE;
    MESSAGE := SUBSTR(SQLERRM, 1 , 149);
    STATUS :='ERROR';
    END;
    end if;
    END IF;
END;
PROCEDURE SetRegPat_Imss (
    ID_TRANSACCION IN VARCHAR2,
    IMS_KEYIMS     IN   VARCHAR2,
    IMS_RFCIMS     IN   VARCHAR2,
    IMS_RAZSOC     IN   VARCHAR2,
    IMS_DIRLOC     IN   VARCHAR2,
    IMS_NUMEXT     IN   VARCHAR2,
    IMS_NUMINT     IN   VARCHAR2,
    IMS_COLLOC     IN   VARCHAR2,
    IMS_CODPOS     IN   VARCHAR2,
    IMS_MUNLOC     IN   VARCHAR2,
    IMS_ENTLOC     IN   VARCHAR2,
    IMS_NUMBAN     IN   VARCHAR2,
    IMS_PRIRIE     IN   NUMBER,
    IMS_TIPRIE     IN   VARCHAR2,
    IMS_LUGGUI     IN   NUMBER,
    IMS_ACTLOC     IN   VARCHAR2,
    IMS_KEYBAN     IN   VARCHAR2,
    IMS_NUMCOT     IN   NUMBER,
    IMS_BASCAL     IN   NUMBER,
    IMS_TOTPAG     IN   NUMBER,
    IMS_KEYCIA     IN   VARCHAR2,
    IMS_CVEEDI     IN   VARCHAR2,
    IMS_CA1AUX     IN   VARCHAR2,
    IMS_CA2AUX     IN   VARCHAR2,
    IMS_CA3AUX     IN   VARCHAR2,
    IMS_CA4AUX     IN   VARCHAR2,
    IMS_FRANUM     IN   VARCHAR2,
    Status     OUT  VARCHAR2,
    Code       OUT  VARCHAR2,
    Message    OUT  VARCHAR2,
    Fecha      OUT DATE) AS
    BANDIMSS NUMBER;
    KEYIMSS NUMBER;
    BEGIN
    FECHA := SYSDATE;
    IF ID_TRANSACCION = '0' THEN
        Status := 'OK';
        Code := '0';
        Message := 'PRUEBA DE SERVICIO';
    ELSE
    Status:='OK';
    Code:='1';
    IF LENGTH(IMS_KEYIMS)	>	14 THEN Message := 'IMS_KEYIMS LONGITUD MAYOR A 14';  Status := 'ERROR'; Code := '4';  END IF;
    IF LENGTH(IMS_RFCIMS)	>	14 THEN Message := 'IMS_RFCIMS LONGITUD MAYOR A 14 '; Status := 'ERROR'; Code := '4';  END IF;
    IF LENGTH(IMS_RAZSOC)	>	40 THEN Message := 'IMS_RAZSOC LONGITUD MAYOR A 40';  Status := 'ERROR'; Code := '4';  END IF;
    IF LENGTH(IMS_DIRLOC)	>	40 THEN Message := 'IMS_DIRLOC LONGITUD MAYOR A 40';  Status := 'ERROR'; Code := '4';  END IF;
    IF LENGTH(IMS_NUMEXT)	>	6  THEN Message := 'IMS_NUMEXT LONGITUD MAYOR A 6';   Status := 'ERROR'; Code := '4';  END IF;
    IF LENGTH(IMS_NUMINT)	>	6  THEN Message := 'IMS_NUMINT LONGITUD MAYOR A 6';   Status := 'ERROR'; Code := '4';  END IF;
    IF LENGTH(IMS_COLLOC)	>	20 THEN Message := 'IMS_COLLOC LONGITUD MAYOR A 20';  Status := 'ERROR'; Code := '4';  END IF;
    IF LENGTH(IMS_CODPOS)	>	5  THEN Message := 'IMS_CODPOS LONGITUD MAYOR A 5';   Status := 'ERROR'; Code := '4';  END IF;
    IF LENGTH(IMS_MUNLOC)	>	6  THEN Message := 'IMS_MUNLOC LONGITUD MAYOR A 6';   Status := 'ERROR'; Code := '4';  END IF;
    IF LENGTH(IMS_ENTLOC)	>	2  THEN Message := 'IMS_ENTLOC LONGITUD MAYOR A 2';   Status := 'ERROR'; Code := '4';  END IF;
    IF LENGTH(IMS_NUMBAN)	>	20 THEN Message := 'IMS_NUMBAN LONGITUD MAYOR A 20';  Status := 'ERROR'; Code := '4';  END IF;
    IF LENGTH(IMS_TIPRIE)	>	12 THEN Message := 'IMS_TIPRIE LONGITUD MAYOR A 12';  Status := 'ERROR'; Code := '4';  END IF;
    IF LENGTH(IMS_ACTLOC)	>	24 THEN Message := 'IMS_ACTLOC LONGITUD MAYOR A 24';  Status := 'ERROR'; Code := '4';  END IF;
    IF LENGTH(IMS_KEYBAN)	>	7  THEN Message := 'IMS_KEYBAN LONGITUD MAYOR A 7';   Status := 'ERROR'; Code := '4';  END IF;
    IF LENGTH(IMS_KEYCIA)	>	2  THEN Message := 'IMS_KEYCIA LONGITUD MAYOR A 2';   Status := 'ERROR'; Code := '4';  END IF;
    IF LENGTH(IMS_CVEEDI)	>	16 THEN Message := 'IMS_CVEEDI LONGITUD MAYOR A 16';  Status := 'ERROR'; Code := '4';  END IF;
    IF LENGTH(IMS_CA1AUX)	>	30 THEN Message := 'IMS_CA1AUX LONGITUD MAYOR A 30';  Status := 'ERROR'; Code := '4';  END IF;
    IF LENGTH(IMS_CA2AUX)	>	20 THEN Message := 'IMS_CA2AUX LONGITUD MAYOR A 20 '; Status := 'ERROR'; Code := '4';  END IF;
    IF LENGTH(IMS_CA3AUX)	>	20 THEN Message := 'IMS_CA3AUX LONGITUD MAYOR A 20';  Status := 'ERROR'; Code := '4';  END IF;
    IF LENGTH(IMS_CA4AUX)	>	20 THEN Message := 'IMS_CA4AUXLONGITUD MAYOR A 20';   Status := 'ERROR'; Code := '4';  END IF;
    IF LENGTH(IMS_FRANUM)	>	8  THEN Message := 'IMS_FRANUM LONGITUD MAYOR A 8';   Status := 'ERROR'; Code := '4';  END IF;
    IF Code = '1' then
        INSERT INTO api_regpat_imss (ID_TRANSACCION,IMS_KEYIMS,IMS_RFCIMS,IMS_RAZSOC,IMS_DIRLOC,IMS_NUMEXT,
        IMS_NUMINT,IMS_COLLOC,IMS_CODPOS,IMS_MUNLOC,IMS_ENTLOC,IMS_NUMBAN,IMS_PRIRIE,
        IMS_TIPRIE,IMS_LUGGUI,IMS_ACTLOC,IMS_KEYBAN,IMS_NUMCOT,IMS_BASCAL,IMS_TOTPAG,IMS_KEYCIA,
        IMS_CVEEDI,IMS_CA1AUX,IMS_CA2AUX,IMS_CA3AUX,IMS_CA4AUX,IMS_FRANUM,
        status,code,message,fecha,FECHA_INSERT,FECHA_PROC)
        VALUES (
        ID_TRANSACCION,
        IMS_KEYIMS,IMS_RFCIMS,SUBSTR(IMS_RAZSOC,1,40),IMS_DIRLOC,IMS_NUMEXT,IMS_NUMINT,IMS_COLLOC,
        IMS_CODPOS,IMS_MUNLOC,IMS_ENTLOC,IMS_NUMBAN,IMS_PRIRIE,IMS_TIPRIE,IMS_LUGGUI,
        IMS_ACTLOC,IMS_KEYBAN,IMS_NUMCOT,IMS_BASCAL,IMS_TOTPAG,IMS_KEYCIA,
        IMS_CVEEDI,IMS_CA1AUX,IMS_CA2AUX,IMS_CA3AUX,IMS_CA4AUX,IMS_FRANUM,
        'PENDIENTE','0','PENDIENTE A PROCESAR',SYSDATE,SYSDATE,SYSDATE);
        COMMIT;
        BEGIN
        SELECT COUNT(*)  INTO BANDIMSS FROM  NMLOIMSS WHERE NMLOIMSS.IMS_RFCIMS = SetRegPat_Imss.IMS_RFCIMS;
        IF BANDIMSS = 1 THEN
            update  NMLOIMSS  set
            NMLOIMSS.IMS_KEYIMS=NMLOIMSS.IMS_KEYIMS,
            NMLOIMSS.IMS_RFCIMS=SetRegPat_Imss.IMS_RFCIMS,
            NMLOIMSS.IMS_RAZSOC=SUBSTR(SetRegPat_Imss.IMS_RAZSOC,1,40),
            NMLOIMSS.IMS_DIRLOC=SetRegPat_Imss.IMS_DIRLOC,
            NMLOIMSS.IMS_NUMEXT=SetRegPat_Imss.IMS_NUMEXT,
            NMLOIMSS.IMS_NUMINT=SetRegPat_Imss.IMS_NUMINT,
            NMLOIMSS.IMS_COLLOC=SetRegPat_Imss.IMS_COLLOC,
            NMLOIMSS.IMS_CODPOS=SetRegPat_Imss.IMS_CODPOS,
            NMLOIMSS.IMS_MUNLOC=SetRegPat_Imss.IMS_MUNLOC,
            NMLOIMSS.IMS_ENTLOC=SetRegPat_Imss.IMS_ENTLOC,
            NMLOIMSS.IMS_NUMBAN=SetRegPat_Imss.IMS_NUMBAN,
            NMLOIMSS.IMS_PRIRIE=SetRegPat_Imss.IMS_PRIRIE,
            NMLOIMSS.IMS_TIPRIE=SetRegPat_Imss.IMS_TIPRIE,
            NMLOIMSS.IMS_LUGGUI=SetRegPat_Imss.IMS_LUGGUI,
            NMLOIMSS.IMS_ACTLOC=SetRegPat_Imss.IMS_ACTLOC,
            NMLOIMSS.IMS_KEYBAN=SetRegPat_Imss.IMS_KEYBAN,
            NMLOIMSS.IMS_NUMCOT=SetRegPat_Imss.IMS_NUMCOT,
            NMLOIMSS.IMS_BASCAL=SetRegPat_Imss.IMS_BASCAL,
            NMLOIMSS.IMS_TOTPAG=SetRegPat_Imss.IMS_TOTPAG,
            NMLOIMSS.IMS_KEYCIA=SetRegPat_Imss.IMS_KEYCIA,
            NMLOIMSS.IMS_CVEEDI=SetRegPat_Imss.IMS_CVEEDI,
            NMLOIMSS.IMS_CA1AUX=SetRegPat_Imss.IMS_CA1AUX,
            NMLOIMSS.IMS_CA2AUX=SetRegPat_Imss.IMS_CA2AUX,
            NMLOIMSS.IMS_CA3AUX=SetRegPat_Imss.IMS_CA3AUX,
            NMLOIMSS.IMS_CA4AUX=SetRegPat_Imss.IMS_CA4AUX,
            NMLOIMSS.IMS_FRANUM=SetRegPat_Imss.IMS_FRANUM
            where NMLOIMSS.IMS_RFCIMS=SetRegPat_Imss.IMS_RFCIMS;
            COMMIT;
            update  api_regpat_imss set STATUS='OK', MESSAGE='Se proceso con exito', CODE='3'
            where  api_regpat_imss.ID_TRANSACCION=SetRegPat_Imss.ID_TRANSACCION;
            COMMIT;
            Status:= 'OK';
            Code:='3';
            Message:='Se proceso con exito';
        END IF;
        IF BANDIMSS = 0 THEN
            INSERT INTO NMLOIMSS (
            IMS_KEYIMS,IMS_RFCIMS,IMS_RAZSOC,IMS_DIRLOC,
            IMS_NUMEXT,IMS_NUMINT,IMS_COLLOC,IMS_CODPOS,
            IMS_MUNLOC,IMS_ENTLOC,IMS_NUMBAN,IMS_PRIRIE,
            IMS_TIPRIE,IMS_LUGGUI,IMS_ACTLOC,IMS_KEYBAN,
            IMS_NUMCOT,IMS_BASCAL,IMS_TOTPAG,IMS_KEYCIA,
            IMS_CVEEDI,IMS_CA1AUX,IMS_CA2AUX,IMS_CA3AUX,IMS_CA4AUX,
            IMS_FRANUM  ) VALUES (
            LABPROD.SEC_NMLOIMSS.NEXTVAL,IMS_RFCIMS,SUBSTR(IMS_RAZSOC,1,40),IMS_DIRLOC,IMS_NUMEXT,IMS_NUMINT,
            IMS_COLLOC,IMS_CODPOS,IMS_MUNLOC,IMS_ENTLOC,IMS_NUMBAN,IMS_PRIRIE,IMS_TIPRIE,
            IMS_LUGGUI,IMS_ACTLOC,IMS_KEYBAN,IMS_NUMCOT,IMS_BASCAL,IMS_TOTPAG,IMS_KEYCIA,
            IMS_CVEEDI,IMS_CA1AUX,IMS_CA2AUX,IMS_CA3AUX,IMS_CA4AUX,IMS_FRANUM  );
            COMMIT;
            update  api_regpat_imss set STATUS='OK', MESSAGE='Se proceso con exito', CODE='3'
            where api_regpat_imss.ID_TRANSACCION=ID_TRANSACCION;
            COMMIT ;
            Status:= 'OK';
            Code:='3';
            Message:='Se proceso con exito';
        END IF;
        COMMIT;
        EXCEPTION when others then
            Status := 'ERROR';
            Code := SQLCODE;
            Message := SUBSTR(SQLERRM, 1 , 149);
        END;
        END IF;
    END IF;
    EXCEPTION when others then
        Status := 'ERROR';
        Code := SQLCODE;
        Message := SUBSTR(SQLERRM, 1 , 149);
    END;
PROCEDURE SetRegPat_ImssEnc (
    ID_TRANSACCION IN VARCHAR2,
    IMS_KEYIMS IN   VARCHAR2,
    IMS_RFCIMS IN   VARCHAR2,
    IMS_RAZSOC IN   VARCHAR2,
    IMS_DIRLOC IN   VARCHAR2,
    IMS_NUMEXT IN   VARCHAR2,
    IMS_NUMINT IN   VARCHAR2,
    IMS_COLLOC IN   VARCHAR2,
    IMS_CODPOS IN   VARCHAR2,
    IMS_MUNLOC IN   VARCHAR2,
    IMS_ENTLOC IN   VARCHAR2,
    IMS_NUMBAN IN   VARCHAR2,
    IMS_PRIRIE IN   VARCHAR2,
    IMS_TIPRIE IN   VARCHAR2,
    IMS_LUGGUI IN   VARCHAR2,
    IMS_ACTLOC IN   VARCHAR2,
    IMS_KEYBAN IN   VARCHAR2,
    IMS_NUMCOT IN   VARCHAR2,
    IMS_BASCAL IN   VARCHAR2,
    IMS_TOTPAG IN   VARCHAR2,
    IMS_KEYCIA IN   VARCHAR2,
    IMS_CVEEDI IN   VARCHAR2,
    IMS_CA1AUX IN   VARCHAR2,
    IMS_CA2AUX IN   VARCHAR2,
    IMS_CA3AUX IN   VARCHAR2,
    IMS_CA4AUX IN   VARCHAR2,
    IMS_FRANUM IN   VARCHAR2,
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
    Code :=1;
    if Code = '1' then
     SELECT COUNT(ID_TRANSACCION) INTO  existe  FROM LABPROD.API_REGPAT_IMSS WHERE API_REGPAT_IMSS.ID_TRANSACCION = SetRegPat_ImssEnc.ID_TRANSACCION;
        if existe != 0  then
                Status := 'ERROR';
                Code := '006';
                Message := 'ID_TRANSACCION DUPLICADO';
        end if;
         IF IMS_PRIRIE IS NOT NULL THEN
           IF F_IS_INT(FN_DECODE(IMS_PRIRIE)) = 0 THEN
                Status := 'ERROR';
                Code := '006';
                Message := 'IMS_PRIRIE NO ES DE TIPO INT';
            END IF;
        END IF;
         IF IMS_LUGGUI IS NOT NULL THEN
           IF F_IS_INT(FN_DECODE(IMS_LUGGUI)) = 0 THEN
                Status := 'ERROR';
                Code := '006';
                Message := 'IMS_LUGGUI NO ES DE TIPO INT';
            END IF;
        END IF;
        IF IMS_NUMCOT IS NOT NULL THEN
           IF F_IS_INT(FN_DECODE(IMS_NUMCOT)) = 0 THEN
                Status := 'ERROR';
                Code := '006';
                Message := 'IMS_NUMCOT NO ES DE TIPO INT';
            END IF;
        END IF;
        IF IMS_BASCAL IS NOT NULL THEN
           IF F_IS_INT(FN_DECODE(IMS_BASCAL)) = 0 THEN
                Status := 'ERROR';
                Code := '006';
                Message := 'IMS_BASCAL NO ES DE TIPO INT';
            END IF;
        END IF;
        IF IMS_TOTPAG IS NOT NULL THEN
           IF F_IS_INT(FN_DECODE(IMS_TOTPAG)) = 0 THEN
                Status := 'ERROR';
                Code := '006';
                Message := 'IMS_TOTPAG NO ES DE TIPO INT';
            END IF;
        END IF;
    BEGIN
        SetRegPat_Imss(ID_TRANSACCION,FN_DECODE(IMS_KEYIMS),FN_DECODE(IMS_RFCIMS),FN_DECODE(IMS_RAZSOC),FN_DECODE(IMS_DIRLOC),FN_DECODE(IMS_NUMEXT),FN_DECODE(IMS_NUMINT),
        FN_DECODE(IMS_COLLOC),FN_DECODE(IMS_CODPOS),FN_DECODE(IMS_MUNLOC),FN_DECODE(IMS_ENTLOC),FN_DECODE(IMS_NUMBAN),FN_DECODE(IMS_PRIRIE),FN_DECODE(IMS_TIPRIE),FN_DECODE(IMS_LUGGUI),
        FN_DECODE(IMS_ACTLOC),FN_DECODE(IMS_KEYBAN),FN_DECODE(IMS_NUMCOT),FN_DECODE(IMS_BASCAL),FN_DECODE(IMS_TOTPAG),FN_DECODE(IMS_KEYCIA),FN_DECODE(IMS_CVEEDI),FN_DECODE(IMS_CA1AUX),
        FN_DECODE(IMS_CA2AUX),FN_DECODE(IMS_CA3AUX),FN_DECODE(IMS_CA4AUX),FN_DECODE(IMS_FRANUM),SetRegPat_ImssEnc.Status ,SetRegPat_ImssEnc.Code ,SetRegPat_ImssEnc.Message ,
        SetRegPat_ImssEnc.Fecha);
    EXCEPTION WHEN OTHERS THEN
    CODE := SQLCODE;
    MESSAGE := SUBSTR(SQLERRM, 1 , 149);
    STATUS :='ERROR';
    END;
    end if;
    END IF;
END;
PROCEDURE SetCatalogo  (
    ID_TRANSACCION  IN  VARCHAR2,
    PAM_KEYPAR in varchar2,
    PAM_CVESEC in varchar2,
    PAM_NOMPAR in varchar2,
    PAM_FOLINI in varchar2,
    PAM_FOLFIN in varchar2,
    Status out varchar2,
    Code out varchar2,
    Message out varchar2,
    Fecha out date)
    AS
    v_code NUMBER;
    v_errm VARCHAR2(64);
    valor varchar2(6);
    keypar varchar2(4);
    band varchar2(6);
    folini varchar (2);
    BEGIN
    Fecha := SYSDATE;
    folini:= SUBSTR(setCatalogo.PAM_CVESEC,1,2);
    IF ID_TRANSACCION = '0' THEN
        STATUS := 'OK';
        CODE := '0';
        MESSAGE := 'PRUEBA DE SERVICIO';
    ELSE
        STATUS := 'OK';
        CODE := '1';
        IF LENGTH(PAM_KEYPAR) > 4   THEN MESSAGE := 'PAM_KEYPAR LONGITUD MAYOR A 4 ';   Status := 'ERROR'; Code := '4'; END IF;
        IF LENGTH(PAM_CVESEC) > 6   THEN MESSAGE := 'PAM_CVESEC LONGITUD MAYOR A 6 ';   Status := 'ERROR'; Code := '4'; END IF;
        IF LENGTH(PAM_NOMPAR) > 100 THEN MESSAGE := 'PAM_NOMPAR LONGITUD MAYOR A 100';  Status := 'ERROR'; Code := '4'; END IF;
        IF LENGTH(PAM_FOLINI) > 100 THEN MESSAGE := 'PAM_FOLINI LONGITUD MAYOR A 100';  Status := 'ERROR'; Code := '4'; END IF;
        IF LENGTH(PAM_FOLFIN) > 100 THEN MESSAGE := 'PAM_FOLFIN LONGITUD MAYOR A 100';  Status := 'ERROR'; Code := '4'; END IF;
        IF CODE = '1' THEN
        INSERT INTO api_catalogo (
        ID_TRANSACCION,PAM_KEYPAR,PAM_CVESEC,PAM_NOMPAR,PAM_FOLINI,PAM_FOLFIN,FECHA_INSERT,FECHA_PROC,
        STATUS,CODE,MESSAGE)
        VALUES (
        ID_TRANSACCION,PAM_KEYPAR,PAM_CVESEC,PAM_NOMPAR,PAM_FOLINI,PAM_FOLFIN,SYSDATE,sysdate,'OK','1','PENDIENTE A PROCESAR');
        commit;
        Status := 'OK';
        Code := '1';
        Message := ' Se inserto a staging con exito.';
        --escoger la clave de la tabla
        BEGIN
        IF  PAM_KEYPAR != 'EF' AND
            PAM_KEYPAR != 'MU' AND
            PAM_KEYPAR != 'FP' AND
            PAM_KEYPAR != 'TD' AND
            PAM_KEYPAR != 'IEST'
        THEN
        Status := 'ERROR';
        Code := '02';
        Message := ('La clave del catalogo  ' || SetCatalogo.PAM_KEYPAR || '  no es una de las claves para esta interface');
        UPDATE api_catalogo SET status=SetCatalogo.status, message=SetCatalogo.message, code=SetCatalogo.code,FECHA_PROC=sysdate where api_catalogo.ID_TRANSACCION=SetCatalogo.ID_TRANSACCION;
        commit ;
        ELSE
            SELECT count(*)  INTO band FROM LABPROD.GLCOPAMS WHERE  PAM_KEYPAR = SetCatalogo.PAM_KEYPAR AND PAM_CVESEC=SetCatalogo.PAM_CVESEC;
            if  band = 0  then
                IF PAM_KEYPAR = 'MU' THEN
                    INSERT INTO GLCOPAMS (PAM_KEYPAR,PAM_CVESEC,PAM_NOMPAR,PAM_FOLINI,PAM_FOLFIN)
                    VALUES (PAM_KEYPAR,PAM_CVESEC,PAM_NOMPAR,folini,PAM_FOLFIN);
                    commit ;
                    UPDATE api_catalogo
                    SET status='ok' ,message='Se proceso con exito', code='3',FECHA_PROC=sysdate
                    where  api_catalogo.ID_TRANSACCION=SetCatalogo.ID_TRANSACCION;
                    commit;
                    Status := 'OK';
                    Code := '3';
                    Message := 'Se proceso con exito';
                ELSE
                INSERT INTO GLCOPAMS (PAM_KEYPAR,PAM_CVESEC,PAM_NOMPAR,PAM_FOLINI,PAM_FOLFIN)
                VALUES (PAM_KEYPAR,PAM_CVESEC,PAM_NOMPAR,PAM_FOLINI,PAM_FOLFIN);
                commit ;
                UPDATE api_catalogo SET status='ok' ,message='Se proceso con exito', code='3',FECHA_PROC=sysdate
                where  api_catalogo.ID_TRANSACCION=SetCatalogo.ID_TRANSACCION;
                commit ;
                Status := 'OK';
                Code := '3';
                Message := 'Se proceso con exito';
                END IF;
            end if;
            if   band > 0  then
                IF PAM_KEYPAR = 'MU' THEN
                update GLCOPAMS set PAM_NOMPAR = setCatalogo.PAM_NOMPAR, PAM_FOLINI = folini
                --, PAM_FOLFIN = setCatalogo.PAM_FOLFIN
                where PAM_KEYPAR = setCatalogo.PAM_KEYPAR and PAM_CVESEC = setCatalogo.PAM_CVESEC;
                commit ;
                UPDATE api_catalogo  SET status='ok' ,message='Se proceso con exito',
                code='3' where  api_catalogo.ID_TRANSACCION=SetCatalogo.ID_TRANSACCION;
                DBMS_OUTPUT.PUT_LINE ('Modifica en api_catalogo MU ');
                commit;
                Status := 'OK';
                Code := '3';
                Message := 'Se proceso con exito';
                ELSE
                update GLCOPAMS set PAM_NOMPAR = setCatalogo.PAM_NOMPAR
                where PAM_KEYPAR = setCatalogo.PAM_KEYPAR and PAM_CVESEC = setCatalogo.PAM_CVESEC;
                commit ;
                UPDATE api_catalogo  SET status='ok' ,message='Se proceso con exito',
                code='3' where  api_catalogo.ID_TRANSACCION=SetCatalogo.ID_TRANSACCION;
                commit ;
                Status := 'OK';
                Code := '3';
                Message := 'Se proceso con exito';
                END IF;
            end if;
        END IF;
        EXCEPTION when others then
        Status := 'ERROR';
        Code := SQLCODE;
        Message := SUBSTR(SQLERRM, 1 , 149);
        END;
        END IF;
        END IF ;
        EXCEPTION when others then
        Status := 'ERROR';
        Code := SQLCODE;
        Message := SUBSTR(SQLERRM, 1 , 149);
        END;
    PROCEDURE SetCatalogoEnc (
    ID_TRANSACCION  IN  VARCHAR2,
    PAM_KEYPAR in varchar2,
    PAM_CVESEC in varchar2,
    PAM_NOMPAR in varchar2,
    PAM_FOLINI in varchar2,
    PAM_FOLFIN in varchar2,
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
    Select count(id_transaccion) into existe from LABPROD.API_CATALOGO WHERE API_CATALOGO.ID_TRANSACCION = SetCatalogoEnc.ID_TRANSACCION;
    if existe != 0  then
                Status := 'ERROR';
                Code := '006';
                Message := 'ID_TRANSACCION DUPLICADO';
    end if;
    if Code = '1' then
    BEGIN
        SetCatalogo(ID_TRANSACCION,FN_DECODE(PAM_KEYPAR),FN_DECODE(PAM_CVESEC),FN_DECODE(PAM_NOMPAR),FN_DECODE(PAM_FOLINI),FN_DECODE(PAM_FOLFIN),
        SetCatalogoEnc.Status,SetCatalogoEnc.Code,SetCatalogoEnc.Message,SetCatalogoEnc.Fecha);
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
