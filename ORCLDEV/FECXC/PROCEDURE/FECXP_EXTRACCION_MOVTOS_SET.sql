CREATE OR REPLACE EDITIONABLE PROCEDURE "FECXC"."FECXP_EXTRACCION_MOVTOS_SET" 
/*
v1.0 Se actualizan los Egresos procesados con 0 (en el original se dejaban NULL lo cual es incorrecto por que al colgar las cuentas contables no procesaba los registros)
v2.0 Se actualizan los Ingresos procesados con 0 (en el original se dejaban NULL lo cual es incorrecto por que al colgar las cuentas contables no procesaba los registros)
v3.0 ( 17-may-2011) Se activan Los logs para el servidor protele 133.1.12.26 dn la ruta /logs_tabs_fecxpos, Se desactiva el conteo de secuencias duplicadas por que ya se corrigio el problema
v4.0 Se agregan los filtros en la insercion de los folios de ingresos con tipos de operacion 3700, 3701, 3705, 3706, 3708, 3715, 4102,4103
*/
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
        --Se agrega variable para escritura en logs
        fichero utl_file.file_type;
        -- Variables para el proceso de inserci?n de ERP(ORACLE).
        consultaERP     VARCHAR2(4000);
        consultaERP1    VARCHAR2(4000);
        insertarERP     VARCHAR2(4000);
        actualizERP     VARCHAR2(4000);
        numFolioERP     INTEGER;
        consultaORAC    VARCHAR2(4000);
        secueciaORAC    INTEGER;
        secueciaORACrep INTEGER;
       -- existe_secuencia INTEGER; --SE elimina ya que se corregio el problema de las secuencias duplicadas
        -- Variables para la Extraccion del SET.
        noEmpresa       INTEGER;
        noFolioDet      INTEGER;
        cPeriodo        INTEGER;
        idCveOperacion  INTEGER;
        idEstatusMov    VARCHAR2(1);
        noCheque        INTEGER;
        idChequera      VARCHAR2(11);
        idBanco         INTEGER;
        importe         NUMBER;
        idFormaPago     INTEGER;
        fecValor        DATE;
        idDivisa        VARCHAR2(3);
        tipoCambio      NUMBER;
        origenMov       VARCHAR2(3);
        noLoteEnt       INTEGER;
        idTipoOperacion INTEGER;
        noPartida       INTEGER;
        cuentaCont      VARCHAR2(4000);
        subCta          VARCHAR2(4000);
        subSubCta       VARCHAR2(4000);
        importePartida  NUMBER;
        CIA             VARCHAR2(4);
        NEG             VARCHAR2(2);
        CTA             VARCHAR2(3);
        SCTA            VARCHAR2(6);
        CC              VARCHAR2(8);
        ICIA            VARCHAR2(4);
        TOP             VARCHAR2(1);
        codeCombination NUMBER;
        nocliente       VARCHAR2(15);
        idbancobenef    INTEGER;
        idchequerabenef VARCHAR2(11);
        loteentrada     INTEGER;
        nodocto         INTEGER;
        concepto        VARCHAR2(100);
        beneficiario    VARCHAR2(60);
       -- cierre_set      VARCHAR2(4000);
       -- HoraSegura      VARCHAR2(4000);
       -- estatus_set     VARCHAR2(4000);
       -- estatus_flujo   VARCHAR2(4000);
       -- arranca_proceso VARCHAR2(4000);
        referencia      VARCHAR2(30);
        descripcion     VARCHAR2(30);
       -- realiza_extraccion VARCHAR2(4000);
         --variables adicionales
         --step_desc            VARCHAR2(4000);
         --status_desc          VARCHAR2(4000);
         --id_extraccion        VARCHAR2(4000);
         fecModif             DATE;
         nomEmpresa           VARCHAR2(80);
         noCuenta             INTEGER;
         folioRef             INTEGER;
         idTipoMovto          VARCHAR2(1);
         idEstatusMovAplicado VARCHAR2(40);
         existeFolio          INTEGER;
         existeFolioCanc      INTEGER;
         plataforma           VARCHAR2(10);
         secuenciaNoflujo     VARCHAR2(4000);
         creoReplica          VARCHAR2(4000);
         cPeriodoApli         INTEGER;
         nomEmpresaRel        VARCHAR2(80);
         existeSaldo          VARCHAR2(4000);
         existeSaldoAnt       VARCHAR2(4000);
         saldoAnterior        VARCHAR2(4000);
        /*Variables para sincronizaci?n de Monedas*/
         mon_set       VARCHAR2(4000);
         des_set       VARCHAR2(4000);
         mon_oracle    VARCHAR2(4000);
         mon_sybase    VARCHAR2(4000);
         existe_mapeo  VARCHAR2(4000);
         msg_err       VARCHAR2(4000);
         /*Contadores para los cursores*/
         contador_1 INTEGER:=0;
         contador_2 INTEGER:=0;
         contador_3 INTEGER:=0;
          /*para revisar si exise el folio*/
          existe_folio_b    INTEGER;
          /*Manejo de excepciones*/
           err_code INTEGER;
           err_msg VARCHAR2(240);
           /*Variable para la aperturacionde Ingresos*/
           v_aperturar INTEGER:=0;
        /*cursores para simular lo que se extrajo del SET*/
         ---DE LA LINEA 657 A LA 708
         CURSOR CURSOR_1 IS SELECT     F.NO_EMPRESA, F.NO_FOLIO_DET, F.C_PERIODO,
                                       F.CPERIODOAPLI, F.ID_CVE_OPERACION, TRIM(F.ID_ESTATUS_MOV) AS ID_ESTATUS_MOV,
                                       F.NO_CHEQUE, TRIM(F.ID_CHEQUERA) AS ID_CHEQUERA, F.ID_BANCO,
                                       F.IMPORTE, F.ID_FORMA_PAGO, F.FEC_FLUJO,
                                       F.FEC_MODIF, TRIM(F.ID_DIVISA) AS ID_DIVISA, F.TIPO_CAMBIO,
                                       TRIM(F.ORIGEN_MOV) AS ORIGEN_MOV, F.ID_TIPO_OPERACION, TRIM(F.NO_CLIENTE) AS NO_CLIENTE,
                                       F.ID_BANCO_BENEF, TRIM(F.ID_CHEQUERA_BENEF) AS ID_CHEQUERA_BENEF, F.LOTE_ENTRADA,
                                       F.NO_DOCTO, TRIM(F.PLATAFORMA) AS PLATAFORMA, TRIM(F.ACTUALIZADO) AS ACTUALIZADO,
                                       TRIM(F.NOM_EMPRESA) AS NOM_EMPRESA, TRIM(F.NOM_EMPRESA_REL) AS NOM_EMPRESA_REL, F.NO_CUENTA,
                                       F.FOLIO_REF, TRIM(F.ID_TIPO_MOVTO) AS ID_TIPO_MOVTO, F.NO_LOTE_ENT,
                                       F.NO_PARTIDA, TRIM(F.CIA) AS CIA, TRIM(F.NEG) AS NEG,
                                       TRIM(F.CTA) AS CTA, TRIM(F.SCTA) AS SCTA, TRIM(F.CC) AS CC,
                                       TRIM(F.ICIA) AS ICIA, TRIM(F.TOP) AS TOP, F.IMPORTE_PARTIDA,
                                       F.CODECOMBINATION, TRIM(F.CONCEPTO) AS CONCEPTO, TRIM(F.BENEFICIARIO) AS BENEFICIARIO,
                                       TRIM(F.REFERENCIA) AS REFERENCIA, TRIM(F.DESCRIPCION) AS DESCRIPCION
                                    FROM fecxc.fecxp_extraccion_egr_tab F
                                    --where no_folio_det=0
                                    order by no_folio_Det
                                    ;
         ---DE LA LINEA 2319 A LA 2357
         CURSOR CURSOR_2 IS SELECT     F.NO_EMPRESA, F.NO_FOLIO_DET, F.C_PERIODO,
                                       F.CPERIODOAPLI, F.ID_CVE_OPERACION, TRIM(F.ID_ESTATUS_MOV) AS ID_ESTATUS_MOV,
                                       F.NO_CHEQUE, TRIM(F.ID_CHEQUERA) AS ID_CHEQUERA, F.ID_BANCO,
                                       F.IMPORTE, F.ID_FORMA_PAGO, F.FEC_FLUJO,
                                       F.FEC_MODIF, TRIM(F.ID_DIVISA) AS ID_DIVISA, F.TIPO_CAMBIO,
                                       TRIM(F.ORIGEN_MOV) AS ORIGEN_MOV, F.ID_TIPO_OPERACION, TRIM(F.NO_CLIENTE) AS NO_CLIENTE,
                                       F.ID_BANCO_BENEF, TRIM(F.ID_CHEQUERA_BENEF) AS ID_CHEQUERA_BENEF, F.LOTE_ENTRADA,
                                       F.NO_DOCTO, TRIM(F.PLATAFORMA) AS PLATAFORMA, TRIM(F.ACTUALIZADO) AS ACTUALIZADO,
                                       TRIM(F.NOM_EMPRESA) AS NOM_EMPRESA, TRIM(F.NOM_EMPRESA_REL) AS NOM_EMPRESA_REL, F.NO_CUENTA,
                                       F.FOLIO_REF, TRIM(F.ID_TIPO_MOVTO) AS ID_TIPO_MOVTO, TRIM(F.CONCEPTO) AS CONCEPTO,
                                       TRIM(F.BENEFICIARIO) AS BENEFICIARIO, TRIM(F.REFERENCIA) AS REFERENCIA, TRIM(F.DESCRIPCION) AS DESCRIPCION
                            FROM fecxc.fecxp_extraccion_ingr_tab F
                            --where no_folio_det=0
                            order by no_folio_Det
                            ;
         CURSOR CURSOR_3 IS SELECT     F.NO_EMPRESA, F.NO_FOLIO_DET, F.C_PERIODO,
                                       F.CPERIODOAPLI, F.ID_CVE_OPERACION, TRIM(F.ID_ESTATUS_MOV) AS ID_ESTATUS_MOV,
                                       F.NO_CHEQUE, TRIM(F.ID_CHEQUERA) AS ID_CHEQUERA, F.ID_BANCO,
                                       F.IMPORTE, F.ID_FORMA_PAGO, F.FEC_FLUJO,
                                       F.FEC_MODIF, TRIM(F.ID_DIVISA) AS ID_DIVISA, F.TIPO_CAMBIO,
                                       TRIM(F.ORIGEN_MOV) AS ORIGEN_MOV, F.ID_TIPO_OPERACION, TRIM(F.NO_CLIENTE) AS NO_CLIENTE,
                                       F.ID_BANCO_BENEF, TRIM(F.ID_CHEQUERA_BENEF) AS ID_CHEQUERA_BENEF, F.LOTE_ENTRADA,
                                       F.NO_DOCTO, TRIM(F.PLATAFORMA) AS PLATAFORMA, TRIM(F.ACTUALIZADO) AS ACTUALIZADO,
                                       TRIM(F.NOM_EMPRESA) AS NOM_EMPRESA, TRIM(F.NOM_EMPRESA_REL) AS NOM_EMPRESA_REL, F.NO_CUENTA,
                                       F.FOLIO_REF, TRIM(F.ID_TIPO_MOVTO) AS ID_TIPO_MOVTO, TRIM(F.CONCEPTO) AS CONCEPTO,
                                       TRIM(F.BENEFICIARIO) AS BENEFICIARIO, TRIM(F.REFERENCIA) AS REFERENCIA, TRIM(F.DESCRIPCION) AS DESCRIPCION
                            FROM fecxc.fecxp_extraccion_ingrsbc_tab F
                            --where no_folio_det=0
                            order by no_folio_Det
                            ;
      contador_folios INTEGER:=0 ;
/* Decalracion de Arreglos Nuevos */
TYPE t_c1_t IS TABLE OF CURSOR_1%ROWTYPE
        INDEX BY PLS_INTEGER;
t_c1 t_c1_t;
TYPE t_c2_t IS TABLE OF CURSOR_2%ROWTYPE
        INDEX BY PLS_INTEGER;
t_c2 t_c2_t;
TYPE t_c3_t IS TABLE OF CURSOR_3%ROWTYPE
        INDEX BY PLS_INTEGER;
t_c3 t_c3_t;
TYPE REC_FECXP_ENC_PAGOS_ERP IS RECORD
(
  SECUENCIA_PAGOS_ERP  INTEGER               ,
  E_CODIGO             INTEGER               ,
  SECMONEDA            INTEGER,
  FOLIO_SET            VARCHAR2(150)       ,
  PERIODO              INTEGER,
  CVE_OPERACION        INTEGER,
  ESTATUS_MOVIMIENTO   VARCHAR2(1),
  NO_CHEQUE            INTEGER,
  ID_CHEQUERA          VARCHAR2(11),
  ID_BANCO             INTEGER,
  IMPORTE              NUMBER,
  FORMA_PAGO           INTEGER,
  FECHA_APLICACION     DATE,
  MONEDA               VARCHAR2(3),
  TIPO_CAMBIO          NUMBER,
  ORIGEN_MOVIMIENTO    VARCHAR2(3),
  ESTATUS_DE_INGRESO   VARCHAR2(1),
  PROCESADO            INTEGER    ,
  TIPO_OPERACION       INTEGER,
  NO_CLIENTE           VARCHAR2(15),
  ID_BANCO_BENEF       INTEGER,
  ID_CHEQUERA_BENEF    VARCHAR2(11),
  LOTE_ENTRADA         INTEGER,
  NO_DOCTO             INTEGER,
  CONCEPTO             VARCHAR2(100),
  BENEFICIARIO         VARCHAR2(60),
  FECHA_ACTUALIZACION  DATE,
  NOM_EMPRESA          VARCHAR2(100),
  NO_CUENTA            INTEGER     ,
  FOLIO_REF            INTEGER      ,
  NOM_EMPRESA_REL      VARCHAR2(100),
  REFERENCIA           VARCHAR2(30),
  DESCRIPCION          VARCHAR2(30)
);
TYPE T_C1_D IS TABLE OF REC_FECXP_ENC_PAGOS_ERP;
REC_T_C1_D_TMP T_C1_D := T_C1_D();
TYPE REC_FECXP_DET_PAGOS_ERP IS RECORD
(
  SECUENCIA_DET_PAGOS_ERP  INTEGER,
  SECUENCIA_PAGOS_ERP      INTEGER,
  E_CODIGO                 INTEGER,
  NUMERO_DE_PARTIDA_ERP    INTEGER,
  CODE_COMBINATION         INTEGER,
  IMPORTE_LINEA            NUMBER,
  ORACLE_SEGMENTO1         VARCHAR2(25),
  ORACLE_SEGMENTO2         VARCHAR2(25),
  ORACLE_SEGMENTO3         VARCHAR2(25),
  ORACLE_SEGMENTO4         VARCHAR2(25),
  ORACLE_SEGMENTO5         VARCHAR2(25),
  ORACLE_SEGMENTO6         VARCHAR2(25),
  ORACLE_SEGMENTO7         VARCHAR2(25)
);
TYPE T_C1_D_DET IS TABLE OF REC_FECXP_DET_PAGOS_ERP;
REC_T_C1_D_DET_TMP T_C1_D_DET := T_C1_D_DET();
TYPE REC_FECXC_DEP_ESPECIALES IS RECORD
(
  NO_EMPRESA                INTEGER,
  NO_FOLIO_DET              INTEGER,
  FEC_VALOR                 DATE,
  REFERENCIA                VARCHAR2(30),
  ID_BANCO                  INTEGER,
  ID_BANCO_BENEF            INTEGER,
  ID_CHEQUERA               VARCHAR2(20),
  CONCEPTO                  VARCHAR2(100),
  TIPO_CAMBIO               NUMBER,
  IMPORTE                   NUMBER,
  NO_CHEQUE                 INTEGER,
  ID_TIPO_OPERACION_SET     INTEGER,
  ID_FORMA_PAGO             INTEGER,
  ID_DIVISA                 VARCHAR2(3),
  FEC_VALOR_ORIGINAL        DATE,
  ID_STATUS_MOV             VARCHAR2(1),
  BENEFICIARIO              VARCHAR2(60),
  DESCRIPCION               VARCHAR2(30),
  SECUENCIA_DEP_ESPECIALES  INTEGER,
  NO_CLIENTE                VARCHAR2(15),
  PERIODO                   INTEGER,
  CVE_OPERACION             INTEGER,
  ORIGEN_MOVIMIENTO         VARCHAR2(3),
  ID_CHEQUERA_BENEF         VARCHAR2(11),
  LOTE_ENTRADA              INTEGER,
  NO_DOCTO                  INTEGER,
  PLATAFORMA                VARCHAR2(1),
  NOM_EMPRESA               VARCHAR2(100),
  NO_CUENTA                 INTEGER,
  FOLIO_REF                 INTEGER,
  FECHA_ACTUALIZACION       DATE,
  NOM_EMPRESA_REL           VARCHAR2(100),
  PROCESADO                 INTEGER,
  APERTURADOAR              INTEGER
);
TYPE T_C2_D IS TABLE OF REC_FECXC_DEP_ESPECIALES;
REC_T_C2_D_TMP T_C2_D := T_C2_D();
TYPE T_C3_D IS TABLE OF REC_FECXC_DEP_ESPECIALES;
REC_T_C3_D_TMP T_C3_D := T_C3_D();
c_count number;
idcodmoneda varchar(5);
lin_aux number :=0;
lin_aux2 number :=0;
lin_aux3 number :=0;
lin_aux4 number :=0;
BEGIN
        fichero := utl_file.fopen('/fecxcpos_logs','LOGS_'||TO_CHAR(SYSDATE,'DD_MM_YYYY_HH_MI_SS')||'.txt','w');
        lin_aux :=0;
        lin_aux2 :=0;
        lin_aux3 :=0;
        lin_aux4 :=0;
        UPDATE FECXP_PPTO_EXTRACCION_PARAMS  --se limpia tabla
        SET ATRIBUTO1=''
        WHERE PROCESO_ID IN (10);
        COMMIT;
        UPDATE FECXP_PPTO_EXTRACCION_PARAMS  --se detienen los procesos de Llenado
        SET ESTATUS_PROCESO='AUTOMATICO'
        WHERE PROCESO_ID IN (11,12);
        COMMIT;
        UPDATE FECXP_PPTO_EXTRACCION_PARAMS   --se detienen los procesos de Clasificacion
        SET ESTATUS_PROCESO='INACTIVO'
        WHERE PROCESO_ID IN (9,16);
COMMIT;
    DBMS_OUTPUT.PUT_LINE('=== Inicio del proceso de carga ');
    utl_file.put_line(fichero,'=== Inicio del proceso de carga ');
    utl_file.put_line(fichero,'          Abriendo el primer cursor ');
    open CURSOR_1;
    loop
        --DBMS_OUTPUT.PUT_LINE('          Abriendo el primer cursor ');
        fetch CURSOR_1 BULK COLLECT INTO t_c1 limit 100;
        --DBMS_OUTPUT.PUT_LINE('          Asignando el cursor al arreglo ');
        c_count := t_c1.count;
        EXIT WHEN t_c1.count = 0;
       --DBMS_OUTPUT.PUT_LINE('          c_count: '||c_count);
        if c_count > 0 then
            for i in t_c1.first .. t_c1.last
            loop
                noEmpresa         := t_c1(i).no_empresa;
                noFolioDet        := t_c1(i).no_folio_det;
                cPeriodo          := t_c1(i).c_periodo;
                idCveOperacion    := t_c1(i).id_cve_operacion;
                idEstatusMov      := UPPER(t_c1(i).id_estatus_mov);
                noCheque          := t_c1(i).no_cheque;
                idChequera        := t_c1(i).id_chequera;
                idBanco           := t_c1(i).id_banco;
                importe           := t_c1(i).importe;
                idFormaPago       := t_c1(i).id_forma_pago;
                fecValor          := t_c1(i).fec_flujo;
                idDivisa          := t_c1(i).id_divisa;
                tipoCambio        := t_c1(i).tipo_cambio;
                origenMov         := t_c1(i).origen_mov;
                idTipoOperacion   := t_c1(i).id_tipo_operacion;
                nocliente         := t_c1(i).no_cliente;
                idbancobenef      := t_c1(i).id_banco_benef;
                idchequerabenef   := t_c1(i).id_chequera_benef;
                loteentrada       := t_c1(i).lote_entrada;
                nodocto           := t_c1(i).no_docto;
                concepto          := t_c1(i).concepto;
                beneficiario      := t_c1(i).beneficiario;
                referencia        := t_c1(i).referencia;
                descripcion       := t_c1(i).descripcion;
                fecModif          := t_c1(i).fec_modif;
                nomEmpresa        := t_c1(i).no_empresa;
                noCuenta          := t_c1(i).no_cuenta;
                folioRef          := t_c1(i).folio_ref;
                idTipoMovto       := t_c1(i).id_tipo_movto;
                cPeriodoApli      := t_c1(i).cPeriodoApli;
                nomEmpresaRel     := t_c1(i).nom_empresa_rel;
                noPartida         := t_c1(i).No_partida;
                importePartida    := t_c1(i).Importe_partida;
                CIA               := t_c1(i).CIA;
                NEG               := t_c1(i).NEG;
                CTA               := t_c1(i).CTA;
                SCTA              := t_c1(i).SCTA;
                CC                := t_c1(i).CC;
                ICIA              := t_c1(i).ICIA;
                TOP               := t_c1(i).TOP;
                codeCombination   := t_c1(i).codeCombination;
                ------------------------------------------------
               --DBMS_OUTPUT.PUT_LINE(' foliodet:'||NVL(noFolioDet,0));
               utl_file.put_line(fichero,' foliodet:'||NVL(noFolioDet,0));
               --DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------------------------------------------------------------------------------------      ');
               --DBMS_OUTPUT.PUT_LINE('          Iguala las variables del proceso');
               --DBMS_OUTPUT.PUT_LINE('folioerp:'||NVL(numFolioERP,1)||' foliodet:'||NVL(noFolioDet,0));
                ------------------------------------------------
                  --Verificar si debe generar encabezado o detalle
                  IF (NVL(numFolioERP,1)!=NVL(noFolioDet,0)) THEN
                      --inicializa bandera de crear r?plicas
                      --DBMS_OUTPUT.PUT_LINE('          Primer If');
                      creoReplica:='N';
                      IF (idEstatusMov='X' OR idEstatusMov='Y' OR idEstatusMov='Z') THEN
                         --Para el movimiento aplicado original hay que determinar qu? estatus debe llevar de acuerdo a la forma de pago
                         --DBMS_OUTPUT.PUT_LINE('[El folio esta cancelado y ha entrado a esta l?gica] Status:'||idEstatusMov );
                         utl_file.put_line(fichero,'[El folio esta cancelado y ha entrado a esta logica] Status:'||idEstatusMov );
                          idEstatusMovAplicado := 'A';
                          IF (idFormaPago=3 AND idTipoOperacion=3200) THEN
                                        idEstatusMovAplicado := 'K';
                          END IF;
                          IF idTipoOperacion=3200 AND (idFormaPago=1 OR idFormaPago=8 OR idFormaPago=9) THEN
                                        idEstatusMovAplicado := 'I';
                          END IF;
                          IF (idTipoOperacion=7000) OR (idTipoOperacion = 7001) OR (idTipoOperacion = 7002) OR (idTipoOperacion= 7003) OR ( idTipoOperacion= 7005 ) THEN
                                        idEstatusMovAplicado := 'L';
                          END IF;
                          --DBMS_OUTPUT.PUT_LINE('[El Status aplicado es]: ' || idEstatusMovAplicado || '');
                           utl_file.put_line(fichero,'[El Status aplicado es]: ' || idEstatusMovAplicado || '');
                          --Buscar el folio con estatus aplicado en la base de datos, esto para las validaciones en caso de que la
                          --cancelaci?n se haga o no el d??a de la generaci?n.
                          SELECT /*+ INDEX (E IDX2_PAG_ERP_FOLIO) */ COUNT(*) INTO existeFolio FROM FECXP_ENC_PAGOS_ERP E WHERE FOLIO_SET = to_char(noFolioDet)  AND ESTATUS_MOVIMIENTO =  idEstatusMovAplicado;
                          IF existeFolio!=0 THEN
                            --DBMS_OUTPUT.PUT_LINE('existe folio');
                            utl_file.put_line(fichero,'existe folio');
                             null;
                          END IF;
                          --DBMS_OUTPUT.PUT_LINE('[Se han localizado]: ' || existeFolio || ' folios con este mismo status.');
                          --DBMS_OUTPUT.PUT_LINE('fecValor: ' ||trunc(fecValor) || ' fecModif: '||trunc(fecModif));
                          utl_file.put_line(fichero,'[Se han localizado]: ' || existeFolio || ' folios con este mismo status.');
                          utl_file.put_line(fichero,'fecValor: ' ||trunc(fecValor) || ' fecModif: '||trunc(fecModif));
                          --Es un cancelado comparar las fechas, cuando se cancela el d??a de la generaci?n hay que crear la r?plica aplicada
                          --Cuando tienen fechas diferentes debe validar que ya existe la aplicada previamente
                          IF  trunc(fecValor)=trunc(fecModif) THEN
                              --Se gener?? y se cancel?? el mismo d??a, por tanto hay que crear primero la r?plica aplicada
                              IF (existeFolio=0) THEN
                                 --No existe el folio+status+tipooper y se generar?
                                --DBMS_OUTPUT.PUT_LINE('Folio cancelado el d??a del origen. Se generar? r?plica aplicada FECXP_ENC_PAGOS_ERP con Folio: '|| noFolioDet ||' Status: ' || idEstatusMovAplicado||' TipoOper: ' || idTipoOperacion);
                                --DBMS_OUTPUT.PUT_LINE('Folio cancelado el d??a del origen.');
                                utl_file.put_line(fichero,'Folio cancelado el dia del origen. Se generara replica aplicada FECXP_ENC_PAGOS_ERP con Folio: '|| noFolioDet ||' Status: ' || idEstatusMovAplicado||' TipoOper: ' || idTipoOperacion);
                                 -- Obtenemos la secuencia de la tabla FECXP_ENC_PAGOS_ERP
                                 SELECT SECUENCIA_PAGOS_ERP.NEXTVAL INTO secueciaORACrep  FROM dual;
                               --DBMS_OUTPUT.PUT_LINE('    [DATO] Folio: ' || noFolioDet);
                               --DBMS_OUTPUT.PUT_LINE('    [DATO] Status: ' || idEstatusMovAplicado);
                               --DBMS_OUTPUT.PUT_LINE('    [DATO] fecFlujo: ' || fecValor);
                               --DBMS_OUTPUT.PUT_LINE('    [DATO] fecModif: ' || fecModif);
                               utl_file.put_line(fichero,'    [DATO] Folio: ' || noFolioDet);
                               utl_file.put_line(fichero,'    [DATO] Status: ' || idEstatusMovAplicado);
                               utl_file.put_line(fichero,'    [DATO] fecFlujo: ' || fecValor);
                               utl_file.put_line(fichero,'    [DATO] fecModif: ' || fecModif);
                                 REC_T_C1_D_TMP.EXTEND;
                                 lin_aux:=lin_aux+1;--bogar
                                 -- Inserta replica aplicada en la tabla FECXP_ENC_PAGOS_ERP
                                 SELECT             secueciaORACrep        , noEmpresa        , b.SECMONEDA    , noFolioDet          , cPeriodoApli             , idCveOperacion,
                                                    idEstatusMovAplicado   , noCheque         , idChequera     , idBanco             , (importe*-1)               , idFormaPago,
                                                    fecValor            , idDivisa       , tipoCambio       , trim(origenMov)       , idTipoOperacion, nocliente,
                                                    idbancobenef        , idchequerabenef  , loteentrada    , nodocto             , concepto              , beneficiario,
                                                    SYSDATE             , nomEmpresa       , nomEmpresaRel  , noCuenta            ,  folioRef             , referencia    , descripcion,0
                                               INTO REC_T_C1_D_TMP(lin_aux).SECUENCIA_PAGOS_ERP, REC_T_C1_D_TMP(lin_aux).E_CODIGO         , REC_T_C1_D_TMP(lin_aux).SECMONEDA        , REC_T_C1_D_TMP(lin_aux).FOLIO_SET           , REC_T_C1_D_TMP(lin_aux).PERIODO             , REC_T_C1_D_TMP(lin_aux).CVE_OPERACION,
                                                    REC_T_C1_D_TMP(lin_aux).ESTATUS_MOVIMIENTO , REC_T_C1_D_TMP(lin_aux).NO_CHEQUE        , REC_T_C1_D_TMP(lin_aux).ID_CHEQUERA      , REC_T_C1_D_TMP(lin_aux).ID_BANCO            , REC_T_C1_D_TMP(lin_aux).IMPORTE             , REC_T_C1_D_TMP(lin_aux).FORMA_PAGO   ,
                                                    REC_T_C1_D_TMP(lin_aux).FECHA_APLICACION   , REC_T_C1_D_TMP(lin_aux).MONEDA           , REC_T_C1_D_TMP(lin_aux).TIPO_CAMBIO      , REC_T_C1_D_TMP(lin_aux).ORIGEN_MOVIMIENTO   , REC_T_C1_D_TMP(lin_aux).TIPO_OPERACION      , REC_T_C1_D_TMP(lin_aux).NO_CLIENTE   ,
                                                    REC_T_C1_D_TMP(lin_aux).ID_BANCO_BENEF     , REC_T_C1_D_TMP(lin_aux).ID_CHEQUERA_BENEF, REC_T_C1_D_TMP(lin_aux).LOTE_ENTRADA     , REC_T_C1_D_TMP(lin_aux).NO_DOCTO            , REC_T_C1_D_TMP(lin_aux).CONCEPTO            , REC_T_C1_D_TMP(lin_aux).BENEFICIARIO ,
                                                    REC_T_C1_D_TMP(lin_aux).FECHA_ACTUALIZACION, REC_T_C1_D_TMP(lin_aux).NOM_EMPRESA      , REC_T_C1_D_TMP(lin_aux).NOM_EMPRESA_REL  , REC_T_C1_D_TMP(lin_aux).NO_CUENTA           , REC_T_C1_D_TMP(lin_aux).FOLIO_REF           , REC_T_C1_D_TMP(lin_aux).REFERENCIA   ,
                                                    REC_T_C1_D_TMP(lin_aux).DESCRIPCION,REC_T_C1_D_TMP(lin_aux).PROCESADO
                                               FROM dual a, FECXC_MONEDAS b
                                               WHERE b.CODMONEDA = idDivisa;
                               --DBMS_OUTPUT.PUT_LINE('        [INSERT FECXP_ENC_PAGOS_ERP ]: ');
                               utl_file.put_line(fichero,'        [INSERT FECXP_ENC_PAGOS_ERP ]: ');
                                 creoReplica :='S';
                                 numFolioERP := noFolioDet;
                              ELSE -- termina if existe folio aplicado
                                   --YA EXISTE EL FOLIO+STATUS EN ESTE CASO SE REABRE PARA SU APERTURACI??N Y SE
                                   --MANDAR??N LOS DATOS AL LOG DE JAGUAR
                                   --DEBIDO A QUE EL MOVIMIENTO NO DEBER??A EXISTIR PREVIAMENTE, PUES EN EL SET NACE Y SE
                                   --CANCELA EL MISMO DIA.
                                   --Forzar al reprocesamiento
                                   UPDATE    FECXP_ENC_PAGOS_ERP
                                      SET PROCESADO = 0
                                    WHERE    FOLIO_SET = to_char(noFolioDet)
                                      AND ESTATUS_MOVIMIENTO = idEstatusMovAplicado ;
                                   --DBMS_OUTPUT.PUT_LINE('        [REAPERTURA]: ');
                                   utl_file.put_line(fichero,'        [REAPERTURA]: ');
                                   DELETE    FECXP_DET_PAGOS_PROCESADOS D
                                   WHERE    EXISTS (
                                                                      SELECT    1
                                                                       FROM    FECXP_ENC_PAGOS_ERP E
                                                                      WHERE    E.FOLIO_SET = to_char(noFolioDet)
                                                                        AND    E.ESTATUS_MOVIMIENTO = idEstatusMovAplicado
                                                                        AND    E.SECUENCIA_PAGOS_ERP = D.SECUENCIA_PAGOS_ERP);
                                                    DELETE    FECXP_BIT_CONT_DIN_FOLIOS_AP D
                                                     WHERE    EXISTS (
                                                                      SELECT    1
                                                                      FROM      FECXP_ENC_PAGOS_ERP E
                                                                      WHERE     E.FOLIO_SET = to_char(noFolioDet)
                                                                      AND       E.ESTATUS_MOVIMIENTO = idEstatusMovAplicado
                                                                      AND       E.SECUENCIA_PAGOS_ERP = D.SECUENCIA_PAGOS_ERP);
                                                    DELETE    FECXP_BIT_CONT_DIN_APER_DET D
                                                     WHERE    EXISTS (
                                                                      SELECT   1
                                                                      FROM     FECXP_ENC_PAGOS_ERP E
                                                                      WHERE    E.FOLIO_SET = to_char(noFolioDet)
                                                                      AND      E.ESTATUS_MOVIMIENTO = idEstatusMovAplicado
                                                                      AND      E.SECUENCIA_PAGOS_ERP = D.SECUENCIA_PAGOS_ERP);
                                                  DELETE    FECXP_BIT_CONT_DIN_APER_ENC D
                                                   WHERE    EXISTS (
                                                                    SELECT    1
                                                                      FROM    FECXP_ENC_PAGOS_ERP E
                                                                     WHERE    E.FOLIO_SET = to_char(noFolioDet)
                                                                       AND    E.ESTATUS_MOVIMIENTO = idEstatusMovAplicado
                                                                       AND        E.SECUENCIA_PAGOS_ERP = D.SECUENCIA_PAGOS_ERP);
                              END IF; --Finaliza else, caso en el que la r?plica aplicada del egreso oracle ya existe y se actualiza
                          ELSE   -- termina if cuando fechamodif = fechavalor
                                 --Si la fecha de cancelaci?n no es la de generaci?n validar que ya existe el registro aplicado
                              IF existeFolio=0 THEN
                                 --NO EXISTE EL FOLIO+STATUS aplicado Y SE GENERAR?? CON LOS NUEVOS DATOS
                                --DBMS_OUTPUT.PUT_LINE(' Se cancel?? en fecha distinta al origen y no existe el aplicado.Se generar? r?plica aplicada fecxp_enc_pagos_erp con Folio: ' || noFolioDet || ' Status: ' || idEstatusMovAplicado || ' TipoOper: ' || idTipoOperacion);
                                --DBMS_OUTPUT.PUT_LINE(' La fecha de modificaci?n y aplicaci?n no son iguales.');
                                 -- Obtenemos la secuencia de la tabla FECXP_ENC_PAGOS_ERP
                                 SELECT SECUENCIA_PAGOS_ERP.NEXTVAL INTO secueciaORACrep FROM dual;
                               --DBMS_OUTPUT.PUT_LINE('    [DATO] Folio: ' || noFolioDet);
                               --DBMS_OUTPUT.PUT_LINE('    [DATO] Status: ' || idEstatusMovAplicado);
                               --DBMS_OUTPUT.PUT_LINE('    [DATO] fecFlujo: ' || fecValor);
                               --DBMS_OUTPUT.PUT_LINE('    [DATO] fecModif: ' || fecModif);
                               utl_file.put_line(fichero,'    [DATO] Folio: ' || noFolioDet);
                               utl_file.put_line(fichero,'    [DATO] Status: ' || idEstatusMovAplicado);
                               utl_file.put_line(fichero,'    [DATO] fecFlujo: ' || fecValor);
                               utl_file.put_line(fichero,'    [DATO] fecModif: ' || fecModif);
                                 REC_T_C1_D_TMP.EXTEND;
                                 lin_aux:=lin_aux+1;--bogar
                                  SELECT                secueciaORACrep       , noEmpresa        , b.SECMONEDA    , noFolioDet          , cPeriodoApli              , idCveOperacion,
                                                        idEstatusMovAplicado        , noCheque         , idChequera     , idBanco             , (importe*-1)               , idFormaPago,
                                                        fecValor            , idDivisa       , tipoCambio       , trim(origenMov)     , idTipoOperacion       , nocliente,
                                                        idbancobenef        , idchequerabenef  , loteentrada    , nodocto             , concepto              , beneficiario,
                                                        SYSDATE             , nomEmpresa       , nomEmpresaRel  , noCuenta            ,  folioRef             , referencia    , descripcion,0
                                                INTO REC_T_C1_D_TMP(lin_aux).SECUENCIA_PAGOS_ERP, REC_T_C1_D_TMP(lin_aux).E_CODIGO         , REC_T_C1_D_TMP(lin_aux).SECMONEDA        , REC_T_C1_D_TMP(lin_aux).FOLIO_SET           , REC_T_C1_D_TMP(lin_aux).PERIODO             , REC_T_C1_D_TMP(lin_aux).CVE_OPERACION,
                                                     REC_T_C1_D_TMP(lin_aux).ESTATUS_MOVIMIENTO , REC_T_C1_D_TMP(lin_aux).NO_CHEQUE        , REC_T_C1_D_TMP(lin_aux).ID_CHEQUERA      , REC_T_C1_D_TMP(lin_aux).ID_BANCO            , REC_T_C1_D_TMP(lin_aux).IMPORTE             , REC_T_C1_D_TMP(lin_aux).FORMA_PAGO   ,
                                                     REC_T_C1_D_TMP(lin_aux).FECHA_APLICACION   , REC_T_C1_D_TMP(lin_aux).MONEDA           , REC_T_C1_D_TMP(lin_aux).TIPO_CAMBIO      , REC_T_C1_D_TMP(lin_aux).ORIGEN_MOVIMIENTO   , REC_T_C1_D_TMP(lin_aux).TIPO_OPERACION      , REC_T_C1_D_TMP(lin_aux).NO_CLIENTE   ,
                                                     REC_T_C1_D_TMP(lin_aux).ID_BANCO_BENEF     , REC_T_C1_D_TMP(lin_aux).ID_CHEQUERA_BENEF, REC_T_C1_D_TMP(lin_aux).LOTE_ENTRADA     , REC_T_C1_D_TMP(lin_aux).NO_DOCTO            , REC_T_C1_D_TMP(lin_aux).CONCEPTO            , REC_T_C1_D_TMP(lin_aux).BENEFICIARIO ,
                                                     REC_T_C1_D_TMP(lin_aux).FECHA_ACTUALIZACION, REC_T_C1_D_TMP(lin_aux).NOM_EMPRESA      , REC_T_C1_D_TMP(lin_aux).NOM_EMPRESA_REL  , REC_T_C1_D_TMP(lin_aux).NO_CUENTA           , REC_T_C1_D_TMP(lin_aux).FOLIO_REF           , REC_T_C1_D_TMP(lin_aux).REFERENCIA   ,
                                                     REC_T_C1_D_TMP(lin_aux).DESCRIPCION,REC_T_C1_D_TMP(lin_aux).PROCESADO
                                                FROM dual a, FECXC_MONEDAS b
                                                WHERE b.CODMONEDA = idDivisa;
                                               --DBMS_OUTPUT.PUT_LINE('        [INSERT FECXP_ENC_PAGOS_ERP ]: ');
                                                numFolioERP := noFolioDet;
                                                creoReplica :='S';
                              ELSE --finaliza if cuando el folio aplicado no existe y las fechas de cancelaci?n y aplicaci?n no coinciden
                                   -- cuando el folio aplicado ya existe y las fechas de aplicaci?n y cancelaci?n no coinciden
                                   --Se asume que ya existe el folio y se realiz?? su aperturaci?n, por tanto se reabre para
                                   --reprocesarlo
                                   --SE OBLIGA AL SISTEMA A REPROCESAR LA APERTURACI??N DE LOS FOLIOS Cambiando su status
                                   --Y ELIMINANDO EL PAGO PROCESADO ANTERIOR PARA QUE SEA REGENERADO
                                    --DBMS_OUTPUT.PUT_LINE('Forzar al reprocesamiento');
                                    utl_file.put_line(fichero,'Forzar al reprocesamiento');
                                            --Forzar al reprocesamiento
                                                UPDATE    FECXP_ENC_PAGOS_ERP
                                                   SET    PROCESADO = 0
                                                 WHERE    FOLIO_SET = to_char(noFolioDet)
                                                   AND    ESTATUS_MOVIMIENTO = idEstatusMovAplicado;
                                           --DBMS_OUTPUT.PUT_LINE('        [REAPERTURA]: ');
                                           utl_file.put_line(fichero,'        [REAPERTURA]: ');
                                            DELETE    FECXP_DET_PAGOS_PROCESADOS D
                                            WHERE    EXISTS (
                                                             SELECT  1
                                                             FROM    FECXP_ENC_PAGOS_ERP E
                                                             WHERE   E.FOLIO_SET = to_char(noFolioDet)
                                                             AND     E.ESTATUS_MOVIMIENTO = idEstatusMovAplicado
                                                             AND     E.SECUENCIA_PAGOS_ERP = D.SECUENCIA_PAGOS_ERP);
                                           --DBMS_OUTPUT.PUT_LINE('        [DELETE FECXP_DET_PAGOS_PROCESADOS]:');
                                            DELETE    FECXP_BIT_CONT_DIN_FOLIOS_AP D
                                            WHERE    EXISTS (
                                                             SELECT  1
                                                             FROM    FECXP_ENC_PAGOS_ERP E
                                                             WHERE   E.FOLIO_SET = to_char(noFolioDet)
                                                             AND     E.ESTATUS_MOVIMIENTO = idEstatusMovAplicado
                                                             AND     E.SECUENCIA_PAGOS_ERP = D.SECUENCIA_PAGOS_ERP);
                                           --DBMS_OUTPUT.PUT_LINE('        [DELETE FECXP_BIT_CONT_DIN_FOLIOS_AP]: ' );
                                            DELETE    FECXP_BIT_CONT_DIN_APER_DET D
                                            WHERE    EXISTS (
                                                              SELECT    1
                                                              FROM    FECXP_ENC_PAGOS_ERP E
                                                              WHERE    E.FOLIO_SET = to_char(noFolioDet)
                                                              AND E.ESTATUS_MOVIMIENTO = idEstatusMovAplicado
                                                              AND        E.SECUENCIA_PAGOS_ERP = D.SECUENCIA_PAGOS_ERP);
                                           --DBMS_OUTPUT.PUT_LINE('       [DELETE FECXP_BIT_CONT_DIN_APER_DET]: ');
                                            DELETE    FECXP_BIT_CONT_DIN_APER_ENC D
                                             WHERE    EXISTS (
                                                              SELECT    1
                                                              FROM    FECXP_ENC_PAGOS_ERP E
                                                              WHERE    E.FOLIO_SET = to_char(noFolioDet)
                                                              AND E.ESTATUS_MOVIMIENTO = idEstatusMovAplicado
                                                              AND        E.SECUENCIA_PAGOS_ERP = D.SECUENCIA_PAGOS_ERP);
                              END IF; --finaliza cuando las fechas no coinciden pero el aplicado ya existe y se reaperturar?
                          END IF; --FINALIZA else  cuando las fechas de cancelaci?n del egreso erp y aplicaci?n son distintas y el folio aplicado no existe
                      END IF;-- termina if estatus cancelado
                      --Buscar el folio original
                      SELECT /*+ INDEX (E IDX2_PAG_ERP_FOLIO) */ COUNT(*) INTO existeFolio FROM FECXP_ENC_PAGOS_ERP E WHERE FOLIO_SET = to_char(noFolioDet) AND ESTATUS_MOVIMIENTO = idEstatusMov;
                      /* BEGIN
                               SELECT 1
                                 INTO existeFolio
                                 FROM fecxp_enc_pagos_erp e
                                WHERE FOLIO_SET = noFolioDet  AND ESTATUS_MOVIMIENTO =  idEstatusMovAplicado AND ROWNUM = 1;
                       EXCEPTION
                               WHEN NO_DATA_FOUND
                               THEN
                                  existeFolio := 0;
                               WHEN OTHERS
                               THEN
                                  existeFolio := 0;
                        END;*/
                      --DBMS_OUTPUT.PUT_LINE('Se localizaron: ' || existeFolio || ' folios existentes para el folio :' || noFolioDet);
                      IF ( idEstatusMov='X' OR idEstatusMov='Y' OR idEstatusMov='Z') THEN
                          --Para los registros cancelados la fecha flujo debe ser la fecha de cancelaci?n
                                    fecValor := fecModif;
                      END IF;
                      IF (existeFolio=0) THEN
                         --NO EXISTE PREVIAMENTE EL MOVIMIENTO DE EGRESO ERP Y SE GENERAR?? COMO VIENE EN EL SET
                         --Obtenemos la secuencia de la tabla FECXP_ENC_PAGOS_ERP
                       --DBMS_OUTPUT.PUT_LINE('NO EXISTE PREVIAMENTE EL MOVIMIENTO DE EGRESO ERP Y SE GENERAR?? COMO VIENE EN EL SET');
                       --DBMS_OUTPUT.PUT_LINE('    [DATO] Folio: ' || noFolioDet);
                       --DBMS_OUTPUT.PUT_LINE('    [DATO] Status: ' || idEstatusMovAplicado);
                       --DBMS_OUTPUT.PUT_LINE('    [DATO] fecFlujo: ' || fecValor);
                       --DBMS_OUTPUT.PUT_LINE('    [DATO] fecModif: ' || fecModif);
                       utl_file.put_line(fichero,'    [DATO] Folio: ' || noFolioDet);
                       utl_file.put_line(fichero,'    [DATO] Status: ' || idEstatusMovAplicado);
                       utl_file.put_line(fichero,'    [DATO] fecFlujo: ' || fecValor);
                       utl_file.put_line(fichero,'    [DATO] fecModif: ' || fecModif);
                          SELECT SECUENCIA_PAGOS_ERP.NEXTVAL INTO secueciaORAC FROM dual;
                        --DBMS_OUTPUT.PUT_LINE('noFolioDet '||noFolioDet||' secueciaORAC:'||secueciaORAC);
                         REC_T_C1_D_TMP.EXTEND;
                         lin_aux:=lin_aux+1;--bogar
                         ---------------------------------
                         -- Inserta r?plica aplicada en la tabla FECXP_ENC_PAGOS_ERP
                        SELECT                 secueciaORAC        , noEmpresa        , b.SECMONEDA    , noFolioDet          , cPeriodo              , idCveOperacion,
                                               idEstatusMov        , noCheque         , idChequera     , idBanco             , importe               , idFormaPago,
                                               fecValor            , idDivisa         , tipoCambio     , trim(origenMov)     , idTipoOperacion       , nocliente,
                                               idbancobenef        , idchequerabenef  , loteentrada    , nodocto             , concepto              , beneficiario,
                                               SYSDATE             , nomEmpresa       , nomEmpresaRel  , noCuenta            ,  folioRef             , referencia    , descripcion,0
                        INTO REC_T_C1_D_TMP(lin_aux).SECUENCIA_PAGOS_ERP, REC_T_C1_D_TMP(lin_aux).E_CODIGO         , REC_T_C1_D_TMP(lin_aux).SECMONEDA        , REC_T_C1_D_TMP(lin_aux).FOLIO_SET           , REC_T_C1_D_TMP(lin_aux).PERIODO             , REC_T_C1_D_TMP(lin_aux).CVE_OPERACION,
                             REC_T_C1_D_TMP(lin_aux).ESTATUS_MOVIMIENTO , REC_T_C1_D_TMP(lin_aux).NO_CHEQUE        , REC_T_C1_D_TMP(lin_aux).ID_CHEQUERA      , REC_T_C1_D_TMP(lin_aux).ID_BANCO            , REC_T_C1_D_TMP(lin_aux).IMPORTE             , REC_T_C1_D_TMP(lin_aux).FORMA_PAGO   ,
                             REC_T_C1_D_TMP(lin_aux).FECHA_APLICACION   , REC_T_C1_D_TMP(lin_aux).MONEDA           , REC_T_C1_D_TMP(lin_aux).TIPO_CAMBIO      , REC_T_C1_D_TMP(lin_aux).ORIGEN_MOVIMIENTO   , REC_T_C1_D_TMP(lin_aux).TIPO_OPERACION      , REC_T_C1_D_TMP(lin_aux).NO_CLIENTE   ,
                             REC_T_C1_D_TMP(lin_aux).ID_BANCO_BENEF     , REC_T_C1_D_TMP(lin_aux).ID_CHEQUERA_BENEF, REC_T_C1_D_TMP(lin_aux).LOTE_ENTRADA     , REC_T_C1_D_TMP(lin_aux).NO_DOCTO            , REC_T_C1_D_TMP(lin_aux).CONCEPTO            , REC_T_C1_D_TMP(lin_aux).BENEFICIARIO ,
                             REC_T_C1_D_TMP(lin_aux).FECHA_ACTUALIZACION, REC_T_C1_D_TMP(lin_aux).NOM_EMPRESA      , REC_T_C1_D_TMP(lin_aux).NOM_EMPRESA_REL  , REC_T_C1_D_TMP(lin_aux).NO_CUENTA           , REC_T_C1_D_TMP(lin_aux).FOLIO_REF           , REC_T_C1_D_TMP(lin_aux).REFERENCIA   ,
                             REC_T_C1_D_TMP(lin_aux).DESCRIPCION,REC_T_C1_D_TMP(lin_aux).PROCESADO
                        FROM dual a, FECXC_MONEDAS b
                        WHERE b.CODMONEDA = idDivisa;
                      --DBMS_OUTPUT.PUT_LINE('        [INSERT FECXP_ENC_PAGOS_ERP ]: noFolioDet: '||noFolioDet);
                                  numFolioERP := noFolioDet;
                      ELSE --termina if no existe previamente el egreso erp inserta como viene del set
                           --EL EGRESO ERP EXISTE PREVIAMENTE CON ESE FOLIO+STATUS
                           --Se procede como se hac??a originalmente
                           --DBMS_OUTPUT.PUT_LINE('EL EGRESO ERP EXISTE PREVIAMENTE CON ESE FOLIO+STATUS '||noFolioDet ||' + '||idEstatusMov);
                           utl_file.put_line(fichero,'EL EGRESO ERP EXISTE PREVIAMENTE CON ESE FOLIO+STATUS '||noFolioDet ||' + '||idEstatusMov);
                           --Obtenemos la secuencia de la tabla FECXP_ENC_PAGOS_ERP
                           SELECT SECUENCIA_PAGOS_ERP.NEXTVAL INTO secueciaORAC  FROM dual;
                         --DBMS_OUTPUT.PUT_LINE('   [DATO] Folio: ' || noFolioDet);
                         --DBMS_OUTPUT.PUT_LINE('   [DATO] Status: ' || idEstatusMov);
                         --DBMS_OUTPUT.PUT_LINE('   [DATO] fecFlujo: ' || fecValor);
                         --DBMS_OUTPUT.PUT_LINE('   [DATO] fecModif: ' || fecModif);
                           DELETE    FECXP_GASTOS_SET_ERP D
                            WHERE    EXISTS (
                                             SELECT     /*+ INDEX (E IDX_PAG_ERP_FOLIO) */ 1
                                               FROM    FECXP_ENC_PAGOS_ERP E
                                              WHERE    E.E_CODIGO = noEmpresa
                                                AND        E.FOLIO_SET =  to_char(noFolioDet)
                                                AND        E.ESTATUS_MOVIMIENTO =  idEstatusMov
                                                AND        E.SECUENCIA_PAGOS_ERP = D.SECUENCIA_PAGOS_ERP);
                          --DBMS_OUTPUT.PUT_LINE('        [DELETE FECXP_GASTOS_SET_ERP]: ');
                           DELETE    FECXP_DET_PAGOS_PROCESADOS D
                            WHERE    EXISTS (
                                             SELECT    /*+ INDEX (E IDX_PAG_ERP_FOLIO) */ 1
                                               FROM    FECXP_ENC_PAGOS_ERP E
                                              WHERE    E.E_CODIGO = noEmpresa
                                                AND        E.FOLIO_SET =  to_char(noFolioDet)
                                                AND        E.ESTATUS_MOVIMIENTO =  idEstatusMov
                                                AND        E.SECUENCIA_PAGOS_ERP = D.SECUENCIA_PAGOS_ERP);
                         --DBMS_OUTPUT.PUT_LINE('        [DELETE FECXP_DET_PAGOS_PROCESADOS]: ');
                          DELETE    FECXP_DET_PAGOS_ERP D
                           WHERE    EXISTS (
                                            SELECT    /*+ INDEX (E IDX_PAG_ERP_FOLIO) */  1
                                              FROM    FECXP_ENC_PAGOS_ERP E
                                             WHERE    E.E_CODIGO = noEmpresa
                                               AND        E.FOLIO_SET = to_char(noFolioDet)
                                               AND        E.ESTATUS_MOVIMIENTO = idEstatusMov
                                               AND        E.SECUENCIA_PAGOS_ERP = D.SECUENCIA_PAGOS_ERP);
                          --DBMS_OUTPUT.PUT_LINE('        [DELETE FECXP_DET_PAGOS_ERP]: ');
                           DELETE    FECXP_BIT_CONT_DIN_FOLIOS_AP D
                            WHERE    EXISTS (
                                             SELECT    /*+ INDEX (E IDX_PAG_ERP_FOLIO) */  1
                                               FROM    FECXP_ENC_PAGOS_ERP E
                                              WHERE    E.E_CODIGO = noEmpresa
                                                AND        E.FOLIO_SET = to_char(noFolioDet)
                                                AND        E.ESTATUS_MOVIMIENTO = idEstatusMov
                                                AND        E.SECUENCIA_PAGOS_ERP = D.SECUENCIA_PAGOS_ERP);
                          --DBMS_OUTPUT.PUT_LINE('        [DELETE FECXP_BIT_CONT_DIN_FOLIOS_AP]: ');
                           DELETE    FECXP_BIT_CONT_DIN_APER_DET D
                            WHERE    EXISTS (
                                             SELECT    /*+ INDEX (E IDX_PAG_ERP_FOLIO) */ 1
                                               FROM    FECXP_ENC_PAGOS_ERP E
                                              WHERE    E.E_CODIGO = noEmpresa
                                                AND    E.FOLIO_SET = to_char(noFolioDet)
                                                AND    E.ESTATUS_MOVIMIENTO = idEstatusMov
                                                AND    E.SECUENCIA_PAGOS_ERP = D.SECUENCIA_PAGOS_ERP);
                          --DBMS_OUTPUT.PUT_LINE('        [DELETE FECXP_BIT_CONT_DIN_APER_DET]: ');
                           DELETE    FECXP_BIT_CONT_DIN_APER_ENC D
                            WHERE    EXISTS (
                                             SELECT    /*+ INDEX (E IDX_PAG_ERP_FOLIO) */  1
                                               FROM    FECXP_ENC_PAGOS_ERP E
                                              WHERE    E.E_CODIGO = noEmpresa
                                                AND        E.FOLIO_SET = to_char(noFolioDet)
                                                AND        E.ESTATUS_MOVIMIENTO = idEstatusMov
                                                AND        E.SECUENCIA_PAGOS_ERP = D.SECUENCIA_PAGOS_ERP);
                          --DBMS_OUTPUT.PUT_LINE('        [DELETE FECXP_BIT_CONT_DIN_APER_ENC]: ');
                           DELETE    FECXP_ENC_PAGOS_ERP
                            WHERE    E_CODIGO = noEmpresa
                              AND    FOLIO_SET = to_char(noFolioDet)
                              AND    ESTATUS_MOVIMIENTO = idEstatusMov ;
                          --DBMS_OUTPUT.PUT_LINE('        [DELETE FECXP_ENC_PAGOS_ERP]: ->'||secueciaORAC);
                           ---------------------------------
                           --Inserta r?plica aplicada en la tabla FECXP_ENC_PAGOS_ERP
                         REC_T_C1_D_TMP.EXTEND;
                         lin_aux:=lin_aux+1;--bogar
                        SELECT                 secueciaORAC        , noEmpresa        , b.SECMONEDA    , noFolioDet          , cPeriodo              , idCveOperacion,
                                               idEstatusMov        , noCheque         , idChequera     , idBanco             , importe               , idFormaPago,
                                               fecValor            , idDivisa         , tipoCambio     , trim(origenMov)     , idTipoOperacion       , nocliente,
                                               idbancobenef        , idchequerabenef  , loteentrada    , nodocto             , concepto              , beneficiario,
                                               SYSDATE             , nomEmpresa       , nomEmpresaRel  , noCuenta            ,  folioRef             , referencia    , descripcion,0
                        INTO REC_T_C1_D_TMP(lin_aux).SECUENCIA_PAGOS_ERP, REC_T_C1_D_TMP(lin_aux).E_CODIGO         , REC_T_C1_D_TMP(lin_aux).SECMONEDA        , REC_T_C1_D_TMP(lin_aux).FOLIO_SET           , REC_T_C1_D_TMP(lin_aux).PERIODO             , REC_T_C1_D_TMP(lin_aux).CVE_OPERACION,
                             REC_T_C1_D_TMP(lin_aux).ESTATUS_MOVIMIENTO , REC_T_C1_D_TMP(lin_aux).NO_CHEQUE        , REC_T_C1_D_TMP(lin_aux).ID_CHEQUERA      , REC_T_C1_D_TMP(lin_aux).ID_BANCO            , REC_T_C1_D_TMP(lin_aux).IMPORTE             , REC_T_C1_D_TMP(lin_aux).FORMA_PAGO   ,
                             REC_T_C1_D_TMP(lin_aux).FECHA_APLICACION   , REC_T_C1_D_TMP(lin_aux).MONEDA           , REC_T_C1_D_TMP(lin_aux).TIPO_CAMBIO      , REC_T_C1_D_TMP(lin_aux).ORIGEN_MOVIMIENTO   , REC_T_C1_D_TMP(lin_aux).TIPO_OPERACION      , REC_T_C1_D_TMP(lin_aux).NO_CLIENTE   ,
                             REC_T_C1_D_TMP(lin_aux).ID_BANCO_BENEF     , REC_T_C1_D_TMP(lin_aux).ID_CHEQUERA_BENEF, REC_T_C1_D_TMP(lin_aux).LOTE_ENTRADA     , REC_T_C1_D_TMP(lin_aux).NO_DOCTO            , REC_T_C1_D_TMP(lin_aux).CONCEPTO            , REC_T_C1_D_TMP(lin_aux).BENEFICIARIO ,
                             REC_T_C1_D_TMP(lin_aux).FECHA_ACTUALIZACION, REC_T_C1_D_TMP(lin_aux).NOM_EMPRESA      , REC_T_C1_D_TMP(lin_aux).NOM_EMPRESA_REL  , REC_T_C1_D_TMP(lin_aux).NO_CUENTA           , REC_T_C1_D_TMP(lin_aux).FOLIO_REF           , REC_T_C1_D_TMP(lin_aux).REFERENCIA   ,
                             REC_T_C1_D_TMP(lin_aux).DESCRIPCION,REC_T_C1_D_TMP(lin_aux).PROCESADO
                        FROM dual a, FECXC_MONEDAS b
                        WHERE b.CODMONEDA = idDivisa;
                                numFolioERP := noFolioDet;
                      END IF;  --termina else en el que el folio egreso erp ya existe
                  END IF; --termina Verificar si debe generar encabezado o detalle -- finaliza validaci?n para generar encabezado  numfolioERP = nofolioDet
                --DBMS_OUTPUT.PUT_LINE('creoReplica:'||creoReplica||' idEstatusMov'||idEstatusMov||' secueciaORAC:'||secueciaORAC);
                  --GENERA LOS DETALLES
                  IF UPPER(creoReplica)='S' AND ( idEstatusMov='X' OR idEstatusMov='Y' OR idEstatusMov='Z' ) THEN
                     -- Inserta detalle de replica aplicada en la tabla FECXP_DET_PAGOS_ERP
                     -- Obtenemos la secuencia de la tabla FECXP_ENC_PAGOS_ERP
                     --DBMS_OUTPUT.PUT_LINE('          selecciona secuencia  secueciaORACrep->'|| secueciaORACrep);
                     --DBMS_OUTPUT.PUT_LINE('Inserta detalle de replica aplicada en la tabla FECXP_DET_PAGOS_ERP');
                     utl_file.put_line(fichero,'Inserta detalle de replica aplicada en la tabla FECXP_DET_PAGOS_ERP');
                     REC_T_C1_D_DET_TMP.EXTEND;
                     lin_aux2:=lin_aux2+1;--bogar
                     SELECT SECUENCIA_DET_PAGOS_ERP.NEXTVAL,
                            secueciaORACrep,
                            noEmpresa,
                            noPartida,
                            codeCombination,
                            (-1 * importePartida),
                            CIA,
                            NEG,
                            CTA,
                            SCTA,
                            CC,
                            ICIA,
                            TOP
                     INTO REC_T_C1_D_DET_TMP(lin_aux2).SECUENCIA_DET_PAGOS_ERP,
                          REC_T_C1_D_DET_TMP(lin_aux2).SECUENCIA_PAGOS_ERP,
                          REC_T_C1_D_DET_TMP(lin_aux2).E_CODIGO,
                          REC_T_C1_D_DET_TMP(lin_aux2).NUMERO_DE_PARTIDA_ERP,
                          REC_T_C1_D_DET_TMP(lin_aux2).CODE_COMBINATION,
                          REC_T_C1_D_DET_TMP(lin_aux2).IMPORTE_LINEA,
                          REC_T_C1_D_DET_TMP(lin_aux2).ORACLE_SEGMENTO1,
                          REC_T_C1_D_DET_TMP(lin_aux2).ORACLE_SEGMENTO2,
                          REC_T_C1_D_DET_TMP(lin_aux2).ORACLE_SEGMENTO3,
                          REC_T_C1_D_DET_TMP(lin_aux2).ORACLE_SEGMENTO4,
                          REC_T_C1_D_DET_TMP(lin_aux2).ORACLE_SEGMENTO5,
                          REC_T_C1_D_DET_TMP(lin_aux2).ORACLE_SEGMENTO6,
                          REC_T_C1_D_DET_TMP(lin_aux2).ORACLE_SEGMENTO7
                     FROM dual;
                    --            --DBMS_OUTPUT.PUT_LINE('          Termina de insertar en el arreglo');
                  END IF; -- Fin estatus cancelado para detalles
                  --DBMS_OUTPUT.PUT_LINE('          Termina 2do if');
                  --Inserta detalle de r?plica aplicada en la tabla FECXP_DET_PAGOS_ERP
                   REC_T_C1_D_DET_TMP.EXTEND;
                   lin_aux2:=lin_aux2+1;--bogar
                    SELECT SECUENCIA_DET_PAGOS_ERP.NEXTVAL, secueciaORAC, noEmpresa, noPartida, codeCombination, importePartida, CIA, NEG, CTA, SCTA, CC, ICIA, TOP
                    INTO REC_T_C1_D_DET_TMP(lin_aux2).SECUENCIA_DET_PAGOS_ERP, REC_T_C1_D_DET_TMP(lin_aux2).SECUENCIA_PAGOS_ERP, REC_T_C1_D_DET_TMP(lin_aux2).E_CODIGO,
                       REC_T_C1_D_DET_TMP(lin_aux2).NUMERO_DE_PARTIDA_ERP, REC_T_C1_D_DET_TMP(lin_aux2).CODE_COMBINATION, REC_T_C1_D_DET_TMP(lin_aux2).IMPORTE_LINEA,
                       REC_T_C1_D_DET_TMP(lin_aux2).ORACLE_SEGMENTO1, REC_T_C1_D_DET_TMP(lin_aux2).ORACLE_SEGMENTO2, REC_T_C1_D_DET_TMP(lin_aux2).ORACLE_SEGMENTO3,
                       REC_T_C1_D_DET_TMP(lin_aux2).ORACLE_SEGMENTO4, REC_T_C1_D_DET_TMP(lin_aux2).ORACLE_SEGMENTO5, REC_T_C1_D_DET_TMP(lin_aux2).ORACLE_SEGMENTO6,
                       REC_T_C1_D_DET_TMP(lin_aux2).ORACLE_SEGMENTO7
                    FROM DUAL ;
                --DBMS_OUTPUT.PUT_LINE('          Inserta en los arreglos');
            end loop;
            IF REC_T_C1_D_TMP.COUNT != 0 THEN
                FORALL z IN REC_T_C1_D_TMP.FIRST .. REC_T_C1_D_TMP.LAST
                    INSERT INTO FECXP_ENC_PAGOS_ERP
                    VALUES REC_T_C1_D_TMP (z);
                REC_T_C1_D_TMP.delete;
                --commit;
            END IF;
           --DBMS_OUTPUT.PUT_LINE('Insertando DETALLE ');
           --DBMS_OUTPUT.PUT_LINE('DETALLE FIRST'||REC_T_C1_D_DET_TMP.FIRST);
           --DBMS_OUTPUT.PUT_LINE('DETALLE LAST'||REC_T_C1_D_DET_TMP.lAST);
            IF REC_T_C1_D_DET_TMP.COUNT != 0 THEN
                FORALL z IN REC_T_C1_D_DET_TMP.FIRST .. REC_T_C1_D_DET_TMP.LAST
                    INSERT INTO FECXP_DET_PAGOS_ERP
                    VALUES REC_T_C1_D_DET_TMP (z);
                REC_T_C1_D_DET_TMP.delete;
                --commit;
            END IF;
           lin_aux := 0;
           lin_aux2 := 0;
        end if;
        --commit;
    end loop;
    close CURSOR_1;
    --DBMS_OUTPUT.PUT_LINE('          Cerrando el primer cursor');
    utl_file.put_line(fichero,'          Cerrando el primer cursor');
  --DBMS_OUTPUT.PUT_LINE('=== Proces? Egresos ORACLE. Procesando Egresos SOIN ');
  --DBMS_OUTPUT.PUT_LINE('=== Proces? Egresos SOIN. Procesando Ingresos ORACLE ');
  --DBMS_OUTPUT.PUT_LINE('=== Procesando Ingresos ORACLE ');
  --DBMS_OUTPUT.PUT_LINE('[SELECT INGRESOS ORACLE]: ');
  --DBMS_OUTPUT.PUT_LINE('          Abriendo el 2do Cursor');
  utl_file.put_line(fichero,'          Abriendo el 2do Cursor');
    open CURSOR_2;
    loop
        fetch CURSOR_2 bulk collect into t_c2 limit 100;
        c_count := t_c2.count;
      --DBMS_OUTPUT.PUT_LINE('          Contador en el cursor 2: '||c_count);
        EXIT WHEN t_c2.count = 0;
        if c_count > 0 then
            for i in t_c2.first .. t_c2.last
            loop
                  --DBMS_OUTPUT.PUT_LINE('Antes de la asignaci?n');
                  noEmpresa         := t_c2(i).no_empresa;
                  noFolioDet        := t_c2(i).no_folio_det;
                  cPeriodo          := t_c2(i).c_periodo;
                  idCveOperacion    := t_c2(i).id_cve_operacion;
                  idEstatusMov      := UPPER(t_c2(i).id_estatus_mov);
                  noCheque          := t_c2(i).no_cheque;
                  idChequera        := t_c2(i).id_chequera;
                  idBanco           := t_c2(i).id_banco;
                  importe           := t_c2(i).importe;
                  idFormaPago       := t_c2(i).id_forma_pago;
                  fecValor          := t_c2(i).fec_flujo;
                  idDivisa          := t_c2(i).id_divisa;
                  tipoCambio        := t_c2(i).tipo_cambio;
                  origenMov         := t_c2(i).origen_mov;
                  idTipoOperacion   := t_c2(i).id_tipo_operacion;
                  nocliente         := t_c2(i).no_cliente;
                  idbancobenef      := t_c2(i).id_banco_benef;
                  idchequerabenef   := t_c2(i).id_chequera_benef;
                  loteentrada       := t_c2(i).lote_entrada;
                  nodocto           := t_c2(i).no_docto;
                  concepto          := REPLACE (t_c2(i).concepto,CHR(39),' ');
                  beneficiario      := REPLACE (t_c2(i).beneficiario,CHR(39),' ');
                  referencia        := t_c2(i).referencia;
                  descripcion       := t_c2(i).descripcion;
                  fecModif          := t_c2(i).fec_modif;
                  nomEmpresa        := t_c2(i).nom_empresa;
                  noCuenta          := t_c2(i).no_cuenta;
                  folioRef          := t_c2(i).folio_ref;
                  idTipoMovto       := t_c2(i).id_tipo_movto;
                  plataforma        := t_c2(i).plataforma;
                  cPeriodoApli      := t_c2(i).cPeriodoApli;
                  nomEmpresaRel     := t_c2(i).nom_empresa_rel;
                  --DBMS_OUTPUT.PUT_LINE('Despues de la asignaci?n : '||noFolioDet||' :'||idEstatusMov);
                  IF (idEstatusMov='X' OR idEstatusMov='Y' OR idEstatusMov='Z') THEN
                     idEstatusMovAplicado := 'A';
                     IF idTipoOperacion=7000 OR idTipoOperacion=7001 OR idTipoOperacion=7002 OR idTipoOperacion=7003 OR idTipoOperacion=7005
                     THEN
                         idEstatusMovAplicado := 'L';
                     END IF;
                     SELECT COUNT(*) INTO existeFolio FROM FECXC_DEP_ESPECIALES WHERE NO_FOLIO_DET = noFolioDet  AND ID_STATUS_MOV =  idEstatusMovAplicado ;
                     IF TRUNC(fecValor)=TRUNC(fecModif) THEN
                        IF (existeFolio=0) THEN
                            --No existe el folio+status y se generar?
                            --DBMS_OUTPUT.PUT_LINE('Folio cancelado el d?a del origen. Se generar? r?plica FECXC_DEP_ESPECIALES aplicada con Folio: ' || noFolioDet || ' Status: ' || idEstatusMovAplicado || ' TipoOper: ' || idTipoOperacion);
                            --Inserta r?plica aplicada en la tabla FECXC_DEP_ESPECIALES
                            utl_file.put_line(fichero,'Folio cancelado el d?a del origen. Se generar? r?plica FECXC_DEP_ESPECIALES aplicada con Folio: ' || noFolioDet || ' Status: ' || idEstatusMovAplicado || ' TipoOper: ' || idTipoOperacion);
                            --DBMS_OUTPUT.PUT_LINE('   [DATO] Folio: ' || noFolioDet);
                            --DBMS_OUTPUT.PUT_LINE('    [DATO] Status: ' || idEstatusMovAplicado);
                            --DBMS_OUTPUT.PUT_LINE('    [DATO] fecFlujo: ' || fecValor);
                            --DBMS_OUTPUT.PUT_LINE('    [DATO] fecModif: ' || fecModif);
                            utl_file.put_line(fichero,'    [DATO] Folio: ' || noFolioDet);
                            utl_file.put_line(fichero,'    [DATO] Status: ' || idEstatusMovAplicado);
                            utl_file.put_line(fichero,'    [DATO] fecFlujo: ' || fecValor);
                            utl_file.put_line(fichero,'    [DATO] fecModif: ' || fecModif);
                            /*Se limpia la bandera para revisar si se va a marcar el registro para su posterios apertura*/
                            v_aperturar:=1;
                            /*Se revisa si el INGRESO deberia de ser aperturado o no*/
                            IF idTipoOperacion = 3700 OR idTipoOperacion =3701 OR idTipoOperacion =3705 OR idTipoOperacion =3706 OR idTipoOperacion =3708 OR idTipoOperacion =3715 OR idTipoOperacion =4102 OR idTipoOperacion =4103 THEN
                                v_aperturar:=0;
                            END IF;
                            REC_T_C2_D_TMP.EXTEND;
                            lin_aux3 := lin_aux3+1;
                            select noEmpresa         , noFolioDet         , fecValor        , referencia     , idBanco              , idbancobenef            , idChequera,
                                  concepto           , tipoCambio         , (importe*-1)         , noCheque       , idTipoOperacion      , idFormaPago             , idDivisa,
                                  fecValor           ,idEstatusMovAplicado, beneficiario    , descripcion    , nocliente            , SECUENCIA_DEP_ESPECIALES.NEXTVAL,cPeriodoApli,
                                  idCveOperacion     , origenMov          , idchequerabenef , loteentrada    , nodocto              , plataforma              , nomEmpresa,
                                  nomEmpresaRel      , noCuenta           , folioRef        , SYSDATE ,0,  v_aperturar
                            into REC_T_C2_D_TMP(lin_aux3).NO_EMPRESA        , REC_T_C2_D_TMP(lin_aux3).NO_FOLIO_DET     , REC_T_C2_D_TMP(lin_aux3).FEC_VALOR        , REC_T_C2_D_TMP(lin_aux3).REFERENCIA         , REC_T_C2_D_TMP(lin_aux3).ID_BANCO             , REC_T_C2_D_TMP(lin_aux3).ID_BANCO_BENEF          , REC_T_C2_D_TMP(lin_aux3).ID_CHEQUERA,
                                 REC_T_C2_D_TMP(lin_aux3).CONCEPTO          , REC_T_C2_D_TMP(lin_aux3).TIPO_CAMBIO      , REC_T_C2_D_TMP(lin_aux3).IMPORTE          , REC_T_C2_D_TMP(lin_aux3).NO_CHEQUE          , REC_T_C2_D_TMP(lin_aux3).ID_TIPO_OPERACION_SET, REC_T_C2_D_TMP(lin_aux3).ID_FORMA_PAGO           , REC_T_C2_D_TMP(lin_aux3).ID_DIVISA,
                                 REC_T_C2_D_TMP(lin_aux3).FEC_VALOR_ORIGINAL, REC_T_C2_D_TMP(lin_aux3).ID_STATUS_MOV    , REC_T_C2_D_TMP(lin_aux3).BENEFICIARIO     , REC_T_C2_D_TMP(lin_aux3).DESCRIPCION        , REC_T_C2_D_TMP(lin_aux3).NO_CLIENTE           , REC_T_C2_D_TMP(lin_aux3).SECUENCIA_DEP_ESPECIALES, REC_T_C2_D_TMP(lin_aux3).PERIODO,
                                 REC_T_C2_D_TMP(lin_aux3).CVE_OPERACION     , REC_T_C2_D_TMP(lin_aux3).ORIGEN_MOVIMIENTO, REC_T_C2_D_TMP(lin_aux3).ID_CHEQUERA_BENEF, REC_T_C2_D_TMP(lin_aux3).LOTE_ENTRADA       , REC_T_C2_D_TMP(lin_aux3).NO_DOCTO             , REC_T_C2_D_TMP(lin_aux3).PLATAFORMA              , REC_T_C2_D_TMP(lin_aux3).NOM_EMPRESA,
                                 REC_T_C2_D_TMP(lin_aux3).NOM_EMPRESA_REL   , REC_T_C2_D_TMP(lin_aux3).NO_CUENTA        , REC_T_C2_D_TMP(lin_aux3).FOLIO_REF        , REC_T_C2_D_TMP(lin_aux3).FECHA_ACTUALIZACION, REC_T_C2_D_TMP(lin_aux3).PROCESADO,REC_T_C2_D_TMP(lin_aux3).aperturadoar
                           from dual;
                        ELSE
                            --YA EXISTE EL FOLIO+STATUS+TIPOOPER EN ESTE CASO SE MANDAR?N LOS DATOS AL LOG DE JAGUAR
                            --DEBIDO A QUE EL MOVIMIENTO NO DEBER?A EXISTIR PREVIAMENTE, PUES EN EL SET NACE Y SE
                            --CANCELA EL MISMO D?A.
                            --Si el folio aplicado ya existe y se gener? un cancelado se tiene que forzar la obtenci?n de cuentas
                            --Forzar al reprocesamiento
                            utl_file.put_line(fichero,'YA EXISTE EL FOLIO+STATUS+TIPOOPER EN ESTE CASO SE MANDAR?N LOS DATOS AL LOG DE JAGUAR');
                            utl_file.put_line(fichero,'Forzar al reprocesamiento');
                            UPDATE    FECXC_DEP_ESPECIALES
                               SET    PROCESADO = 0
                             WHERE    NO_FOLIO_DET = noFolioDet
                               AND    ID_STATUS_MOV = idEstatusMovAplicado;
                          --DBMS_OUTPUT.PUT_LINE('        [REAPERTURA INGRESOS]: ');
                            DELETE    /*+ INDEX (D IDX_FECXC_DEP_ESP_D00) */
                                      FECXC_DEP_ESPECIALES_D D
                             WHERE    EXISTS (
                                              SELECT    1
                                                FROM    FECXC_DEP_ESPECIALES E
                                               WHERE    E.NO_FOLIO_DET = noFolioDet
                                                 AND    E.SECUENCIA_DEP_ESPECIALES = D.SECUENCIA_DEP_ESPECIALES );
                            DELETE    FECXP_BIT_INGR_CC D
                            WHERE    EXISTS (
                                              SELECT    1
                                                FROM    FECXC_DEP_ESPECIALES E
                                               WHERE    E.NO_FOLIO_DET = noFolioDet
                                               AND     E.SECUENCIA_DEP_ESPECIALES = D.SECUENCIA_DEP_ESPECIALES );
                            DELETE    FECXP_BIT_INGR_MISC D
                            WHERE    EXISTS (
                                             SELECT    1
                                               FROM    FECXC_DEP_ESPECIALES E
                                              WHERE    E.NO_FOLIO_DET = noFolioDet
                                               AND     E.SECUENCIA_DEP_ESPECIALES = D.SECUENCIA_DEP_ESPECIALES );
                             DELETE    FECXP_MISC_REPE D
                              WHERE    D.NO_FOLIO_DET = noFolioDet;
                             DELETE    FECXP_FACT_VAR D
                              WHERE    D.NO_FOLIO_DET = noFolioDet;
                             DELETE    FECXP_BIT_INGR_FACT D
                              WHERE    EXISTS (
                                               SELECT    1
                                                 FROM    FECXC_DEP_ESPECIALES E
                                                WHERE    E.NO_FOLIO_DET =  noFolioDet
                                                  AND     E.SECUENCIA_DEP_ESPECIALES = D.SECUENCIA_DEP_ESPECIALES );
                        END IF ; --fin else cuando el folio aplicado de ingreso ya existe
                     ELSE --Finaliza if fecvalor = fecmodif
                          --Si la fecha de cancelaci?n no es la de generaci?n validar que ya existe el registro aplicado
                         IF (existeFolio=0) THEN
                             --NO EXISTE EL FOLIO+STATUS Y SE GENERAR? CON LOS NUEVOS DATOS
                            --DBMS_OUTPUT.PUT_LINE('Se cancel? en fecha distinta al origen y no existe el aplicado. Se generar? r?plica fecxc_dep_especiales aplicada con Folio: ' || noFolioDet || ' Status: ' || idEstatusMovAplicado || ' TipoOper: ' || idTipoOperacion);
                            --DBMS_OUTPUT.PUT_LINE(' La fecha de modificaci?n y aplicaci?n no son iguales.');
                             -- Inserta r?plica aplicada en la tabla FECXC_DEP_ESPECIALES
                               utl_file.put_line(fichero,'Se cancel? en fecha distinta al origen y no existe el aplicado. Se generar? r?plica fecxc_dep_especiales aplicada con Folio: ' || noFolioDet || ' Status: ' || idEstatusMovAplicado || ' TipoOper: ' || idTipoOperacion);
                               utl_file.put_line(fichero,'Inserta r?plica aplicada en la tabla FECXC_DEP_ESPECIALES');
                               --DBMS_OUTPUT.PUT_LINE('    [DATO] Folio: ' || noFolioDet);
                               --DBMS_OUTPUT.PUT_LINE('    [DATO] Status: ' || idEstatusMovAplicado);
                               --DBMS_OUTPUT.PUT_LINE('    [DATO] fecFlujo: ' || fecValor);
                               --DBMS_OUTPUT.PUT_LINE('    [DATO] fecModif: ' || fecModif);
                               utl_file.put_line(fichero,'    [DATO] Folio: ' || noFolioDet);
                               utl_file.put_line(fichero,'    [DATO] Status: ' || idEstatusMovAplicado);
                               utl_file.put_line(fichero,'    [DATO] fecFlujo: ' || fecValor);
                               utl_file.put_line(fichero,'    [DATO] fecModif: ' || fecModif);
                            /*Se limpia la bandera para revisar si se va a marcar el registro para su posterios apertura*/
                            v_aperturar:=1;
                            /*Se revisa si el INGRESO deberia de ser aperturado o no*/
                            IF idTipoOperacion = 3700 OR idTipoOperacion =3701 OR idTipoOperacion =3705 OR idTipoOperacion =3706 OR idTipoOperacion =3708 OR idTipoOperacion =3715 OR idTipoOperacion =4102 OR idTipoOperacion =4103 THEN
                                v_aperturar:=0;
                            END IF;
                              REC_T_C2_D_TMP.EXTEND;
                              lin_aux3 := lin_aux3+1;
                             select noEmpresa    , noFolioDet                      ,fecValor    , referencia          , idBanco    , idbancobenef,
                                    idChequera   , concepto                        , tipoCambio , (importe*-1)             ,noCheque    , idTipoOperacion,
                                    idFormaPago  , idDivisa                        ,fecValor    , idEstatusMovAplicado,beneficiario, descripcion,
                                    nocliente    , SECUENCIA_DEP_ESPECIALES.NEXTVAL,cPeriodoApli,idCveOperacion,TRIM(origenMov)    , idchequerabenef,
                                    loteentrada  , nodocto                         ,plataforma  ,nomEmpresa     , nomEmpresaRel    , noCuenta,
                                    folioRef     ,SYSDATE,0,v_aperturar
                             into REC_T_C2_D_TMP(lin_aux3).NO_EMPRESA   , REC_T_C2_D_TMP(lin_aux3).NO_FOLIO_DET            , REC_T_C2_D_TMP(lin_aux3).FEC_VALOR         , REC_T_C2_D_TMP(lin_aux3).REFERENCIA   , REC_T_C2_D_TMP(lin_aux3).ID_BANCO         , REC_T_C2_D_TMP(lin_aux3).ID_BANCO_BENEF,
                                  REC_T_C2_D_TMP(lin_aux3).ID_CHEQUERA  , REC_T_C2_D_TMP(lin_aux3).CONCEPTO                , REC_T_C2_D_TMP(lin_aux3).TIPO_CAMBIO       , REC_T_C2_D_TMP(lin_aux3).IMPORTE      , REC_T_C2_D_TMP(lin_aux3).NO_CHEQUE        , REC_T_C2_D_TMP(lin_aux3).ID_TIPO_OPERACION_SET,
                                  REC_T_C2_D_TMP(lin_aux3).ID_FORMA_PAGO, REC_T_C2_D_TMP(lin_aux3).ID_DIVISA               , REC_T_C2_D_TMP(lin_aux3).FEC_VALOR_ORIGINAL, REC_T_C2_D_TMP(lin_aux3).ID_STATUS_MOV, REC_T_C2_D_TMP(lin_aux3).BENEFICIARIO     , REC_T_C2_D_TMP(lin_aux3).DESCRIPCION,
                                  REC_T_C2_D_TMP(lin_aux3).NO_CLIENTE   , REC_T_C2_D_TMP(lin_aux3).SECUENCIA_DEP_ESPECIALES, REC_T_C2_D_TMP(lin_aux3).PERIODO           , REC_T_C2_D_TMP(lin_aux3).CVE_OPERACION, REC_T_C2_D_TMP(lin_aux3).ORIGEN_MOVIMIENTO, REC_T_C2_D_TMP(lin_aux3).ID_CHEQUERA_BENEF,
                                  REC_T_C2_D_TMP(lin_aux3).LOTE_ENTRADA , REC_T_C2_D_TMP(lin_aux3).NO_DOCTO                , REC_T_C2_D_TMP(lin_aux3).PLATAFORMA        , REC_T_C2_D_TMP(lin_aux3).NOM_EMPRESA  , REC_T_C2_D_TMP(lin_aux3).NOM_EMPRESA_REL  , REC_T_C2_D_TMP(lin_aux3).NO_CUENTA,
                                  REC_T_C2_D_TMP(lin_aux3).FOLIO_REF    , REC_T_C2_D_TMP(lin_aux3).FECHA_ACTUALIZACION     , REC_T_C2_D_TMP(lin_aux3).PROCESADO         , REC_T_C2_D_TMP(lin_aux3).APERTURADOAR
                             from dual;
                             --DBMS_OUTPUT.PUT_LINE('        [INSERT FECXC_DEP_ESPECIALES]: ');
                         END IF;--finaliza if cuando el folio aplicado no existe y las fechas de cancelaci?n y aplicaci?n no coinciden
                     END IF;--FINALIZA else  cuando las fechas de cancelaci?n del ingreso erp y aplicaci?n son distintas y el folio aplicado no existe
                  END IF;--Finaliza if de status cancelados
                  --UNA VEZ QUE SE GENER? LA R?PLICA APLICADA PARA LOS INGRESOS ERP CANCELADOS SE INSERTAR? EL INGRESO ERP LEIDO
                  --TAL Y COMO VIENE (CANCELADO O BIEN APLICADO SI NUNCA ENTR? AL IF ANTERIOR)
                  --SE VALIDAR? QUE LA COMBINACI?N FOLIO+STATUS NO EXISTA, SI EXISTE SE procede como se hac?a originalmente
                  --Buscar el folio con estatus aplicado en la base de datos, esto para las validaciones en caso de que la
                  --cancelaci?n se haga o no el d?a de la generaci?n.
                  SELECT COUNT(*) INTO existeFolio FROM FECXC_DEP_ESPECIALES WHERE NO_FOLIO_DET = noFolioDet AND ID_STATUS_MOV =idEstatusMov ;
                   IF (idEstatusMov='X' OR idEstatusMov='Y' OR idEstatusMov='Z') THEN
                   fecValor := fecModif;
                   END IF;
                   --DBMS_OUTPUT.PUT_LINE(' Paso 2 existe folio->'||existeFolio);
                   IF existeFolio=0 THEN
                       --NO EXISTE PREVIAMENTE EL MOVIMIENTO DE INGRESO ERP Y SE GENERAR? COMO VIENE EN EL SET
                       --DBMS_OUTPUT.PUT_LINE('    [DATO] Folio: ' || noFolioDet);
                       --DBMS_OUTPUT.PUT_LINE('    [DATO] Status: ' || idEstatusMov);
                       --DBMS_OUTPUT.PUT_LINE('    [DATO] fecFlujo: ' || fecValor);
                       --DBMS_OUTPUT.PUT_LINE('    [DATO] fecModif: ' || fecModif);
                       utl_file.put_line(fichero,'NO EXISTE PREVIAMENTE EL MOVIMIENTO DE INGRESO ERP Y SE GENERAR? COMO VIENE EN EL SET');
                       utl_file.put_line(fichero,'    [DATO] Folio: ' || noFolioDet);
                       utl_file.put_line(fichero,'    [DATO] Status: ' || idEstatusMov);
                       utl_file.put_line(fichero,'    [DATO] fecFlujo: ' || fecValor);
                       utl_file.put_line(fichero,'    [DATO] fecModif: ' || fecModif);
                       /*Se limpia la bandera para revisar si se va a marcar el registro para su posterios apertura*/
                       v_aperturar:=1;
                       /*Se revisa si el INGRESO deberia de ser aperturado o no*/
                        IF idTipoOperacion = 3700 OR idTipoOperacion =3701 OR idTipoOperacion =3705 OR idTipoOperacion =3706 OR idTipoOperacion =3708 OR idTipoOperacion =3715 OR idTipoOperacion =4102 OR idTipoOperacion =4103 THEN
                                v_aperturar:=0;
                        END IF;
                       REC_T_C2_D_TMP.EXTEND;
                       lin_aux3 := lin_aux3+1;
                       select noEmpresa    , noFolioDet    , fecValor, referencia   , idBanco          , idbancobenef,
                             idChequera   , concepto                , tipoCambio        , importe      , noCheque         , idTipoOperacion,
                             idFormaPago  , idDivisa      ,  fecValor, idEstatusMov , beneficiario     , descripcion,
                             nocliente,SECUENCIA_DEP_ESPECIALES.NEXTVAL,cPeriodo        ,idCveOperacion, origenMov  , idchequerabenef,
                             loteentrada  , nodocto       , plataforma                  , nomEmpresa   , nomEmpresaRel    , noCuenta,
                             folioRef     , SYSDATE,0,v_aperturar
                       into REC_T_C2_D_TMP(lin_aux3).NO_EMPRESA   , REC_T_C2_D_TMP(lin_aux3).NO_FOLIO_DET            , REC_T_C2_D_TMP(lin_aux3).FEC_VALOR         , REC_T_C2_D_TMP(lin_aux3).REFERENCIA   , REC_T_C2_D_TMP(lin_aux3).ID_BANCO         , REC_T_C2_D_TMP(lin_aux3).ID_BANCO_BENEF,
                             REC_T_C2_D_TMP(lin_aux3).ID_CHEQUERA  , REC_T_C2_D_TMP(lin_aux3).CONCEPTO                , REC_T_C2_D_TMP(lin_aux3).TIPO_CAMBIO       , REC_T_C2_D_TMP(lin_aux3).IMPORTE      , REC_T_C2_D_TMP(lin_aux3).NO_CHEQUE        , REC_T_C2_D_TMP(lin_aux3).ID_TIPO_OPERACION_SET,
                             REC_T_C2_D_TMP(lin_aux3).ID_FORMA_PAGO, REC_T_C2_D_TMP(lin_aux3).ID_DIVISA               , REC_T_C2_D_TMP(lin_aux3).FEC_VALOR_ORIGINAL, REC_T_C2_D_TMP(lin_aux3).ID_STATUS_MOV, REC_T_C2_D_TMP(lin_aux3).BENEFICIARIO     , REC_T_C2_D_TMP(lin_aux3).DESCRIPCION,
                             REC_T_C2_D_TMP(lin_aux3).NO_CLIENTE   , REC_T_C2_D_TMP(lin_aux3).SECUENCIA_DEP_ESPECIALES, REC_T_C2_D_TMP(lin_aux3).PERIODO           , REC_T_C2_D_TMP(lin_aux3).CVE_OPERACION, REC_T_C2_D_TMP(lin_aux3).ORIGEN_MOVIMIENTO, REC_T_C2_D_TMP(lin_aux3).ID_CHEQUERA_BENEF,
                             REC_T_C2_D_TMP(lin_aux3).LOTE_ENTRADA , REC_T_C2_D_TMP(lin_aux3).NO_DOCTO                , REC_T_C2_D_TMP(lin_aux3).PLATAFORMA        , REC_T_C2_D_TMP(lin_aux3).NOM_EMPRESA  , REC_T_C2_D_TMP(lin_aux3).NOM_EMPRESA_REL  , REC_T_C2_D_TMP(lin_aux3).NO_CUENTA,
                             REC_T_C2_D_TMP(lin_aux3).FOLIO_REF    , REC_T_C2_D_TMP(lin_aux3).FECHA_ACTUALIZACION     , REC_T_C2_D_TMP(lin_aux3).PROCESADO         , REC_T_C2_D_TMP(lin_aux3).APERTURADOAR
                       from dual;
                   ELSE--termina if no existe previamente el INGRESO erp inserta como viene del set
                        --EL INGRESO ERP EXISTE PREVIAMENTE CON ESE FOLIO+STATUS
                        --Se procede como se hac?a orignalmente
                       --DBMS_OUTPUT.PUT_LINE('    [DATO] Folio: ' || noFolioDet);
                       --DBMS_OUTPUT.PUT_LINE('    [DATO] Status: ' || idEstatusMov);
                       --DBMS_OUTPUT.PUT_LINE('    [DATO] fecFlujo: ' || fecValor);
                       --DBMS_OUTPUT.PUT_LINE('    [DATO] fecModif: ' || fecModif);
                       utl_file.put_line(fichero,'EL INGRESO ERP EXISTE PREVIAMENTE CON ESE FOLIO+STATUS');
                       utl_file.put_line(fichero,'    [DATO] Folio: ' || noFolioDet);
                       utl_file.put_line(fichero,'    [DATO] Status: ' || idEstatusMov);
                       utl_file.put_line(fichero,'    [DATO] fecFlujo: ' || fecValor);
                       utl_file.put_line(fichero,'    [DATO] fecModif: ' || fecModif);
                       utl_file.put_line(fichero,'forzar la reapertura');
                      --primero forzar la reapertura
                      --Borrar las cuentas actuales
                           DELETE   /*+ INDEX (D IDX_FECXC_DEP_ESP_D00) */
                                    FECXC_DEP_ESPECIALES_D D
                           WHERE    EXISTS (
                                            SELECT    1
                                              FROM    FECXC_DEP_ESPECIALES E
                                             WHERE    E.NO_FOLIO_DET = noFolioDet
                                               AND     E.SECUENCIA_DEP_ESPECIALES = D.SECUENCIA_DEP_ESPECIALES );
                          DELETE    FECXP_BIT_INGR_CC D
                           WHERE    EXISTS (
                                            SELECT    1
                                              FROM    FECXC_DEP_ESPECIALES E
                                             WHERE    E.NO_FOLIO_DET =noFolioDet
                                               AND     E.SECUENCIA_DEP_ESPECIALES = D.SECUENCIA_DEP_ESPECIALES );
                          DELETE    FECXP_BIT_INGR_MISC D
                           WHERE    EXISTS (
                                             SELECT    1
                                               FROM
                                               FECXC_DEP_ESPECIALES E
                                              WHERE    E.NO_FOLIO_DET = noFolioDet
                                                AND    E.SECUENCIA_DEP_ESPECIALES = D.SECUENCIA_DEP_ESPECIALES );
                          DELETE    FECXP_MISC_REPE D
                           WHERE    D.NO_FOLIO_DET = noFolioDet;
                          DELETE    FECXP_FACT_VAR D
                           WHERE    D.NO_FOLIO_DET = noFolioDet;
                          DELETE    FECXP_BIT_INGR_FACT D
                           WHERE    EXISTS (
                                            SELECT    1
                                              FROM    FECXC_DEP_ESPECIALES E
                                             WHERE    E.NO_FOLIO_DET = noFolioDet
                                              AND     E.SECUENCIA_DEP_ESPECIALES = D.SECUENCIA_DEP_ESPECIALES );
                          DELETE    /*+ INDEX (D IDX_FECXC_DEP_ESP_D00) */
                                    FECXC_DEP_ESPECIALES_D D
                           WHERE    EXISTS (
                                             SELECT    1
                                               FROM    FECXC_DEP_ESPECIALES E
                                              WHERE    E.NO_EMPRESA =  noEmpresa
                                                AND        E.NO_FOLIO_DET = noFolioDet
                                                AND        E.ID_STATUS_MOV =  idEstatusMov
                                                AND        E.SECUENCIA_DEP_ESPECIALES = D.SECUENCIA_DEP_ESPECIALES);
                          DELETE    FECXC_DEP_ESPECIALES
                          WHERE    NO_EMPRESA = noEmpresa
                          AND        NO_FOLIO_DET = noFolioDet
                          AND        ID_STATUS_MOV = idEstatusMov;
                          /*Se limpia la bandera para revisar si se va a marcar el registro para su posterios apertura*/
                          v_aperturar:=1;
                         /*Se revisa si el INGRESO deberia de ser aperturado o no*/
                          IF idTipoOperacion = 3700 OR idTipoOperacion =3701 OR idTipoOperacion =3705 OR idTipoOperacion =3706 OR idTipoOperacion =3708 OR idTipoOperacion =3715 OR idTipoOperacion =4102 OR idTipoOperacion =4103 THEN
                                 v_aperturar:=0;
                          END IF;
                          REC_T_C2_D_TMP.EXTEND;
                          lin_aux3 := lin_aux3+1;
                          select noEmpresa    , noFolioDet    , fecValor, referencia   , idBanco          , idbancobenef,
                                                            idChequera   , concepto                , tipoCambio        , importe      , noCheque         , idTipoOperacion,
                                                            idFormaPago  , idDivisa      , fecValor, idEstatusMov , beneficiario     , descripcion,
                                                            nocliente,SECUENCIA_DEP_ESPECIALES.NEXTVAL,cPeriodo        ,idCveOperacion, origenMov  , idchequerabenef,
                                                            loteentrada  , nodocto       , plataforma                  , nomEmpresa   , nomEmpresaRel    , noCuenta,
                                                            folioRef     , SYSDATE,0,v_aperturar
                          into    REC_T_C2_D_TMP(lin_aux3).NO_EMPRESA   , REC_T_C2_D_TMP(lin_aux3).NO_FOLIO_DET            , REC_T_C2_D_TMP(lin_aux3).FEC_VALOR         , REC_T_C2_D_TMP(lin_aux3).REFERENCIA   , REC_T_C2_D_TMP(lin_aux3).ID_BANCO         , REC_T_C2_D_TMP(lin_aux3).ID_BANCO_BENEF,
                                                            REC_T_C2_D_TMP(lin_aux3).ID_CHEQUERA  , REC_T_C2_D_TMP(lin_aux3).CONCEPTO                , REC_T_C2_D_TMP(lin_aux3).TIPO_CAMBIO       , REC_T_C2_D_TMP(lin_aux3).IMPORTE      , REC_T_C2_D_TMP(lin_aux3).NO_CHEQUE        , REC_T_C2_D_TMP(lin_aux3).ID_TIPO_OPERACION_SET,
                                                            REC_T_C2_D_TMP(lin_aux3).ID_FORMA_PAGO, REC_T_C2_D_TMP(lin_aux3).ID_DIVISA               , REC_T_C2_D_TMP(lin_aux3).FEC_VALOR_ORIGINAL, REC_T_C2_D_TMP(lin_aux3).ID_STATUS_MOV, REC_T_C2_D_TMP(lin_aux3).BENEFICIARIO     , REC_T_C2_D_TMP(lin_aux3).DESCRIPCION,
                                                            REC_T_C2_D_TMP(lin_aux3).NO_CLIENTE   , REC_T_C2_D_TMP(lin_aux3).SECUENCIA_DEP_ESPECIALES, REC_T_C2_D_TMP(lin_aux3).PERIODO           , REC_T_C2_D_TMP(lin_aux3).CVE_OPERACION, REC_T_C2_D_TMP(lin_aux3).ORIGEN_MOVIMIENTO, REC_T_C2_D_TMP(lin_aux3).ID_CHEQUERA_BENEF,
                                                            REC_T_C2_D_TMP(lin_aux3).LOTE_ENTRADA , REC_T_C2_D_TMP(lin_aux3).NO_DOCTO                , REC_T_C2_D_TMP(lin_aux3).PLATAFORMA        , REC_T_C2_D_TMP(lin_aux3).NOM_EMPRESA  , REC_T_C2_D_TMP(lin_aux3).NOM_EMPRESA_REL  , REC_T_C2_D_TMP(lin_aux3).NO_CUENTA,
                                                            REC_T_C2_D_TMP(lin_aux3).FOLIO_REF    , REC_T_C2_D_TMP(lin_aux3).FECHA_ACTUALIZACION     , REC_T_C2_D_TMP(lin_aux3).PROCESADO         , REC_T_C2_D_TMP(lin_aux3).APERTURADOAR
                          from dual;
                   END IF;  --termina else en el que el folio ingreso erp ya existe
            end loop;
            IF REC_T_C2_D_TMP.COUNT != 0 THEN
                FORALL z IN REC_T_C2_D_TMP.FIRST .. REC_T_C2_D_TMP.LAST
                    INSERT INTO FECXC_DEP_ESPECIALES
                    VALUES REC_T_C2_D_TMP (z);
                REC_T_C2_D_TMP.delete;
                --commit;
            END IF;
            lin_aux3 := 0;
        end if;
    end loop;
      close CURSOR_2;
    --DBMS_OUTPUT.PUT_LINE('          Cerrando el 2do Cursor');
     utl_file.put_line(fichero, '          Cerrando el 2do Cursor');
    --DBMS_OUTPUT.PUT_LINE('=== Proces? Ingresos ORACLE. Procesando Ingresos SBC ORACLE ');
    --DBMS_OUTPUT.PUT_LINE('          Abriendo el 3er Cursor');
    utl_file.put_line(fichero,'          Abriendo el 3er Cursor');
    open CURSOR_3;
      loop
        fetch CURSOR_3 bulk collect into t_c3 limit 100;
        c_count := t_c3.count;
        --DBMS_OUTPUT.PUT_LINE('          Contador en el cursor 3: '||c_count);
        EXIT WHEN t_c3.count = 0;
        if c_count > 0 then
            for i in t_c3.first .. t_c3.last
            loop
              --DBMS_OUTPUT.PUT_LINE('          Iniciando el 3er Cursor');
                  noEmpresa         := t_c3(i).no_empresa;
                  noFolioDet        := t_c3(i).no_folio_det;
                  cPeriodo          := t_c3(i).c_periodo;
                  idCveOperacion    := t_c3(i).id_cve_operacion;
                  idEstatusMov      := UPPER(t_c3(i).id_estatus_mov);
                  noCheque          := t_c3(i).no_cheque;
                  idChequera        := t_c3(i).id_chequera;
                  idBanco           := t_c3(i).id_banco;
                  importe           := t_c3(i).importe;
                  idFormaPago       := t_c3(i).id_forma_pago;
                  fecValor          := t_c3(i).fec_flujo;
                  idDivisa          := t_c3(i).id_divisa;
                  tipoCambio        := t_c3(i).tipo_cambio;
                  origenMov         := t_c3(i).origen_mov;
                  idTipoOperacion   := t_c3(i).id_tipo_operacion;
                  nocliente         := t_c3(i).no_cliente;
                  idbancobenef      := t_c3(i).id_banco_benef;
                  idchequerabenef   := t_c3(i).id_chequera_benef;
                  loteentrada       := t_c3(i).lote_entrada;
                  nodocto           := t_c3(i).no_docto;
                  concepto          := REPLACE (t_c3(i).concepto,CHR(39),' ');
                  beneficiario      := REPLACE (t_c3(i).beneficiario,CHR(39),' ');
                  referencia        := t_c3(i).referencia;
                  descripcion       := t_c3(i).descripcion;
                  fecModif          := t_c3(i).fec_modif;
                  nomEmpresa        := t_c3(i).nom_empresa;
                  noCuenta          := t_c3(i).no_cuenta;
                  folioRef          := t_c3(i).folio_ref;
                  idTipoMovto       := t_c3(i).id_tipo_movto;
                  plataforma        := t_c3(i).plataforma;
                  cPeriodoApli      := t_c3(i).cPeriodoApli;
                  nomEmpresaRel     := t_c3(i).nom_empresa_rel;
                --DBMS_OUTPUT.PUT_LINE('Procesando folio '||noFolioDet||' noEmpresa '||noEmpresa);
                  IF (idEstatusMov='X' OR idEstatusMov='Y' OR idEstatusMov='Z') THEN
                   --DBMS_OUTPUT.PUT_LINE('[El folio ' || noFolioDet || ' ] est? cancelado y ha entrado a l?gica SBC cancelados] Status: ' || idEstatusMov || '');
                     utl_file.put_line(fichero,'[El folio ' || noFolioDet || ' ] est? cancelado y ha entrado a l?gica SBC cancelados] Status: ' || idEstatusMov || '');
                     existeFolioCanc := 0;
                     SELECT COUNT(*) INTO existeFolioCanc FROM FECXC_DEP_ESPECIALES WHERE NO_FOLIO_DET = noFolioDet AND ID_STATUS_MOV = idEstatusMov ;
                   --DBMS_OUTPUT.PUT_LINE('[Se han localizado]: ' || existeFolioCanc || ' folios SBC con estatus cancelado.');
                     utl_file.put_line(fichero,'[Se han localizado]: ' || existeFolioCanc || ' folios SBC con estatus cancelado.');
                     IF (existeFolioCanc=0)THEN
                        --Cuando no exista previamente el cancelado proceder normalmente
                        idEstatusMovAplicado := 'A';
                       --DBMS_OUTPUT.PUT_LINE('[No existe previamente el cancelado, el Status aplicado es]: ' || idEstatusMovAplicado || '');
                        utl_file.put_line(fichero,'[No existe previamente el cancelado, el Status aplicado es]: ' || idEstatusMovAplicado || '');
                        existeFolio := 0;
                        SELECT COUNT(*) INTO  existeFolio FROM FECXC_DEP_ESPECIALES WHERE NO_FOLIO_DET =  noFolioDet  AND ID_STATUS_MOV = idEstatusMovAplicado ;
                       --DBMS_OUTPUT.PUT_LINE('[Se han localizado]: ' || existeFolio || ' folios con estatus aplicado.');
                        --Si no existe como aplicado verificar si existe como pendiente
                           IF (existeFolio=0)THEN
                              idEstatusMovAplicado := 'P';
                             --DBMS_OUTPUT.PUT_LINE('[El Status pendiente es]: ' || idEstatusMovAplicado || '');
                              utl_file.put_line(fichero,'[El Status pendiente es]: ' || idEstatusMovAplicado || '');
                              SELECT COUNT(*) INTO existeFolio FROM FECXC_DEP_ESPECIALES WHERE NO_FOLIO_DET = noFolioDet AND ID_STATUS_MOV = idEstatusMovAplicado;
                             --DBMS_OUTPUT.PUT_LINE('[Se han localizado]: ' || existeFolio || ' folios con estatus pendiente.');
                              utl_file.put_line(fichero,'[Se han localizado]: ' || existeFolio || ' folios con estatus pendiente.');
                           END IF;
                              --Si no existe ninguna r?plica SBC crearla
                           IF (existeFolio=0)THEN
                              --Crear la r?plica Aplicada del folio cancelado
                              idEstatusMovAplicado := 'A';
                             --DBMS_OUTPUT.PUT_LINE('Folio SBC cancelado. Se generar? r?plica FECXC_DEP_ESPECIALES aplicada con Folio: ' || noFolioDet || ' Status: ' || idEstatusMovAplicado || ' TipoOper: ' || idTipoOperacion);
                             utl_file.put_line(fichero,'Folio SBC cancelado. Se generar? r?plica FECXC_DEP_ESPECIALES aplicada con Folio: ' || noFolioDet || ' Status: ' || idEstatusMovAplicado || ' TipoOper: ' || idTipoOperacion);
                              --No existe el folio+status y se generar?
                               --DBMS_OUTPUT.PUT_LINE('    [DATO] Folio SBC: ' || noFolioDet);
                               --DBMS_OUTPUT.PUT_LINE('    [DATO] Status: ' || idEstatusMovAplicado);
                               --DBMS_OUTPUT.PUT_LINE('    [DATO] fecFlujo: ' || fecValor);
                               --DBMS_OUTPUT.PUT_LINE('    [DATO] fecModif: ' || fecModif);
                               utl_file.put_line(fichero,'    [DATO] Folio SBC: ' || noFolioDet);
                               utl_file.put_line(fichero,'    [DATO] Status: ' || idEstatusMovAplicado);
                               utl_file.put_line(fichero,'    [DATO] fecFlujo: ' || fecValor);
                               utl_file.put_line(fichero,'    [DATO] fecModif: ' || fecModif);
                              --Inserta r?plica aplicada en la tabla FECXC_DEP_ESPECIALES
                             REC_T_C3_D_TMP.EXTEND;
                             lin_aux4 := lin_aux4+1;
                            select noEmpresa    , noFolioDet    , fecValor, referencia   , idBanco          , idbancobenef,
                                                                idChequera   , concepto                , tipoCambio        , (importe*-1), noCheque   ,idTipoOperacion,
                                                                idFormaPago  , idDivisa      , fecValor, idEstatusMovAplicado,beneficiario     , descripcion,
                                                                nocliente,SECUENCIA_DEP_ESPECIALES.NEXTVAL,cPeriodoApli    ,idCveOperacion, origenMov  , idchequerabenef,
                                                                loteentrada  , nodocto       , plataforma                  , nomEmpresa   , nomEmpresaRel    , noCuenta,
                                                                folioRef     , SYSDATE,0
                            into REC_T_C3_D_TMP(lin_aux4).NO_EMPRESA   , REC_T_C3_D_TMP(lin_aux4).NO_FOLIO_DET            , REC_T_C3_D_TMP(lin_aux4).FEC_VALOR         , REC_T_C3_D_TMP(lin_aux4).REFERENCIA   , REC_T_C3_D_TMP(lin_aux4).ID_BANCO         , REC_T_C3_D_TMP(lin_aux4).ID_BANCO_BENEF,
                                                                REC_T_C3_D_TMP(lin_aux4).ID_CHEQUERA  , REC_T_C3_D_TMP(lin_aux4).CONCEPTO                , REC_T_C3_D_TMP(lin_aux4).TIPO_CAMBIO       , REC_T_C3_D_TMP(lin_aux4).IMPORTE      , REC_T_C3_D_TMP(lin_aux4).NO_CHEQUE        , REC_T_C3_D_TMP(lin_aux4).ID_TIPO_OPERACION_SET,
                                                                REC_T_C3_D_TMP(lin_aux4).ID_FORMA_PAGO, REC_T_C3_D_TMP(lin_aux4).ID_DIVISA               , REC_T_C3_D_TMP(lin_aux4).FEC_VALOR_ORIGINAL, REC_T_C3_D_TMP(lin_aux4).ID_STATUS_MOV, REC_T_C3_D_TMP(lin_aux4).BENEFICIARIO     , REC_T_C3_D_TMP(lin_aux4).DESCRIPCION,
                                                                REC_T_C3_D_TMP(lin_aux4).NO_CLIENTE   , REC_T_C3_D_TMP(lin_aux4).SECUENCIA_DEP_ESPECIALES, REC_T_C3_D_TMP(lin_aux4).PERIODO           , REC_T_C3_D_TMP(lin_aux4).CVE_OPERACION, REC_T_C3_D_TMP(lin_aux4).ORIGEN_MOVIMIENTO, REC_T_C3_D_TMP(lin_aux4).ID_CHEQUERA_BENEF,
                                                                REC_T_C3_D_TMP(lin_aux4).LOTE_ENTRADA , REC_T_C3_D_TMP(lin_aux4).NO_DOCTO                , REC_T_C3_D_TMP(lin_aux4).PLATAFORMA        , REC_T_C3_D_TMP(lin_aux4).NOM_EMPRESA  , REC_T_C3_D_TMP(lin_aux4).NOM_EMPRESA_REL  , REC_T_C3_D_TMP(lin_aux4).NO_CUENTA,
                                                                REC_T_C3_D_TMP(lin_aux4).FOLIO_REF    , REC_T_C3_D_TMP(lin_aux4).FECHA_ACTUALIZACION     , REC_T_C3_D_TMP(lin_aux4).PROCESADO
                            from dual;
                           --DBMS_OUTPUT.PUT_LINE('        [INSERT FECXC_DEP_ESPECIALES]: ' );
                           ELSE-- fin creaci?n de r?plica aplicada
                               --Si ya existe la r?plica aplicada o pendiente del folio SBC
                               --Si el folio aplicado ya existe y se gener? un cancelado se tiene que forzar la obtenci?n de cuentas
                               --Forzar al reprocesamiento
                               UPDATE    FECXC_DEP_ESPECIALES
                                  SET PROCESADO = 0
                                WHERE    NO_FOLIO_DET =noFolioDet;
                             --DBMS_OUTPUT.PUT_LINE('        [REAPERTURA INGRESOS SBC]: ');
                             utl_file.put_line(fichero,'        [REAPERTURA INGRESOS SBC]: ');
                               DELETE   /*+ INDEX (D IDX_FECXC_DEP_ESP_D00) */
                                        FECXC_DEP_ESPECIALES_D D
                               WHERE    EXISTS (SELECT    1
                                                FROM    FECXC_DEP_ESPECIALES E
                                                WHERE    E.NO_FOLIO_DET = noFolioDet
                                                AND     E.SECUENCIA_DEP_ESPECIALES = D.SECUENCIA_DEP_ESPECIALES );
                             --DBMS_OUTPUT.PUT_LINE('        [DELETE FECXC_DEP_ESPECIALES_D]: ');
                               DELETE    FECXP_BIT_INGR_CC D
                                WHERE    EXISTS (SELECT    1
                                                   FROM    FECXC_DEP_ESPECIALES E
                                                  WHERE    E.NO_FOLIO_DET = noFolioDet
                                                    AND     E.SECUENCIA_DEP_ESPECIALES = D.SECUENCIA_DEP_ESPECIALES );
                             --DBMS_OUTPUT.PUT_LINE('        [DELETE FECXP_BIT_INGR_CC]:' );
                               DELETE    FECXP_BIT_INGR_MISC D
                                WHERE    EXISTS (SELECT    1
                                                   FROM    FECXC_DEP_ESPECIALES E
                                                  WHERE    E.NO_FOLIO_DET = noFolioDet
                                                    AND    E.SECUENCIA_DEP_ESPECIALES = D.SECUENCIA_DEP_ESPECIALES );
                             --DBMS_OUTPUT.PUT_LINE('        [DELETE FECXP_BIT_INGR_MISC]: ');
                               DELETE    FECXP_MISC_REPE D
                                WHERE    D.NO_FOLIO_DET =noFolioDet;
                             --DBMS_OUTPUT.PUT_LINE('        [DELETE FECXP_MISC_REPE]: ');
                               DELETE    FECXP_FACT_VAR D
                                WHERE    D.NO_FOLIO_DET =noFolioDet;
                             --DBMS_OUTPUT.PUT_LINE('        [DELETE FECXP_FACT_VAR]: ');
                               DELETE    FECXP_BIT_INGR_FACT D
                                WHERE    EXISTS (SELECT    1
                                                   FROM    FECXC_DEP_ESPECIALES E
                                                  WHERE    E.NO_FOLIO_DET = noFolioDet
                                                    AND     E.SECUENCIA_DEP_ESPECIALES = D.SECUENCIA_DEP_ESPECIALES );
                             --DBMS_OUTPUT.PUT_LINE('        [DELETE FECXP_BIT_INGR_FACT]: ');
                             --DBMS_OUTPUT.PUT_LINE('        [TERMINA FORZAR REPROCESO DE INGRESOS SBC CUENTAS CONTABLES]: ');
                           END IF; -- fin else  r?plica aplicada
                           --Una vez creada la r?plica crear el cancelado pues no existe previamente
                           --Para los registros cancelados la fecha flujo debe ser la fecha de cancelaci?n
                           fecValor := fecModif;
                           --DBMS_OUTPUT.PUT_LINE('Folio SBC se generar? FECXC_DEP_ESPECIALES con Folio cancelado: ' || noFolioDet || ' Status: ' || idEstatusMov || ' TipoOper: ' || idTipoOperacion);
                           --DBMS_OUTPUT.PUT_LINE('    [DATO] Folio: ' || noFolioDet);
                           --DBMS_OUTPUT.PUT_LINE('    [DATO] Status: ' || idEstatusMov);
                           --DBMS_OUTPUT.PUT_LINE('    [DATO] fecFlujo: ' || fecValor);
                           --DBMS_OUTPUT.PUT_LINE('    [DATO] fecModif: ' || fecModif);
                           utl_file.put_line(fichero,'Folio SBC se generar? FECXC_DEP_ESPECIALES con Folio cancelado: ' || noFolioDet || ' Status: ' || idEstatusMov || ' TipoOper: ' || idTipoOperacion);
                           utl_file.put_line(fichero,'   [DATO] Folio: ' || noFolioDet);
                           utl_file.put_line(fichero,'   [DATO] Status: ' || idEstatusMov);
                           utl_file.put_line(fichero,'    [DATO] fecFlujo: ' || fecValor);
                           utl_file.put_line(fichero,'    [DATO] fecModif: ' || fecModif);
                            REC_T_C3_D_TMP.EXTEND;
                            lin_aux4 := lin_aux4+1;
                            select noEmpresa    , noFolioDet    , fecValor, referencia   , idBanco          , idbancobenef,
                                                                idChequera   , concepto                , tipoCambio        , importe, noCheque   ,idTipoOperacion,
                                                                idFormaPago  , idDivisa      , fecValor, idEstatusMov,beneficiario     , descripcion,
                                                                nocliente,SECUENCIA_DEP_ESPECIALES.NEXTVAL,cPeriodo    ,idCveOperacion, origenMov  , idchequerabenef,
                                                                loteentrada  , nodocto       , plataforma                  , nomEmpresa   , nomEmpresaRel    , noCuenta,
                                                                folioRef     , SYSDATE,0
                            into REC_T_C3_D_TMP(lin_aux4).NO_EMPRESA   , REC_T_C3_D_TMP(lin_aux4).NO_FOLIO_DET            , REC_T_C3_D_TMP(lin_aux4).FEC_VALOR         , REC_T_C3_D_TMP(lin_aux4).REFERENCIA   , REC_T_C3_D_TMP(lin_aux4).ID_BANCO         , REC_T_C3_D_TMP(lin_aux4).ID_BANCO_BENEF,
                                                                REC_T_C3_D_TMP(lin_aux4).ID_CHEQUERA  , REC_T_C3_D_TMP(lin_aux4).CONCEPTO                , REC_T_C3_D_TMP(lin_aux4).TIPO_CAMBIO       , REC_T_C3_D_TMP(lin_aux4).IMPORTE      , REC_T_C3_D_TMP(lin_aux4).NO_CHEQUE        , REC_T_C3_D_TMP(lin_aux4).ID_TIPO_OPERACION_SET,
                                                                REC_T_C3_D_TMP(lin_aux4).ID_FORMA_PAGO, REC_T_C3_D_TMP(lin_aux4).ID_DIVISA               , REC_T_C3_D_TMP(lin_aux4).FEC_VALOR_ORIGINAL, REC_T_C3_D_TMP(lin_aux4).ID_STATUS_MOV, REC_T_C3_D_TMP(lin_aux4).BENEFICIARIO     , REC_T_C3_D_TMP(lin_aux4).DESCRIPCION,
                                                                REC_T_C3_D_TMP(lin_aux4).NO_CLIENTE   , REC_T_C3_D_TMP(lin_aux4).SECUENCIA_DEP_ESPECIALES, REC_T_C3_D_TMP(lin_aux4).PERIODO           , REC_T_C3_D_TMP(lin_aux4).CVE_OPERACION, REC_T_C3_D_TMP(lin_aux4).ORIGEN_MOVIMIENTO, REC_T_C3_D_TMP(lin_aux4).ID_CHEQUERA_BENEF,
                                                                REC_T_C3_D_TMP(lin_aux4).LOTE_ENTRADA , REC_T_C3_D_TMP(lin_aux4).NO_DOCTO                , REC_T_C3_D_TMP(lin_aux4).PLATAFORMA        , REC_T_C3_D_TMP(lin_aux4).NOM_EMPRESA  , REC_T_C3_D_TMP(lin_aux4).NOM_EMPRESA_REL  , REC_T_C3_D_TMP(lin_aux4).NO_CUENTA,
                                                                REC_T_C3_D_TMP(lin_aux4).FOLIO_REF    , REC_T_C3_D_TMP(lin_aux4).FECHA_ACTUALIZACION     , REC_T_C3_D_TMP(lin_aux4).PROCESADO
                            from dual;
                         --DBMS_OUTPUT.PUT_LINE('        [INSERT FECXC_DEP_ESPECIALES]: ');
                     END IF;--Finaliza validaci?n de que no exista previamente el cancelado
                  ELSE--Fin if es cancelado
                      --es un folio SBC no cancelado
                      --DBMS_OUTPUT.PUT_LINE('[El folio SBC ' || noFolioDet || ' no est? cancelado, entra a la l?gica de no cancelados.] Status: '||  idEstatusMov );
                      --Buscar si existe el folio con estatus aplicado y si no est? como pendiente
                      utl_file.put_line(fichero,'[El folio SBC ' || noFolioDet || ' no est? cancelado, entra a la l?gica de no cancelados.] Status: '||  idEstatusMov );
                         idEstatusMovAplicado := 'A';
                         existeFolio :=0;
                         SELECT COUNT(*) INTO existeFolio FROM FECXC_DEP_ESPECIALES WHERE NO_FOLIO_DET = noFolioDet  AND ID_STATUS_MOV =  idEstatusMovAplicado;
                         --DBMS_OUTPUT.PUT_LINE('[Se han localizado]: ' || existeFolio || ' folios SBC con estatus aplicado. No se insert? este folio si ya existe y se verificar? si actualiza status.');
                         utl_file.put_line(fichero,'[Se han localizado]: ' || existeFolio || ' folios SBC con estatus aplicado. No se insert? este folio si ya existe y se verificar? si actualiza status.');
                         --Si no existe como aplicado buscar como pendiente
                         IF (existeFolio=0) THEN
                            idEstatusMovAplicado := 'P';
                            SELECT COUNT(*) INTO existeFolio FROM FECXC_DEP_ESPECIALES WHERE NO_FOLIO_DET =  noFolioDet  AND ID_STATUS_MOV =  idEstatusMovAplicado ;
                            --DBMS_OUTPUT.PUT_LINE('[Se han localizado]: ' || existeFolio || ' folios SBC con estatus pendiente.');
                            utl_file.put_line(fichero,'[Se han localizado]: ' || existeFolio || ' folios SBC con estatus pendiente.');
                         END IF;
                         --Si no existe crearlo
                         IF (existeFolio=0)THEN
                             --DBMS_OUTPUT.PUT_LINE('Folio SBC se generar? FECXC_DEP_ESPECIALES aplicada con Folio: ' || noFolioDet || ' Status: ' || idEstatusMov || ' TipoOper: ' || idTipoOperacion);
                             --DBMS_OUTPUT.PUT_LINE('FOLIO SBC:'||noFolioDet ||' noEmpresa:'||noEmpresa);
                             utl_file.put_line(fichero,'Folio SBC se generar? FECXC_DEP_ESPECIALES aplicada con Folio: ' || noFolioDet || ' Status: ' || idEstatusMov || ' TipoOper: ' || idTipoOperacion);
                                REC_T_C3_D_TMP.EXTEND;
                                lin_aux4 := lin_aux4+1;
                               select noEmpresa    , noFolioDet    , fecValor, referencia   , idBanco          , idbancobenef,
                                                                idChequera   , concepto                , tipoCambio        , importe, noCheque   ,idTipoOperacion,
                                                                idFormaPago  , idDivisa      , fecValor, idEstatusMov,beneficiario     , descripcion,
                                                                nocliente,SECUENCIA_DEP_ESPECIALES.NEXTVAL,cPeriodo    ,idCveOperacion, origenMov  , idchequerabenef,
                                                                loteentrada  , nodocto       , plataforma                  , nomEmpresa   , nomEmpresaRel    , noCuenta,
                                                                folioRef     , SYSDATE,0
                               into REC_T_C3_D_TMP(lin_aux4).NO_EMPRESA   , REC_T_C3_D_TMP(lin_aux4).NO_FOLIO_DET            , REC_T_C3_D_TMP(lin_aux4).FEC_VALOR         , REC_T_C3_D_TMP(lin_aux4).REFERENCIA   , REC_T_C3_D_TMP(lin_aux4).ID_BANCO         , REC_T_C3_D_TMP(lin_aux4).ID_BANCO_BENEF,
                                                                REC_T_C3_D_TMP(lin_aux4).ID_CHEQUERA  , REC_T_C3_D_TMP(lin_aux4).CONCEPTO                , REC_T_C3_D_TMP(lin_aux4).TIPO_CAMBIO       , REC_T_C3_D_TMP(lin_aux4).IMPORTE      , REC_T_C3_D_TMP(lin_aux4).NO_CHEQUE        , REC_T_C3_D_TMP(lin_aux4).ID_TIPO_OPERACION_SET,
                                                                REC_T_C3_D_TMP(lin_aux4).ID_FORMA_PAGO, REC_T_C3_D_TMP(lin_aux4).ID_DIVISA               , REC_T_C3_D_TMP(lin_aux4).FEC_VALOR_ORIGINAL, REC_T_C3_D_TMP(lin_aux4).ID_STATUS_MOV, REC_T_C3_D_TMP(lin_aux4).BENEFICIARIO     , REC_T_C3_D_TMP(lin_aux4).DESCRIPCION,
                                                                REC_T_C3_D_TMP(lin_aux4).NO_CLIENTE   , REC_T_C3_D_TMP(lin_aux4).SECUENCIA_DEP_ESPECIALES, REC_T_C3_D_TMP(lin_aux4).PERIODO           , REC_T_C3_D_TMP(lin_aux4).CVE_OPERACION, REC_T_C3_D_TMP(lin_aux4).ORIGEN_MOVIMIENTO, REC_T_C3_D_TMP(lin_aux4).ID_CHEQUERA_BENEF,
                                                                REC_T_C3_D_TMP(lin_aux4).LOTE_ENTRADA , REC_T_C3_D_TMP(lin_aux4).NO_DOCTO                , REC_T_C3_D_TMP(lin_aux4).PLATAFORMA        , REC_T_C3_D_TMP(lin_aux4).NOM_EMPRESA  , REC_T_C3_D_TMP(lin_aux4).NOM_EMPRESA_REL  , REC_T_C3_D_TMP(lin_aux4).NO_CUENTA,
                                                                REC_T_C3_D_TMP(lin_aux4).FOLIO_REF    , REC_T_C3_D_TMP(lin_aux4).FECHA_ACTUALIZACION     , REC_T_C3_D_TMP(lin_aux4).PROCESADO
                               from dual;
                              --DBMS_OUTPUT.PUT_LINE('        [INSERT FECXC_DEP_ESPECIALES]: ');
                         ELSE  --// finaliza crear SBC no cancelado
                               --//si el SBC no cancelado ya existe
                              --DBMS_OUTPUT.PUT_LINE('Logica existe Folio != 0 tipo operacion: '||idTipoOperacion||'');
                                IF idTipoOperacion=3110 OR idTipoOperacion=3112 THEN
                                   --//buscar si el folio existente sigue pendiente para cambiarlo de estatus
                                   --DBMS_OUTPUT.PUT_LINE('Buscar si el folio existente sigue pendiente para cambiarlo de estatus');
                                   existeFolio:=0;
                                   SELECT COUNT(*) INTO existeFolio FROM FECXC_DEP_ESPECIALES WHERE NO_FOLIO_DET =  noFolioDet  AND ID_STATUS_MOV = 'P';
                                   --DBMS_OUTPUT.PUT_LINE('Se encontraron '||existeFolio||' Con Estatus Pendiente');
                                   utl_file.put_line(fichero,'Se encontraron '||existeFolio||' Con Estatus Pendiente');
                                   IF (existeFolio!=0) THEN
                                     --DBMS_OUTPUT.PUT_LINE('Actualiza status de SBC DNI en FECXC_DEP_ESPECIALES con Folio: ' || noFolioDet || ' Status: P,  TipoOper: ' || idTipoOperacion);
                                     utl_file.put_line(fichero,'Actualiza status de SBC DNI en FECXC_DEP_ESPECIALES con Folio: ' || noFolioDet || ' Status: P,  TipoOper: ' || idTipoOperacion);
                                       UPDATE FECXC_DEP_ESPECIALES SET ID_STATUS_MOV = 'A'
                                        WHERE NO_FOLIO_DET = noFolioDet  AND ID_STATUS_MOV = 'P';
                                     --DBMS_OUTPUT.PUT_LINE('        [UPDATE FECXC_DEP_ESPECIALES]: ');
                                   END IF;
                                END IF;--//termina si es operaci?n SBC DNI
                         END IF ; --//finaliza el SBC no cancelado ya existe
                  END IF;--//Fin no es un folio SBC cancelado
            end loop;
           IF REC_T_C3_D_TMP.COUNT != 0 THEN
                FORALL z IN REC_T_C3_D_TMP.FIRST .. REC_T_C3_D_TMP.LAST
                    INSERT INTO FECXC_DEP_ESPECIALES
                    VALUES REC_T_C3_D_TMP (z);
                REC_T_C3_D_TMP.delete;
                --commit;
           END IF;
           lin_aux4 := 0;
        end if;
      end loop;
     close CURSOR_3;
     COMMIT;
 utl_file.put_line(fichero,'Termino Exitosamente');
 utl_file.fclose(fichero);
EXCEPTION
    WHEN OTHERS THEN
     err_code := SQLCODE;
     err_msg := substr(SQLERRM, 1, 240);
    UPDATE FECXP_ppto_extraccion_params
    SET FEC_FIN=SYSDATE
    ,ATRIBUTO1=err_code||' '||err_msg
    ,ESTATUS_PROCESO='ERROR'
    WHERE PROCESO_ID=10;
    utl_file.put_line(fichero,'ERROR, procesando folio '||noFolioDet);
    utl_file.put_line(fichero,'ERROR: '||SUBSTR(SQLERRM,0,8000) );
    utl_file.put_line(fichero,'ERRORCODE: '||SQLCODE );
    utl_file.fclose(fichero);
END;
/
