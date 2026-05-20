CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SP_AMORTIZACIONES" 
(keyper in nmlohism.his_keyper%TYPE, keypro in nmlohism.his_keypro%TYPE) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
  wn_res_pue AMORTIZACIONES.AMO_VALIDA%TYPE;
   --Igneos.I
  wn_tot_reg NUMBER;
  wn_cve_emp NUMBER;
  ws_cve_con VARCHAR(3);
  wn_ref_ere NUMBER(16,6);
  wn_imp_ort NUMBER(12,2);
  ws_cve_conceptos VARCHAR(100);
  ws_cve_cte VARCHAR(5);
  wd_fec_mov DATE;
  wn_dia_per NUMBER;
  importe VARCHAR2(12);
  proceso number;
  refere varchar(2);
  foliolabora VARCHAR(30);
  tipopago VARCHAR(10);
BEGIN
  wn_res_pue:='';
  wd_fec_mov:= SYSDATE;
  tipopago := ' ';
    select trim(pam_cvesec) INTO ws_cve_cte from glcopams
    where pam_keypar = 'CFIN'
    and pam_folfin = 'AMO';
  SELECT pro_diaper INTO wn_dia_per
    FROM nmloproc
    WHERE pro_keypro = keypro;
    IF wn_dia_per = 7 Then
        tipopago := 'SEMANA';
    Elsif wn_dia_per = 10 Then
        tipopago := 'DECENA';
    ElsIf wn_dia_per = 15 Then
        tipopago := 'QUINCENA';
    END IF;
    FOR reg IN (SELECT amo_keyemp, to_char(amo_keypro,'FM00') amo_keypro, emp_recurp, amo_keycon, amo_keypre, amo_imppag, to_char(pre_refere,'FM000') pre_refere,
                      nvl(substr(pam_nompar,1,50), ' ') descripcion, amo_ctreve, to_char(amo_numpag,'FM000') amo_numpag
            FROM nmloamor
            INNER JOIN nmcoempl on (amo_keyemp = emp_keyemp)
            INNER JOIN nmlopres on ( amo_keyemp = pre_keyemp and amo_keycon = pre_keycon and amo_keypre = pre_keypre)
            left outer join glcopams on (pam_keypar = 'AM' and pam_cvesec = amo_tiptra)
            Where pre_ca2aux = '1'
            AND amo_imppag > 0
            AND amo_keyper = keyper
            AND amo_keypro = keypro
            AND amo_keycon IN (SELECT pam_folini FROM glcopams
                               where pam_keypar = (SELECT pam_folini FROM glcopams
                                                   WHERE pam_cvesec = 'iinsaf'
                                                   AND pam_keypar = '00')
                                AND pam_folfin = 'AMO' || ws_cve_cte)
            )
    LOOP
    importe := SP_TOVARCHAR2(reg.amo_imppag);
    foliolabora := keyper || reg.amo_keypro || reg.amo_keyemp || reg.amo_keycon || reg.amo_numpag || reg.pre_refere ;
BEGIN
    select count(*) into wn_tot_reg from casolpagolabora
    where "IdFolioLABORA" = foliolabora;
    if wn_tot_reg = 0 then
      INSERT INTO casolpagolabora
      ("IdFolioLABORA", "Sesion", "NumCliente", "CveEmpleado", "NumNomina", "IdPrestamo", "MontoPago",
       "Interes", "FechaSol", "FechaApl", "Comentario", "IdEstatus", "CtrlEventos", "Nota", "Codigo2", "TipoPago")
       VALUES
      ( foliolabora ,' ', ws_cve_cte , reg.emp_recurp, reg.amo_keyemp, reg.pre_refere, importe,
      0, wd_fec_mov, wd_fec_mov, reg.descripcion, 15008, reg.amo_ctreve, ' ', reg.amo_keycon, tipopago);
    end if;
    commit;
EXCEPTION
  WHEN OTHERS THEN
    NULL;
END;
    END LOOP;
END;
/
