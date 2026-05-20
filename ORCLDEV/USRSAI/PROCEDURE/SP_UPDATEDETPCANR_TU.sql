CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSAI"."SP_UPDATEDETPCANR_TU" 
                                                        (   numpco IN NUMBER,       idereg IN NUMBER,       keyemp IN NUMBER,       sexo IN VARCHAR2,
                                                            nomreal IN VARCHAR2,    apepat IN VARCHAR2,     apemat IN VARCHAR2,     regrfc IN VARCHAR2,
                                                            nomart IN VARCHAR2,     cranda IN VARCHAR2,     calle IN VARCHAR2,      numext IN VARCHAR2,
                                                            numint IN VARCHAR2,     colemp IN VARCHAR2,     codpos IN VARCHAR2,     munemp IN VARCHAR2,
                                                            cidemp IN VARCHAR2,     nacion IN VARCHAR2,     paisres IN VARCHAR2,    lugnac IN VARCHAR2,
                                                            telefono IN VARCHAR2,   edad IN NUMBER,         fecnac IN VARCHAR2,     calsind IN VARCHAR2,
                                                            calmig IN VARCHAR2,     clasif IN VARCHAR2,     tabulador IN NUMBER,    sindicato IN VARCHAR2,
                                                            siscon IN VARCHAR2,     fecgra VARCHAR2,        person IN VARCHAR2,     numcap IN VARCHAR2,
                                                            tabulade IN NUMBER,     padiftab IN NUMBER,     totcap IN NUMBER,       conjunto IN VARCHAR2,
                                                            idioma IN VARCHAR2,     tipval IN NUMBER,       tipopago IN NUMBER,     stsreg IN NUMBER,
                                                            recurp IN VARCHAR2,     chklst IN VARCHAR2,     cvenacdad IN VARCHAR2,  cont OUT NUMBER)
    IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
                               SELECT COALESCE(COUNT(*), 0) INTO cont FROM detpcanr
                               WHERE dpc_idereg = idereg AND dpc_numpco = numpco;
                IF cont >= 1 THEN
                               UPDATE detpcanr
                               SET dpc_keyemp = keyemp,
                                                dpc_sexo = sexo,
                                                dpc_nomreal = nomreal,
                                                dpc_apepat = apepat,
                                                dpc_apemat = apemat,
                                                dpc_regrfc = regrfc,
                                                dpc_nomart = nomart,
                                                dpc_cranda = cranda,
                                                dpc_domemp = calle,
                                                dpc_numext = numext,
                                                dpc_numint = numint,
                                                dpc_colemp = colemp,
                                                dpc_codpos = codpos,
                                                dpc_munemp = munemp,
                                                dpc_cidemp = cidemp,
                                                dpc_nacion = nacion,
                                                dpc_paisres = paisres,
                                                dpc_lugnac = lugnac,
                                                dpc_telefono = telefono,
                                                dpc_edad = edad,
                                                dpc_fecnac = TO_DATE(fecnac,'dd/mm/yyyy'),
                                                dpc_calsind = calsind,
                                                dpc_calmig = calmig,
                                                dpc_clasif = clasif,
                                                dpc_tabulador = tabulador,
                                                dpc_sindicato = sindicato,
                                                dpc_siscon = siscon,
                                                dpc_fecgra = TO_DATE(fecgra,'dd/mm/yyyy'),
                                                dpc_person = person,
                                                dpc_numcap = numcap,
                                                dpc_tabulade = tabulade,
                                                dpc_padiftab = padiftab,
                                                dpc_totcap = totcap,
                                                dpc_conjunto = conjunto,
                                                dpc_idioma = idioma,
                                                dpc_tipval = tipval,
                                                dpc_tipopago = tipopago,
                                                dpc_stsreg = stsreg,
                                                dpc_recurp = recurp,
                                                dpc_chklst = chklst,
                                                dpc_cvenacdad = cvenacdad
                               WHERE dpc_idereg = idereg
                                               AND dpc_numpco = numpco;
                 END IF;
END;
/
