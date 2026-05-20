CREATE OR REPLACE EDITIONABLE FUNCTION "XXMOR"."XXMOR_EXISTE_FZA_VTAS_FN" 
                                 (
                                         P_I_ID_FZA_VTAS IN NUMBER,
                                         P_I_AGRUPADOR   IN VARCHAR2,
                                         P_I_REGION      IN VARCHAR2,
                                         P_I_SUFIJO      IN VARCHAR2,
                                         P_I_ACCTHDRID   IN VARCHAR2,
                                         P_I_USRCHR      IN VARCHAR2,
                                         P_I_SPTCHR      IN VARCHAR2,
                                         P_I_INCLUSION   IN NUMBER
                                 ) RETURN NUMBER IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    -- Cursor para verificar si la combinaci?
    -- existe.
    CURSOR CUR_VALIDA_COMBINACION(P_INCLUSION IN NUMBER) IS
        SELECT V.ID_FZA_VENTAS
        FROM   XXMOR_FZAS_VENTAS_IDS_VW V
        WHERE  V.AGRUPADOR        = P_I_AGRUPADOR
        AND    V.REGION           = P_I_REGION
        AND    NVL(v.SUFIJO,'*')  = NVL(P_I_SUFIJO,'*')
        AND    NVL(v.CLIENTE,'*') = NVL(P_I_ACCTHDRID,'*')
        AND    NVL(V.USRCHR,'|')  = NVL(P_I_USRCHR,'|')
        AND    V.SPTCHR           = P_I_SPTCHR
        AND    V.INCLUSION        = P_INCLUSION;
    lin_fza_ventas      NUMBER;
    BEGIN
        OPEN CUR_VALIDA_COMBINACION(P_I_INCLUSION);
            FETCH CUR_VALIDA_COMBINACION
            INTO  lin_fza_ventas;
        IF CUR_VALIDA_COMBINACION%NOTFOUND THEN
            CLOSE CUR_VALIDA_COMBINACION;
            lin_fza_ventas := 0;
            /*IF P_I_INCLUSION = 0 THEN
                OPEN CUR_VALIDA_COMBINACION(1);
                    FETCH CUR_VALIDA_COMBINACION
                    INTO  lin_fza_ventas;
                IF CUR_VALIDA_COMBINACION%NOTFOUND THEN
                    lin_fza_ventas := 0;
                END IF;
                CLOSE CUR_VALIDA_COMBINACION;
            ELSE
                OPEN CUR_VALIDA_COMBINACION(0);
                    FETCH CUR_VALIDA_COMBINACION
                    INTO  lin_fza_ventas;
                IF CUR_VALIDA_COMBINACION%NOTFOUND THEN
                    lin_fza_ventas := 0;
                END IF;
                CLOSE CUR_VALIDA_COMBINACION;
            END IF;*/
        END IF;
        /*IF lin_fza_ventas > 0 THEN
            IF lin_fza_ventas = P_I_ID_FZA_VTAS THEN
               lin_fza_ventas := 2;
            ELSE
               lin_fza_ventas := 1;
            END IF;
        END IF;*/
        RETURN NVL(lin_fza_ventas,0);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 0;
    END XXMOR_EXISTE_FZA_VTAS_FN;
/
--Source_DDLS

  CREATE OR REPLACE EDITIONABLE FUNCTION "XXMOR"."XXMOR_EXISTE_FZA_VTAS_FN" 
                                 (
                                         P_I_ID_FZA_VTAS IN NUMBER,
                                         P_I_AGRUPADOR   IN VARCHAR2,
                                         P_I_REGION      IN VARCHAR2,
                                         P_I_SUFIJO      IN VARCHAR2,
                                         P_I_ACCTHDRID   IN VARCHAR2,
                                         P_I_USRCHR      IN VARCHAR2,
                                         P_I_SPTCHR      IN VARCHAR2,
                                         P_I_INCLUSION   IN NUMBER
                                 ) RETURN NUMBER IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    -- Cursor para verificar si la combinaci?
    -- existe.
    CURSOR CUR_VALIDA_COMBINACION(P_INCLUSION IN NUMBER) IS
        SELECT V.ID_FZA_VENTAS
        FROM   XXMOR_FZAS_VENTAS_IDS_VW V
        WHERE  V.AGRUPADOR        = P_I_AGRUPADOR
        AND    V.REGION           = P_I_REGION
        AND    NVL(v.SUFIJO,'*')  = NVL(P_I_SUFIJO,'*')
        AND    NVL(v.CLIENTE,'*') = NVL(P_I_ACCTHDRID,'*')
        AND    NVL(V.USRCHR,'|')  = NVL(P_I_USRCHR,'|')
        AND    V.SPTCHR           = P_I_SPTCHR
        AND    V.INCLUSION        = P_INCLUSION;
    lin_fza_ventas      NUMBER;
    BEGIN
        OPEN CUR_VALIDA_COMBINACION(P_I_INCLUSION);
            FETCH CUR_VALIDA_COMBINACION
            INTO  lin_fza_ventas;
        IF CUR_VALIDA_COMBINACION%NOTFOUND THEN
            CLOSE CUR_VALIDA_COMBINACION;
            lin_fza_ventas := 0;
            /*IF P_I_INCLUSION = 0 THEN
                OPEN CUR_VALIDA_COMBINACION(1);
                    FETCH CUR_VALIDA_COMBINACION
                    INTO  lin_fza_ventas;
                IF CUR_VALIDA_COMBINACION%NOTFOUND THEN
                    lin_fza_ventas := 0;
                END IF;
                CLOSE CUR_VALIDA_COMBINACION;
            ELSE
                OPEN CUR_VALIDA_COMBINACION(0);
                    FETCH CUR_VALIDA_COMBINACION
                    INTO  lin_fza_ventas;
                IF CUR_VALIDA_COMBINACION%NOTFOUND THEN
                    lin_fza_ventas := 0;
                END IF;
                CLOSE CUR_VALIDA_COMBINACION;
            END IF;*/
        END IF;
        /*IF lin_fza_ventas > 0 THEN
            IF lin_fza_ventas = P_I_ID_FZA_VTAS THEN
               lin_fza_ventas := 2;
            ELSE
               lin_fza_ventas := 1;
            END IF;
        END IF;*/
        RETURN NVL(lin_fza_ventas,0);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 0;
    END XXMOR_EXISTE_FZA_VTAS_FN;
/
