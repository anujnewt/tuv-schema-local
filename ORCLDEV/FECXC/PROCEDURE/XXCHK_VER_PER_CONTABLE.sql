CREATE OR REPLACE EDITIONABLE PROCEDURE "FECXC"."XXCHK_VER_PER_CONTABLE" 
  (
    P_FECHA IN DATE,
    /* Cambio de tipo de Dato de int a varchar2 por bug reportado 16ABR/2010  HBCHR */
    P_EMPRESA IN VARCHAR2 )
              IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
  vperiod_name VARCHAR2(250);
  VORG_ID      INTEGER(10);
   V_EMPRESA VARCHAR2(250);
BEGIN
/* Validacion solicitada por Facundo Trejo para obtener organizacioin equivalente a la aplicacion*/
BEGIN
  SELECT  e_codigo_soin
  INTO   V_EMPRESA
  FROM FECXC.FECXC_EMPRESAS
  WHERE E_CODIGO= P_EMPRESA;
EXCEPTION
WHEN no_data_found THEN
  --                    DBMS_OUTPUT.PUT_LINE('NO HAY DATOS');
  RAISE_APPLICATION_ERROR(-20001,'Codigo de Empresa No encontrado');
END;
  ---  Obtengo ORG_ID
BEGIN
   SELECT hou.organization_id org_id
     INTO VORG_ID
     FROM hr.hr_all_organization_units@ERP_PROD hou,
    hr.hr_organization_information@ERP_PROD hoi    ,
    ar.AR_SYSTEM_PARAMETERS_ALL@ERP_PROD asp
    WHERE hou.organization_id                    = hoi.organization_id
  AND hou.organization_id                        = asp.org_id
  AND hoi.org_information1                       = 'OPERATING_UNIT'
  AND hoi.org_information2                       = 'Y'
  AND asp. set_of_books_id                       > 0
  AND SUBSTR(hou.NAME,1, INSTR(hou.NAME,'-')-1) IN (V_EMPRESA);
  -----  Seteo de variables.
 EXCEPTION
WHEN no_data_found THEN
  --                    DBMS_OUTPUT.PUT_LINE('NO HAY DATOS');
  RAISE_APPLICATION_ERROR(-20002,'Codigo de Empresa No encontrado ERP');
WHEN OTHERS THEN
  --                   DBMS_OUTPUT.PUT_LINE('Error desconocido');
  RAISE_APPLICATION_ERROR(-20003,'Error en DBLINK');
END;
  BEGIN
    DBMS_OUTPUT.PUT_LINE(VORG_ID);
    apps.FND_CLIENT_INFO.Set_org_context@ERP_PROD(VORG_ID);
    EXECUTE immediate 'ALTER SESSION SET NLS_LANGUAGE = ''AMERICAN''';
    EXECUTE immediate 'ALTER SESSION SET NLS_NUMERIC_CHARACTERS = ''.,''';
  END;
  --DBMS_OUTPUT.PUT_LINE('VORG_ID');
  --- Verifico Periodo Contable
  BEGIN
   SELECT period_name
    --,start_date,end_date, closing_status
     INTO vperiod_name
    --vperiod_name,vstart_date,vend_date, vclosing_status
     FROM APPS.GL_PERIOD_STATUSES_V@ERP_PROD
    WHERE SET_OF_BOOKS_ID =
    (SELECT asp.set_of_books_id
       FROM hr.hr_all_organization_units@ERP_PROD hou,
      hr.hr_organization_information@ERP_PROD hoi    ,
      AP.AP_SYSTEM_PARAMETERS_ALL@ERP_PROD asp
      WHERE hou.organization_id = hoi.organization_id
    AND hou.organization_id     = asp.org_id
    AND hoi.org_information1    = 'OPERATING_UNIT'
    AND hoi.org_information2    = 'Y'
    AND hou.organization_id     = VORG_ID
    )
  AND APPLICATION_ID = 222
  AND closing_status ='O'
  AND START_DATE    <=to_date(P_FECHA,'dd/mm/yy')
    --AND START_DATE<=to_date('03/03/2010','dd/mm/yy')
  AND END_DATE>=to_date(P_FECHA,'dd/mm/yy')
    --AND END_DATE>=to_date('03/03/2010','dd/mm/yy')
 ORDER BY period_year DESC ,
    PERIOD_NUM DESC;
  DBMS_OUTPUT.PUT_LINE(vperiod_name);
EXCEPTION
WHEN no_data_found THEN
  --                    DBMS_OUTPUT.PUT_LINE('NO HAY DATOS');
  RAISE_APPLICATION_ERROR(-20000,'Periodo no disponible en AR');
WHEN OTHERS THEN
  --                   DBMS_OUTPUT.PUT_LINE('Error desconocido');
  RAISE_APPLICATION_ERROR(-20003,'ERROR en DBLINK');
END;
END;
/
