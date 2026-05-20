CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SP_GEN_REG_PRESTAMO" 
                (wn_key_emp IN NUMBER,
                 ws_key_con IN VARCHAR2,
                 ws_ref_ere IN VARCHAR2,
                 wn_imp_ort IN NUMBER,
                 wd_fec_ope IN DATE,
                 ws_ref_amo IN VARCHAR2,
                 ws_ven_num IN VARCHAR2,
                 ws_ven_cod IN VARCHAR2,
                 ws_men_err OUT VARCHAR2)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    ws_key_per VARCHAR2(7);
    ws_tip_ope VARCHAR2(1) := '+';
    ws_tip_mon VARCHAR2(1) := 'M';
    wn_tip_cam NUMBER(11,4) := 1;
    ws_tip_reg VARCHAR2(1) :='A';
    wn_key_pro INTEGER;
    ws_sta_tus VARCHAR2(1) := '1';
    wd_fec_car DATE := SYSDATE;
    ws_sta_car VARCHAR2(1) := 'P';
    wn_key_pre NUMBER(16,6);
    wx_error EXCEPTION;
BEGIN
    ws_men_err := '';
    BEGIN
        SELECT emp_keypro INTO wn_key_pro
        FROM    LABPROD.nmcoempl
        WHERE   emp_keyemp = wn_key_emp;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            BEGIN
                ws_men_err := 'EMPLEADO NO EXISTE';
                RETURN;
            END;
    END;
    BEGIN
        -- Busca el periodo correspondiente
        SELECT  per_keyper
        INTO    ws_key_per
        FROM    LABPROD.nmloperi
        WHERE   per_keypro = wn_key_pro
        AND     per_fecini <= wd_fec_ope
        AND     per_fecfin >= wd_fec_ope
        AND     per_keynom = 1;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
            BEGIN
                ws_men_err := 'NO EXISTE PERIODO PARA LA FECHA '||WD_FEC_OPE;
                RETURN;
            END;
    END;
    SELECT labprod.nmlopres_seq.nextval INTO wn_key_pre from dual;
    INSERT INTO LABPROD.ap_sipros
        (
            soi_keyemp,  soi_keycon,  soi_refere,  soi_tipope,
            soi_import,  soi_fecope,  soi_tipmon,  soi_tipcam,
            soi_tipreg,  soi_keypre,  soi_keypro,  soi_status,
            soi_feccar,  soi_stacar,  soi_refamo,  soi_vennum,
            soi_vencod
        )
    VALUES
        (
            wn_key_emp,  ws_key_con,  ws_ref_ere,  ws_tip_ope,
            wn_imp_ort,  wd_fec_ope,  ws_tip_mon,  wn_tip_cam,
            ws_tip_reg,  wn_key_pre,  wn_key_pro,  ws_sta_tus,
            wd_fec_car,  ws_sta_car,  ws_ref_amo,  ws_ven_num,
            ws_ven_cod
        );
    INSERT INTO LABPROD.nmlopres
        (
            pre_keyemp,     pre_keycon,     pre_keypre,     pre_refere,
            pre_fecreg,     pre_tippre,     pre_unipre,     pre_imppre,
            pre_gastos,     pre_plazop,     pre_unides,     pre_impdes,
            pre_porint,     pre_perini,     pre_fecini,     pre_fecaut,
            pre_cveaut,     pre_fechab,     pre_uniamo,     pre_impamo,
            pre_unisal,     pre_impsal,     pre_uniult,     pre_impult,
            pre_numpag,     pre_intpag,     pre_status,     pre_ultact,
            pre_refcon,     pre_ctreve,     pre_fe1aux,     pre_fe2aux,
            pre_ca1aux,     pre_ca2aux,     pre_ca3aux,     pre_ca4aux,
            pre_uniope,     pre_keypro,     pre_impnoa,     pre_pernoa
        )
        VALUES
        (
            wn_key_emp,     ws_key_con,     wn_key_pre,     ws_ref_ere,
            wd_fec_car,     1,              NULL,           wn_imp_ort,
            NULL,           1,              NULL,           wn_imp_ort,
            0,              ws_key_per,     wd_fec_ope,     wd_fec_ope,
            NULL,           NULL,           0,              0,
            0,              wn_imp_ort,     0,              0,
            0,              0,              2,              wd_fec_ope,
            NULL,           ws_ref_amo,     NULL,           NULL,
            ws_tip_mon,     wn_tip_cam,     NULL,           NULL,
            NULL,           wn_key_pro,     0,              NULL
        );
    COMMIT;
    ws_men_err := 'INSERTADO';
    EXCEPTION
        WHEN OTHERS THEN ws_men_err := 'ERROR: '||SQLCODE||' : '||SQLERRM;
END;
/
