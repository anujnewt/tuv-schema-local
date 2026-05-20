CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SP_NMREGINC" (pn_key_emp  IN NUMBER,
                                        ps_tip_inc IN VARCHAR2,
                                        pn_num_dias IN NUMBER,
                                        pd_fecha_inicial IN DATE) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
wd_fec_fin DATE;
wn_id NUMBER;
BEGIN
    wd_fec_fin := pd_fecha_inicial + pn_num_dias - 1;
    wn_id := 0;
    FOR q_inicio IN (SELECT ID
                      FROM TVPBINCC
                      WHERE INC_KEYEMP = pn_key_emp
                        AND INC_TIPINC = ps_tip_inc
                        AND ((INC_FECINI - 1 <= pd_fecha_inicial AND INC_FECFIN + 1 >= pd_fecha_inicial)
                          OR (INC_FECFIN + 1 <= wd_fec_fin AND INC_FECINI - 1 >= wd_fec_fin))) LOOP
        wn_id := q_inicio.ID;
        EXIT;
    END LOOP;
    IF wn_id = 0 THEN
        INSERT INTO TVPBINCC (INC_KEYEMP,INC_DIAINC,INC_TIPINC,INC_FECINI,INC_FECFIN,INC_FECMOD)
                      VALUES (pn_key_emp,pn_num_dias,ps_tip_inc,pd_fecha_inicial, pd_fecha_inicial + pn_num_dias -1,SYSDATE);
    ELSE
        UPDATE TVPBINCC SET INC_FECINI = CASE WHEN INC_FECINI > pd_fecha_inicial THEN pd_fecha_inicial ELSE INC_FECINI END,
                            INC_FECFIN = CASE WHEN INC_FECFIN < wd_fec_fin THEN wd_fec_fin ELSE INC_FECINI END,
                            INC_DIAINC = (CASE WHEN INC_FECFIN < wd_fec_fin THEN wd_fec_fin ELSE INC_FECINI END) -(CASE WHEN INC_FECINI > pd_fecha_inicial THEN pd_fecha_inicial ELSE INC_FECINI END)  + 1,
                            INC_FECMOD = SYSDATE
        WHERE ID = wn_id;
    END IF;
END;
/
