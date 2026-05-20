CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSAI"."SP_INSERTDETPCANR" (   numpco IN NUMBER,       keyemp IN NUMBER,       sexo IN VARCHAR2,
                                                            nomreal IN VARCHAR2,    apepat IN VARCHAR2,     apemat IN VARCHAR2,
                                                            regrfc VARCHAR2,        nomart IN VARCHAR2,     cranda IN NUMBER,
                                                            calle IN VARCHAR2,      numext IN VARCHAR2,     numint IN VARCHAR2,
                                                            colemp IN VARCHAR2,     codpos IN VARCHAR2,     munemp IN VARCHAR2,
                                                            cidemp IN VARCHAR2,     nacion IN VARCHAR2,     paisres IN VARCHAR2,
                                                            lugnac IN VARCHAR2,     telefono IN VARCHAR2,   edad IN NUMBER,
                                                            fecnac IN VARCHAR2,     calsind IN VARCHAR2,    calmig IN VARCHAR2,
                                                            clasif IN VARCHAR2,     tabulador IN NUMBER,    sindicato IN VARCHAR2,
                                                            siscon IN VARCHAR2,     fecgra IN VARCHAR2,     person IN VARCHAR2,
                                                            numcap IN VARCHAR2,     tabulade IN NUMBER,     padiftab IN NUMBER,
                                                            totcap IN NUMBER,       conjunto IN VARCHAR2,   idioma IN VARCHAR2,
                                                            tipval IN NUMBER,       tipopago IN NUMBER,     stsreg IN NUMBER,
                                                            recurp IN VARCHAR2,     chklst IN VARCHAR2,     numllamados IN NUMBER,
                                                            cvenacdad IN VARCHAR2,  sigID OUT NUMBER )
--Se agrega el argumento final numllamados, para guardar el numero de llamados del contrato, y la clave de la nacionalidad(para regimen fiscal) (IG-CONS-0823)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
    cont NUMBER;
BEGIN
    sigID := 0;
    cont  := 0;
    SELECT COUNT(*) INTO cont
    FROM encpcanr
    WHERE epc_numpco = numpco;
    IF cont >= 1 THEN
                    SELECT COALESCE(MAX(dpc_idereg),0) + 1 INTO sigID
                    FROM detpcanr
                    WHERE dpc_numpco = numpco;
                    INSERT INTO detpcanr(   dpc_numpco,     dpc_idereg,     dpc_keyemp,     dpc_sexo,       dpc_nomreal,    dpc_apepat,     dpc_apemat,     dpc_regrfc,
                                            dpc_nomart,     dpc_cranda,     dpc_domemp,     dpc_numext,     dpc_numint,     dpc_colemp,     dpc_codpos,     dpc_munemp,
                                            dpc_cidemp,     dpc_nacion,     dpc_paisres,    dpc_lugnac,     dpc_telefono,   dpc_edad,       dpc_fecnac,     dpc_calsind,
                                            dpc_calmig,     dpc_clasif,     dpc_tabulador,  dpc_sindicato,  dpc_siscon,     dpc_fecgra,     dpc_person,     dpc_numcap,
                                            dpc_tabulade,   dpc_padiftab,   dpc_totcap,     dpc_conjunto,   dpc_idioma,     dpc_tipval,     dpc_tipopago,   dpc_stsreg,
                                            dpc_recurp,     dpc_chklst,     dpc_numllama,   dpc_cvenacdad)
                    VALUES(                 numpco,         sigID,          keyemp,         sexo,           nomreal,        apepat,         apemat,         regrfc,
                                            nomart,         cranda,         calle,          numext,         numint,         colemp,         codpos,         munemp,
                                            cidemp,         nacion,         paisres,        lugnac,         telefono,       edad,           TO_DATE(fecnac,'dd/mm/yyyy'), calsind,
                                            calmig,         clasif,         tabulador,      sindicato,      siscon,         TO_DATE(fecgra,'dd/mm/yyyy'), person, numcap,
                                            tabulade,       padiftab,       totcap,         conjunto,       idioma,         tipval,         tipopago,       stsreg,
                                            recurp,         chklst,         numllamados,    cvenacdad );
--Se agrega el campo dpc_numllama a la instruccion insert y se le asigna el valor del argumento numllamado, y la clave de la nacionalidad se asigna el argumento cvenacdad (IG-CONS-0823)
    END IF;
END;
/
