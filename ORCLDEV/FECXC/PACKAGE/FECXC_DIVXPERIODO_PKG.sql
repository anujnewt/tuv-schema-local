CREATE OR REPLACE EDITIONABLE PACKAGE "FECXC"."FECXC_DIVXPERIODO_PKG" AS
/*===============================================================
FILE NAME : fecxc_divxperiodo_pkg.pks
NOMBRE DEL M?DULO     : FECXC
CREATED DATE          : 4-Ene-2013
AUTHOR(S)             : Iv?n Casta?eda Loeza
SHORT DESCRIPTION     : Este paquete contiene los procedures y funciones
                        necesarias para el llenado de la tabla
                        FECXC_DIVXPERIODO_TAB utilizada para la generaci?n del
                        reporte de division por periodo
PROCEDURES CONTAINS   :
   fecxc_fill_divxperiodo_pr,
   fecxc_fill_divxperiodo_disc_pr
   fecxc_fill_divxperiodo_disc_fn,
   fecxc_get_months_fn,
   fecxc_get_cardinal_fn,
   fecxc_get_groupname_fn,
   fecxc_get_monthname_fn,
   in_list
RELATED DOCUMENTS   : An?lisis y dise?o funcional
=============================================================== */
TYPE t_in_list_tab IS TABLE OF VARCHAR2 (4000);
PROCEDURE fecxc_fill_divxperiodo_pr (
                                     piinIdAgrup       IN NUMBER,
                                     piinFormat        IN NUMBER,
                                     pistUser          IN VARCHAR2,
                                     piinSegment       IN NUMBER
                                    );
PROCEDURE fecxc_fill_divxperiodo_disc_pr (
                                     postErrbuf        OUT VARCHAR2,
                                     postRetcode       OUT VARCHAR2,
                                     piinIdAgrup       IN NUMBER,
                                     piinFormat        IN NUMBER,
                                     pistUser          IN VARCHAR2,
                                     piinSegment       IN NUMBER
                                    );
FUNCTION fecxc_fill_divxperiodo_disc_fn (
                                            piinIdAgrup       IN NUMBER,
                                            piinFormat        IN NUMBER,
                                            pistUser          IN VARCHAR2,
                                            piinSegment       IN NUMBER
                                         )
RETURN VARCHAR2;
FUNCTION fecxc_get_months_fn (
                              piinIdAgrup    NUMBER,
                              piinNumElement NUMBER
                              )
RETURN VARCHAR2;
FUNCTION fecxc_get_cardinal_fn (
                                piinNumElement    NUMBER
                               )
RETURN VARCHAR2;
FUNCTION fecxc_get_groupname_fn (
                                 piinIdAgrup    NUMBER
                                )
RETURN VARCHAR2;
FUNCTION fecxc_get_monthname_fn (
                                 piinIdMonth    NUMBER
                                )
RETURN VARCHAR2;
FUNCTION in_list (
                  p_in_list  IN  VARCHAR2
                  )
RETURN t_in_list_tab PIPELINED;
FUNCTION isnumeric_fn (
                        pistValue IN VARCHAR2
                       )
RETURN NUMBER;
FUNCTION FOLIOSET_FN (
                        PISTCONCEPTO IN VARCHAR2,
                        pinCodFolio  IN NUMBER
                       )
RETURN NUMBER;
END;
/
CREATE OR REPLACE EDITIONABLE PACKAGE BODY "FECXC"."FECXC_DIVXPERIODO_PKG" AS
/*===============================================================
FILE NAME : fecxc_divxperiodo_pkg.pkb
NOMBRE DEL M?DULO     : FECXC
CREATED DATE          : 4-Ene-2013
AUTHOR(S)             : Iv?n Casta?eda Loeza
SHORT DESCRIPTION     : Este paquete contiene los procedures y funciones
                        necesarias para el llenado de la tabla
                        FECXC_DIVXPERIODO_TAB utilizada para la generaci?n del
                        reporte de division por periodo
PROCEDURES CONTAINS   :
   fecxc_fill_divxperiodo_pr,
   fecxc_fill_divxperiodo_disc_pr
   fecxc_fill_divxperiodo_disc_fn,
   fecxc_get_months_fn,
   fecxc_get_cardinal_fn,
   fecxc_get_groupname_fn,
   fecxc_get_monthname_fn,
   in_list
RELATED DOCUMENTS   : An?lisis y dise?o funcional
=============================================================== */
PROCEDURE fecxc_fill_divxperiodo_pr (
                                     piinIdAgrup       IN NUMBER,
                                     piinFormat        IN NUMBER,
                                     pistUser          IN VARCHAR2,
                                     piinSegment       IN NUMBER
                                    )
IS
        linFinalMonth            NUMBER := 0;
        linTotalMonth            NUMBER;
        linIterations            NUMBER := 0;
        linModule                NUMBER := 0;
        linMonthBegin            NUMBER := 0;
        CURSOR curCanalesDesc
        IS
        SELECT DISTINCT
            descanal,
            canal
        FROM
            fecxc_divxperiodo_vw
        WHERE
            segmento =  piinSegment
        ORDER BY canal;
        CURSOR curTotalPeriodo(piinCanal IN VARCHAR2)
        IS
        SELECT
            1 order_id,
            piinCanal canal,
            'Total' periodo,
            NVL(b.cobranza,0) cobranza,
            NVL(b.ppto,0) ppto,
            NVL(b.anioAnt,0) anioAnt,
            NVL(b.cobranza-b.ppto,0) varppto,
            NVL(b.cobranza-b.anioAnt,0) varant,
            NVL(100*DECODE(b.ppto,0,1,(b.cobranza-b.ppto)/b.ppto),0)AS porvarppto,
            NVL(100*DECODE(b.anioAnt,0,1,(b.cobranza-b.anioAnt)/b.anioAnt),0)AS porvarant
        FROM
            (SELECT
                (SELECT
                     SUM(A.importe)
                 FROM   fecxc_divxperiodo_vw    A ,
                        fecxc_det_catalogos     c ,
                        fecxc_fmt_segmentos_pdf d
                 WHERE  A.canal               = c.COD_SEC_LIN
                 AND    A.segmento            = d.ID_SEGMENTO_PDF
                 AND    d.NOMBRE_DEL_FORMATO  = piinFormat
                 AND    d.ID_SESSION          = pistUser
                 AND    A.descanal            = piinCanal
                 AND    A.subtipo             = 'REAL'
                ) Cobranza,
                (SELECT
                     SUM(A.importe)
                 FROM   fecxc_divxperiodo_vw    A ,
                        fecxc_det_catalogos     c ,
                        fecxc_fmt_segmentos_pdf d
                 WHERE  A.canal               = c.COD_SEC_LIN
                 AND    A.segmento            = d.ID_SEGMENTO_PDF
                 AND    d.NOMBRE_DEL_FORMATO  = piinFormat
                 AND    d.ID_SESSION          = pistUser
                 AND    A.descanal            = piinCanal
                 AND    A.subtipo             = 'PRESUPUESTO'
                ) Ppto,
                (SELECT
                     SUM(A.importe)
                 FROM   fecxc_divxperiodo_vw    A ,
                        fecxc_det_catalogos     c ,
                        fecxc_fmt_segmentos_pdf d
                 WHERE  A.canal               = c.COD_SEC_LIN
                 AND    A.segmento            = d.ID_SEGMENTO_PDF
                 AND    d.NOMBRE_DEL_FORMATO  = piinFormat
                 AND    d.ID_SESSION          = pistUser
                 AND    A.descanal            = piinCanal
                 AND    A.subtipo             = 'A?O ANTERIOR'
                ) AnioAnt
            FROM
                DUAL A)b;
          CURSOR curPeriodo (piinOrder NUMBER,piinCanal VARCHAR2, pistUserL VARCHAR2,
                                pistIter VARCHAR2, pistAgrup VARCHAR2, pistMonths VARCHAR2 )
          IS
          SELECT
              piinOrder order_id,
              piinCanal canal,
              pistIter||' '||pistAgrup periodo,
              NVL(b.cobranza,0) cobranza,
              NVL(b.ppto,0) ppto,
              NVL(b.anioAnt,0) anioAnt,
              NVL(b.cobranza-b.ppto,0) varppto,
              NVL(b.cobranza-b.anioAnt,0) varant,
              NVL(100*DECODE(b.ppto,0,1,(b.cobranza-b.ppto)/b.ppto),0)AS porvarppto,
              NVL(100*DECODE(b.anioAnt,0,1,(b.cobranza-b.anioAnt)/b.anioAnt),0)AS porvarant
          FROM
              (SELECT
                  (SELECT
                       SUM(A.importe)
                   FROM   fecxc_divxperiodo_vw    A ,
                          fecxc_det_catalogos     c ,
                          fecxc_fmt_segmentos_pdf d
                   WHERE  A.canal               = c.COD_SEC_LIN
                   AND    A.segmento            = d.ID_SEGMENTO_PDF
                   AND    d.NOMBRE_DEL_FORMATO  = piinFormat
                   AND    d.ID_SESSION          = pistUser
                   AND    A.descanal            = piinCanal
                   AND    A.subtipo             = 'REAL'
                   AND    A.mes                 IN
                      (SELECT * FROM TABLE( fecxc_divxperiodo_pkg.in_list(pistMonths)))
                  ) Cobranza,
                  (SELECT
                       SUM(A.importe)
                   FROM   fecxc_divxperiodo_vw    A ,
                          fecxc_det_catalogos     c ,
                          fecxc_fmt_segmentos_pdf d
                   WHERE  A.canal               = c.COD_SEC_LIN
                   AND    A.segmento            = d.ID_SEGMENTO_PDF
                   AND    d.NOMBRE_DEL_FORMATO  = piinFormat
                   AND    d.ID_SESSION           = pistUser
                   AND    A.descanal            = piinCanal
                   AND    A.subtipo             = 'PRESUPUESTO'
                   AND    A.mes                 IN
                      (SELECT * FROM TABLE( fecxc_divxperiodo_pkg.in_list(pistMonths)))
                  ) Ppto,
                  (SELECT
                       SUM(A.importe)
                   FROM   fecxc_divxperiodo_vw    A ,
                          fecxc_det_catalogos     c ,
                          fecxc_fmt_segmentos_pdf d
                   WHERE  A.canal               = c.COD_SEC_LIN
                   AND    A.segmento            = d.ID_SEGMENTO_PDF
                   AND    d.NOMBRE_DEL_FORMATO  = piinFormat
                   AND    d.ID_SESSION          = pistUser
                   AND    A.descanal            = piinCanal
                   AND    A.subtipo             = 'A?O ANTERIOR'
                   AND    A.mes                 IN
                      (SELECT * FROM TABLE( fecxc_divxperiodo_pkg.in_list(pistMonths)))
                  ) AnioAnt
              FROM
                  DUAL A)b;
            CURSOR curTotalGeneral
            IS
            SELECT
                100 order_id,
                'Total' canal,
                'Total General' periodo,
                NVL(b.cobranza,0) cobranza,
                NVL(b.ppto,0) ppto,
                NVL(b.anioAnt,0) anioAnt,
                NVL(b.cobranza-b.ppto,0) varppto,
                NVL(b.cobranza-b.anioAnt,0) varant,
                NVL(100*DECODE(b.ppto,0,1,(b.cobranza-b.ppto)/b.ppto),0)AS porvarppto,
                NVL(100*DECODE(b.anioAnt,0,1,(b.cobranza-b.anioAnt)/b.anioAnt),0)AS porvarant
            FROM
                (SELECT
                    (SELECT
                         SUM(A.importe)
                     FROM   fecxc_divxperiodo_vw    A ,
                            fecxc_det_catalogos     c ,
                            fecxc_fmt_segmentos_pdf d
                     WHERE  A.canal               = c.COD_SEC_LIN
                     AND    A.segmento            = d.ID_SEGMENTO_PDF
                     AND    d.NOMBRE_DEL_FORMATO  = piinFormat
                    AND     d.ID_SESSION          = pistUser
                     AND    A.descanal            IN (SELECT DISTINCT
                                                          descanal
                                                      FROM
                                                          fecxc_divxperiodo_vw
                                                      WHERE
                                                          segmento =  piinSegment)
                     AND    A.subtipo             = 'REAL'
                    ) Cobranza,
                    (SELECT
                         SUM(A.importe)
                     FROM   fecxc_divxperiodo_vw    A ,
                            fecxc_det_catalogos     c ,
                            fecxc_fmt_segmentos_pdf d
                     WHERE  A.canal               = c.COD_SEC_LIN
                     AND    A.segmento            = d.ID_SEGMENTO_PDF
                     AND    d.NOMBRE_DEL_FORMATO  = piinFormat
                     AND d.ID_SESSION             = pistUser
                     AND    A.descanal            IN (SELECT DISTINCT
                                                          descanal
                                                      FROM
                                                          fecxc_divxperiodo_vw
                                                      WHERE
                                                          segmento =  piinSegment)
                     AND    A.subtipo             = 'PRESUPUESTO'
                    ) Ppto,
                    (SELECT
                         SUM(A.importe)
                     FROM   fecxc_divxperiodo_vw    A ,
                            fecxc_det_catalogos     c ,
                            fecxc_fmt_segmentos_pdf d
                     WHERE  A.canal               = c.COD_SEC_LIN
                     AND    A.segmento            = d.ID_SEGMENTO_PDF
                     AND    d.NOMBRE_DEL_FORMATO  = piinFormat
                     AND d.ID_SESSION             = pistUser
                     AND    A.descanal            IN (SELECT DISTINCT
                                                          descanal
                                                      FROM
                                                          fecxc_divxperiodo_vw
                                                      WHERE
                                                          segmento =  piinSegment)
                     AND    A.subtipo             = 'A?O ANTERIOR'
                    ) AnioAnt
                FROM
                    DUAL A)b;
BEGIN
    DELETE FROM FECXC_DIVXPERIODO_TAB;
    COMMIT;
    FOR i IN 1..12
    LOOP
        SELECT
                NVL(SUM(A.importe),0) INTO linTotalMonth
        FROM    fecxc_divxperiodo_vw    A ,
                fecxc_det_catalogos     c ,
                fecxc_fmt_segmentos_pdf d
        WHERE   A.canal               = c.COD_SEC_LIN
        AND     A.segmento            = d.ID_SEGMENTO_PDF
        AND     d.NOMBRE_DEL_FORMATO  = piinFormat
        AND     d.ID_SESSION          = pistUser
        AND     A.descanal            IN (SELECT DISTINCT
                                              descanal
                                          FROM
                                              fecxc_divxperiodo_vw
                                          WHERE
                                              segmento =  piinSegment)
        AND     A.subtipo             IN ('REAL','PRESUPUESTO','A?O ANTERIOR')
        AND     A.mes                 = i;
        IF (linTotalMonth != 0) THEN
            linFinalMonth := i;
        END IF;
    END LOOP;
    IF (piinIdAgrup = 1)THEN
        linMonthBegin := 1;
    ELSE
        linIterations := TRUNC(linFinalMonth/piinIdAgrup);
        linModule     := MOD(linFinalMonth,piinIdAgrup);
        linMonthBegin := (piinIdAgrup * linIterations) + 1;
    END IF;
    dbms_output.put_line('linFinalMonth:'||linFinalMonth);
    dbms_output.put_line('linIterations:'||linIterations);
    dbms_output.put_line('linModule:'||linModule);
    dbms_output.put_line('linMonthBegin:'||linMonthBegin);
    FOR i IN curCanalesDesc
    LOOP
        FOR j IN curTotalPeriodo(i.descanal)
        LOOP
            dbms_output.put_line(j.order_id||'|'||j.canal||'|'||j.periodo||'|'||j.cobranza||'|'||j.ppto||'|'||
                j.anioAnt||'|'||j.varppto||'|'||j.varant||'|'||j.porvarppto||'|'||j.porvarant);
            INSERT INTO FECXC_DIVXPERIODO_TAB (
                                                ID_ORDER,
                                                DES_CANAL,
                                                DES_PERIODO,
                                                NUM_REAL,
                                                NUM_PPTO,
                                                NUM_ANIO_ANT,
                                                NUM_VAR_PPTO,
                                                NUM_VAR_ANIO_ANT,
                                                POR_VAR_PPTO,
                                                POR_VAR_ANIO_ANT
                                              )
            VALUES (
                    j.order_id,
                    j.canal,
                    j.periodo,
                    j.cobranza,
                    j.ppto,
                    j.anioAnt,
                    j.varppto,
                    j.varant,
                    j.porvarppto,
                    j.porvarant
                    );
        END LOOP;
        FOR K IN 1..linIterations
        LOOP
            dbms_output.put_line('k:'||K);
            FOR l IN curPeriodo (K,i.descanal,pistUser,fecxc_get_cardinal_fn(K),fecxc_get_groupname_fn(piinIdAgrup),
                                    fecxc_get_months_fn(piinIdAgrup,K))
            LOOP
                dbms_output.put_line(l.order_id||'|'||l.canal||'|'||l.periodo||'|'||l.cobranza||'|'||l.ppto||'|'||
                    l.anioAnt||'|'||l.varppto||'|'||l.varant||'|'||l.porvarppto||'|'||l.porvarant);
                INSERT INTO FECXC_DIVXPERIODO_TAB (
                                                    ID_ORDER,
                                                    DES_CANAL,
                                                    DES_PERIODO,
                                                    NUM_REAL,
                                                    NUM_PPTO,
                                                    NUM_ANIO_ANT,
                                                    NUM_VAR_PPTO,
                                                    NUM_VAR_ANIO_ANT,
                                                    POR_VAR_PPTO,
                                                    POR_VAR_ANIO_ANT
                                                  )
                VALUES (
                        l.order_id,
                        l.canal,
                        l.periodo,
                        l.cobranza,
                        l.ppto,
                        l.anioAnt,
                        l.varppto,
                        l.varant,
                        l.porvarppto,
                        l.porvarant
                        );
            END LOOP;
        END LOOP;
        FOR M IN linMonthBegin..linFinalMonth
        LOOP
            dbms_output.put_line('m:'||M);
            FOR o IN curPeriodo (M,i.descanal,pistUser,fecxc_get_cardinal_fn('0'),fecxc_get_monthname_fn(M),M)
            LOOP
                dbms_output.put_line(o.order_id||'|'||o.canal||'|'||o.periodo||'|'||o.cobranza||'|'||o.ppto||'|'||
                    o.anioAnt||'|'||o.varppto||'|'||o.varant||'|'||o.porvarppto||'|'||o.porvarant);
                INSERT INTO FECXC_DIVXPERIODO_TAB (
                                                    ID_ORDER,
                                                    DES_CANAL,
                                                    DES_PERIODO,
                                                    NUM_REAL,
                                                    NUM_PPTO,
                                                    NUM_ANIO_ANT,
                                                    NUM_VAR_PPTO,
                                                    NUM_VAR_ANIO_ANT,
                                                    POR_VAR_PPTO,
                                                    POR_VAR_ANIO_ANT
                                                  )
                VALUES (
                        o.order_id,
                        o.canal,
                        o.periodo,
                        o.cobranza,
                        o.ppto,
                        o.anioAnt,
                        o.varppto,
                        o.varant,
                        o.porvarppto,
                        o.porvarant
                        );
            END LOOP;
        END LOOP;
    END LOOP;
    FOR n IN curTotalGeneral
    LOOP
        dbms_output.put_line(n.order_id||'|'||n.canal||'|'||n.periodo||'|'||n.cobranza||'|'||n.ppto||'|'||
            n.anioAnt||'|'||n.varppto||'|'||n.varant||'|'||n.porvarppto||'|'||n.porvarant);
        INSERT INTO FECXC_DIVXPERIODO_TAB (
                                            ID_ORDER,
                                            DES_CANAL,
                                            DES_PERIODO,
                                            NUM_REAL,
                                            NUM_PPTO,
                                            NUM_ANIO_ANT,
                                            NUM_VAR_PPTO,
                                            NUM_VAR_ANIO_ANT,
                                            POR_VAR_PPTO,
                                            POR_VAR_ANIO_ANT
                                          )
        VALUES (
                n.order_id,
                n.canal,
                n.periodo,
                n.cobranza,
                n.ppto,
                n.anioAnt,
                n.varppto,
                n.varant,
                n.porvarppto,
                n.porvarant
                );
    END LOOP;
    COMMIT;
EXCEPTION
    WHEN OTHERS
    THEN
        --postErrbuf  :=  SQLERRM;
        --postRetcode :=  SQLCODE;
        dbms_output.put_line('Error:'||TO_CHAR(SQLCODE));
        dbms_output.put_line(SQLERRM);
END;
PROCEDURE fecxc_fill_divxperiodo_disc_pr (
                                            postErrbuf        OUT VARCHAR2,
                                            postRetcode       OUT VARCHAR2,
                                            piinIdAgrup       IN NUMBER,
                                            piinFormat        IN NUMBER,
                                            pistUser          IN VARCHAR2,
                                            piinSegment       IN NUMBER
                                         )
IS
        PRAGMA AUTONOMOUS_TRANSACTION;
        linFinalMonth            NUMBER := 0;
        linTotalMonth            NUMBER;
        linIterations            NUMBER := 0;
        linModule                NUMBER := 0;
        linMonthBegin            NUMBER := 0;
        CURSOR curCanalesDesc
        IS
        SELECT DISTINCT
            descanal,
            canal
        FROM
            fecxc_divxperiodo_vw
        WHERE
            segmento =  piinSegment
        ORDER BY canal;
        CURSOR curTotalPeriodo(piinCanal IN VARCHAR2)
        IS
        SELECT
            1 order_id,
            piinCanal canal,
            'Total' periodo,
            NVL(b.cobranza,0) cobranza,
            NVL(b.ppto,0) ppto,
            NVL(b.anioAnt,0) anioAnt,
            NVL(b.cobranza-b.ppto,0) varppto,
            NVL(b.cobranza-b.anioAnt,0) varant,
            NVL(100*DECODE(b.ppto,0,1,(b.cobranza-b.ppto)/b.ppto),0)AS porvarppto,
            NVL(100*DECODE(b.anioAnt,0,1,(b.cobranza-b.anioAnt)/b.anioAnt),0)AS porvarant
        FROM
            (SELECT
                (SELECT
                     SUM(A.importe)
                 FROM   fecxc_divxperiodo_vw    A
                 WHERE  A.segmento            = piinSegment
                 AND    A.descanal            = piinCanal
                 AND    A.subtipo             = 'REAL'
                ) Cobranza,
                (SELECT
                     SUM(A.importe)
                 FROM   fecxc_divxperiodo_vw    A
                 WHERE  A.segmento            = piinSegment
                 AND    A.descanal            = piinCanal
                 AND    A.subtipo             = 'PRESUPUESTO'
                ) Ppto,
                (SELECT
                     SUM(A.importe)
                 FROM   fecxc_divxperiodo_vw    A
                 WHERE  A.segmento            = piinSegment
                 AND    A.descanal            = piinCanal
                 AND    A.subtipo             = 'A?O ANTERIOR'
                ) AnioAnt
            FROM
                DUAL A)b;
          CURSOR curPeriodo (piinOrder NUMBER,piinCanal VARCHAR2, pistUserL VARCHAR2,
                                pistIter VARCHAR2, pistAgrup VARCHAR2, pistMonths VARCHAR2 )
          IS
          SELECT
              piinOrder order_id,
              piinCanal canal,
              pistIter||' '||pistAgrup periodo,
              NVL(b.cobranza,0) cobranza,
              NVL(b.ppto,0) ppto,
              NVL(b.anioAnt,0) anioAnt,
              NVL(b.cobranza-b.ppto,0) varppto,
              NVL(b.cobranza-b.anioAnt,0) varant,
              NVL(100*DECODE(b.ppto,0,1,(b.cobranza-b.ppto)/b.ppto),0)AS porvarppto,
              NVL(100*DECODE(b.anioAnt,0,1,(b.cobranza-b.anioAnt)/b.anioAnt),0)AS porvarant
          FROM
              (SELECT
                  (SELECT
                       SUM(A.importe)
                   FROM   fecxc_divxperiodo_vw    A
                   WHERE  A.segmento            = piinSegment
                   AND    A.descanal            = piinCanal
                   AND    A.subtipo             = 'REAL'
                   AND    A.mes                 IN
                      (SELECT * FROM TABLE( fecxc_divxperiodo_pkg.in_list(pistMonths)))
                  ) Cobranza,
                  (SELECT
                       SUM(A.importe)
                   FROM   fecxc_divxperiodo_vw    A
                   WHERE  A.segmento            = piinSegment
                   AND    A.descanal            = piinCanal
                   AND    A.subtipo             = 'PRESUPUESTO'
                   AND    A.mes                 IN
                      (SELECT * FROM TABLE( fecxc_divxperiodo_pkg.in_list(pistMonths)))
                  ) Ppto,
                  (SELECT
                       SUM(A.importe)
                   FROM   fecxc_divxperiodo_vw    A
                   WHERE  A.segmento            = piinSegment
                   AND    A.descanal            = piinCanal
                   AND    A.subtipo             = 'A?O ANTERIOR'
                   AND    A.mes                 IN
                      (SELECT * FROM TABLE( fecxc_divxperiodo_pkg.in_list(pistMonths)))
                  ) AnioAnt
              FROM
                  DUAL A)b;
            CURSOR curTotalGeneral
            IS
            SELECT
                100 order_id,
                'Total' canal,
                'Total General' periodo,
                NVL(b.cobranza,0) cobranza,
                NVL(b.ppto,0) ppto,
                NVL(b.anioAnt,0) anioAnt,
                NVL(b.cobranza-b.ppto,0) varppto,
                NVL(b.cobranza-b.anioAnt,0) varant,
                NVL(100*DECODE(b.ppto,0,1,(b.cobranza-b.ppto)/b.ppto),0)AS porvarppto,
                NVL(100*DECODE(b.anioAnt,0,1,(b.cobranza-b.anioAnt)/b.anioAnt),0)AS porvarant
            FROM
                (SELECT
                    (SELECT
                         SUM(A.importe)
                     FROM   fecxc_divxperiodo_vw    A
                     WHERE  A.segmento            = piinSegment
                     AND    A.descanal            IN (SELECT DISTINCT
                                                          descanal
                                                      FROM
                                                          fecxc_divxperiodo_vw
                                                      WHERE
                                                          segmento =  piinSegment)
                     AND    A.subtipo             = 'REAL'
                    ) Cobranza,
                    (SELECT
                         SUM(A.importe)
                     FROM   fecxc_divxperiodo_vw    A
                     WHERE  A.segmento            = piinSegment
                     AND    A.descanal            IN (SELECT DISTINCT
                                                          descanal
                                                      FROM
                                                          fecxc_divxperiodo_vw
                                                      WHERE
                                                          segmento =  piinSegment)
                     AND    A.subtipo             = 'PRESUPUESTO'
                    ) Ppto,
                    (SELECT
                         SUM(A.importe)
                     FROM   fecxc_divxperiodo_vw    A
                     WHERE  A.segmento            = piinSegment
                     AND    A.descanal            IN (SELECT DISTINCT
                                                          descanal
                                                      FROM
                                                          fecxc_divxperiodo_vw
                                                      WHERE
                                                          segmento =  piinSegment)
                     AND    A.subtipo             = 'A?O ANTERIOR'
                    ) AnioAnt
                FROM
                    DUAL A)b;
BEGIN
    DELETE FROM FECXC_DIVXPERIODO_TAB;
    COMMIT;
    dbms_output.put_line('piinSegment: '||piinSegment);
    --postErrbuf  :=  'Error en linea 593';
    FOR i IN 1..12
    LOOP
        SELECT
                NVL(SUM(A.importe),0) INTO linTotalMonth
        FROM    fecxc_divxperiodo_vw    A
        WHERE  A.segmento            = piinSegment
        AND    A.descanal            IN (SELECT DISTINCT
                                            descanal
                                         FROM
                                            fecxc_divxperiodo_vw
                                         WHERE
                                            segmento =  piinSegment)
        AND     A.subtipo             IN ('REAL','PRESUPUESTO','A?O ANTERIOR')
        AND     A.mes                 = i;
        dbms_output.put_line('linTotalMonth: '||linTotalMonth);
        IF (linTotalMonth != 0) THEN
            linFinalMonth := i;
        END IF;
    END LOOP;
    dbms_output.put_line('piinIdAgrup: '||piinIdAgrup);
    --postErrbuf  :=  'Error en linea 618';
    IF (piinIdAgrup = 1)THEN
        linMonthBegin := 1;
    ELSE
        linIterations := TRUNC(linFinalMonth/piinIdAgrup);
        linModule     := MOD(linFinalMonth,piinIdAgrup);
        linMonthBegin := (piinIdAgrup * linIterations) + 1;
    END IF;
    dbms_output.put_line('linFinalMonth:'||linFinalMonth);
    dbms_output.put_line('linIterations:'||linIterations);
    dbms_output.put_line('linModule:'||linModule);
    dbms_output.put_line('linMonthBegin:'||linMonthBegin);
    --postErrbuf  :=  'Error en linea 633';
    FOR i IN curCanalesDesc
    LOOP
        --postErrbuf  :=  'Error en linea 637';
        FOR j IN curTotalPeriodo(i.descanal)
        LOOP
            dbms_output.put_line(j.order_id||'|'||j.canal||'|'||j.periodo||'|'||j.cobranza||'|'||j.ppto||'|'||
                j.anioAnt||'|'||j.varppto||'|'||j.varant||'|'||j.porvarppto||'|'||j.porvarant);
            INSERT INTO FECXC_DIVXPERIODO_TAB (
                                                ID_ORDER,
                                                DES_CANAL,
                                                DES_PERIODO,
                                                NUM_REAL,
                                                NUM_PPTO,
                                                NUM_ANIO_ANT,
                                                NUM_VAR_PPTO,
                                                NUM_VAR_ANIO_ANT,
                                                POR_VAR_PPTO,
                                                POR_VAR_ANIO_ANT
                                              )
            VALUES (
                    j.order_id,
                    j.canal,
                    j.periodo,
                    j.cobranza,
                    j.ppto,
                    j.anioAnt,
                    j.varppto,
                    j.varant,
                    j.porvarppto,
                    j.porvarant
                    );
        END LOOP;
        FOR K IN 1..linIterations
        LOOP
            --postErrbuf  :=  'Error en linea 671';
            dbms_output.put_line('piinOrder: ' || K);
            dbms_output.put_line('piinCanal: ' || i.descanal);
            dbms_output.put_line('pistUserL: ' || pistUser);
            dbms_output.put_line('pistIter: ' || fecxc_get_cardinal_fn(K));
            dbms_output.put_line('pistAgrup: ' || fecxc_get_groupname_fn(piinIdAgrup));
            dbms_output.put_line('pistMonths: ' || fecxc_get_months_fn(piinIdAgrup,K));
            FOR l IN curPeriodo (K,i.descanal,pistUser,fecxc_get_cardinal_fn(K),fecxc_get_groupname_fn(piinIdAgrup),
                                    fecxc_get_months_fn(piinIdAgrup,K))
            LOOP
                dbms_output.put_line(l.order_id||'|'||l.canal||'|'||l.periodo||'|'||l.cobranza||'|'||l.ppto||'|'||
                    l.anioAnt||'|'||l.varppto||'|'||l.varant||'|'||l.porvarppto||'|'||l.porvarant);
                INSERT INTO FECXC_DIVXPERIODO_TAB (
                                                    ID_ORDER,
                                                    DES_CANAL,
                                                    DES_PERIODO,
                                                    NUM_REAL,
                                                    NUM_PPTO,
                                                    NUM_ANIO_ANT,
                                                    NUM_VAR_PPTO,
                                                    NUM_VAR_ANIO_ANT,
                                                    POR_VAR_PPTO,
                                                    POR_VAR_ANIO_ANT
                                                  )
                VALUES (
                        l.order_id,
                        l.canal,
                        l.periodo,
                        l.cobranza,
                        l.ppto,
                        l.anioAnt,
                        l.varppto,
                        l.varant,
                        l.porvarppto,
                        l.porvarant
                        );
            END LOOP;
        END LOOP;
        --postErrbuf  :=  'Error en linea 712';
        FOR M IN linMonthBegin..linFinalMonth
        LOOP
            dbms_output.put_line('m:'||M);
            FOR o IN curPeriodo (M,i.descanal,pistUser,fecxc_get_cardinal_fn('0'),fecxc_get_monthname_fn(M),M)
            LOOP
                dbms_output.put_line(o.order_id||'|'||o.canal||'|'||o.periodo||'|'||o.cobranza||'|'||o.ppto||'|'||
                    o.anioAnt||'|'||o.varppto||'|'||o.varant||'|'||o.porvarppto||'|'||o.porvarant);
                INSERT INTO FECXC_DIVXPERIODO_TAB (
                                                    ID_ORDER,
                                                    DES_CANAL,
                                                    DES_PERIODO,
                                                    NUM_REAL,
                                                    NUM_PPTO,
                                                    NUM_ANIO_ANT,
                                                    NUM_VAR_PPTO,
                                                    NUM_VAR_ANIO_ANT,
                                                    POR_VAR_PPTO,
                                                    POR_VAR_ANIO_ANT
                                                  )
                VALUES (
                        o.order_id,
                        o.canal,
                        o.periodo,
                        o.cobranza,
                        o.ppto,
                        o.anioAnt,
                        o.varppto,
                        o.varant,
                        o.porvarppto,
                        o.porvarant
                        );
            END LOOP;
        END LOOP;
    END LOOP;
    FOR n IN curTotalGeneral
    LOOP
        dbms_output.put_line(n.order_id||'|'||n.canal||'|'||n.periodo||'|'||n.cobranza||'|'||n.ppto||'|'||
            n.anioAnt||'|'||n.varppto||'|'||n.varant||'|'||n.porvarppto||'|'||n.porvarant);
        --postErrbuf  :=  'Error en linea 756';
        INSERT INTO FECXC_DIVXPERIODO_TAB (
                                            ID_ORDER,
                                            DES_CANAL,
                                            DES_PERIODO,
                                            NUM_REAL,
                                            NUM_PPTO,
                                            NUM_ANIO_ANT,
                                            NUM_VAR_PPTO,
                                            NUM_VAR_ANIO_ANT,
                                            POR_VAR_PPTO,
                                            POR_VAR_ANIO_ANT
                                          )
        VALUES (
                n.order_id,
                n.canal,
                n.periodo,
                n.cobranza,
                n.ppto,
                n.anioAnt,
                n.varppto,
                n.varant,
                n.porvarppto,
                n.porvarant
                );
    END LOOP;
    COMMIT;
    postRetcode := '0';
EXCEPTION
    WHEN OTHERS
    THEN
        postErrbuf  :=  'No se produjo informaci?n.' || SQLERRM;
        postRetcode :=  SQLCODE;
        dbms_output.put_line('Error:'||TO_CHAR(postRetcode));
        dbms_output.put_line(postErrbuf);
        ROLLBACK;
END;
FUNCTION fecxc_fill_divxperiodo_disc_fn (
                                            piinIdAgrup       IN NUMBER,
                                            piinFormat        IN NUMBER,
                                            pistUser          IN VARCHAR2,
                                            piinSegment       IN NUMBER
                                         )
RETURN VARCHAR2
IS
    lstPostErrbuf       VARCHAR2(2000);
    lstPostRetcode      VARCHAR2(30);
BEGIN
    fecxc_fill_divxperiodo_disc_pr (
                                            lstPostErrbuf,
                                            lstPostRetcode,
                                            piinIdAgrup,
                                            piinFormat,
                                            pistUser,
                                            piinSegment
                                         );
    RETURN NVL(lstPostErrbuf, 'OK');
EXCEPTION
    WHEN OTHERS
    THEN
        RETURN 'Error: ' || SQLERRM;
END;
FUNCTION fecxc_get_months_fn (
                              piinIdAgrup    NUMBER,
                              piinNumElement NUMBER
                              )
RETURN VARCHAR2
IS
BEGIN
    IF(piinIdAgrup = 6 AND piinNumElement = 1) THEN
        RETURN '1,2,3,4,5,6';
    ELSIF (piinIdAgrup = 6 AND piinNumElement = 2) THEN
        RETURN '7,8,9,10,11,12';
    ELSIF (piinIdAgrup = 3 AND piinNumElement = 1) THEN
        RETURN '1,2,3';
    ELSIF (piinIdAgrup = 3 AND piinNumElement = 2) THEN
        RETURN '4,5,6';
    ELSIF (piinIdAgrup = 3 AND piinNumElement = 3) THEN
        RETURN '7,8,9';
    ELSIF (piinIdAgrup = 3 AND piinNumElement = 4) THEN
        RETURN '10,11,12';
    ELSIF (piinIdAgrup = 2 AND piinNumElement = 1) THEN
        RETURN '1,2';
    ELSIF (piinIdAgrup = 2 AND piinNumElement = 2) THEN
        RETURN '3,4';
    ELSIF (piinIdAgrup = 2 AND piinNumElement = 3) THEN
        RETURN '5,6';
    ELSIF (piinIdAgrup = 2 AND piinNumElement = 4) THEN
        RETURN '7,8';
    ELSIF (piinIdAgrup = 2 AND piinNumElement = 5) THEN
        RETURN '9,10';
    ELSIF (piinIdAgrup = 2 AND piinNumElement = 6) THEN
        RETURN '11,12';
    END IF;
END;
FUNCTION fecxc_get_cardinal_fn (
                                piinNumElement    NUMBER
                               )
RETURN VARCHAR2
IS
BEGIN
    IF(piinNumElement = 1) THEN
        RETURN 'Primer';
    ELSIF (piinNumElement = 2) THEN
        RETURN 'Segundo';
    ELSIF (piinNumElement = 3) THEN
        RETURN 'Tercer';
    ELSIF (piinNumElement = 4) THEN
        RETURN 'Cuarto';
    ELSIF (piinNumElement = 5) THEN
        RETURN 'Quinto';
    ELSIF (piinNumElement = 6) THEN
        RETURN 'Sexto';
    ELSE
        RETURN NULL;
    END IF;
END;
FUNCTION fecxc_get_groupname_fn (
                                 piinIdAgrup    NUMBER
                                )
RETURN VARCHAR2
IS
BEGIN
    IF(piinIdAgrup = 6) THEN
        RETURN 'Semestre';
    ELSIF (piinIdAgrup = 3) THEN
        RETURN 'Trimestre';
    ELSIF (piinIdAgrup = 2) THEN
        RETURN 'Bimestre';
    ELSE
        RETURN NULL;
    END IF;
END;
FUNCTION fecxc_get_monthname_fn (
                                 piinIdMonth    NUMBER
                                )
RETURN VARCHAR2
IS
BEGIN
    IF(piinIdMonth = 1) THEN
        RETURN 'Enero';
    ELSIF (piinIdMonth = 2) THEN
        RETURN 'Febrero';
    ELSIF (piinIdMonth = 3) THEN
        RETURN 'Marzo';
    ELSIF (piinIdMonth = 4) THEN
        RETURN 'Abril';
    ELSIF (piinIdMonth = 5) THEN
        RETURN 'Mayo';
    ELSIF (piinIdMonth = 6) THEN
        RETURN 'Junio';
    ELSIF (piinIdMonth = 7) THEN
        RETURN 'Julio';
    ELSIF (piinIdMonth = 8) THEN
        RETURN 'Agosto';
    ELSIF (piinIdMonth = 9) THEN
        RETURN 'Septiembre';
    ELSIF (piinIdMonth = 10) THEN
        RETURN 'Octubre';
    ELSIF (piinIdMonth = 11) THEN
        RETURN 'Noviembre';
    ELSIF (piinIdMonth = 12) THEN
        RETURN 'Diciembre';
    END IF;
END;
FUNCTION in_list (p_in_list  IN  VARCHAR2)
RETURN t_in_list_tab PIPELINED
AS
    l_text  VARCHAR2(32767) := p_in_list || ',';
    l_idx   NUMBER;
BEGIN
    LOOP
      l_idx := INSTR(l_text, ',');
      EXIT WHEN NVL(l_idx, 0) = 0;
      PIPE ROW (TRIM(SUBSTR(l_text, 1, l_idx - 1)));
      l_text := SUBSTR(l_text, l_idx + 1);
    END LOOP;
  RETURN;
END;
FUNCTION isnumeric_fn (
                        pistValue IN VARCHAR2
                       )
RETURN NUMBER
AS
    linTestValue NUMERIC;
 BEGIN
    linTestValue := TO_NUMBER (pistValue);
    RETURN 1;
EXCEPTION
WHEN OTHERS THEN
    RETURN 0;
END;
FUNCTION FOLIOSET_FN (
                        PISTCONCEPTO IN VARCHAR2,
                        PINCODFOLIO  IN NUMBER
                       )
RETURN NUMBER
AS
lstFolioSet varchar2(100);
BEGIN
  IF PINCODFOLIO < 0
  THEN
    LSTFOLIOSET := SUBSTR(PISTCONCEPTO,0,INSTR(PISTCONCEPTO, ' '));
  ELSE
    RETURN NULL;
  END IF;
RETURN LSTFOLIOSET;
EXCEPTION
WHEN OTHERS THEN
    RETURN 0;
END FOLIOSET_FN;
END;
/;
