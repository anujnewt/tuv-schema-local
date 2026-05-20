CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SP_I_VACEMP" (
     vb_keyemp integer
)
IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
 nkeyemp          INTEGER;
 ckeydep          varchar2(16);
 ckeypue          varchar2(16);
     ckeycon          varchar2(3);
     cpereje          varchar2(7);
     iexistecon       INTEGER;
     nagnostrab       INTEGER;
     nagnostrab2       INTEGER;
     nagnostrab3       INTEGER;
     cagnohoy         varchar2(04);
     cagnohoy2        varchar2(04);
     craya            varchar2(01);
     cagnosig         varchar2(04);
     cagnosig2        varchar2(04);
     cmes             varchar2(02);
     cdia             varchar2(02);
     cagno            varchar2(04);
     nkeypro          INTEGER;
     iContinuo        INTEGER;
     idiasvacacion    INTEGER;
     cfecha           varchar2(10);
     dfechaold        DATE;
     dfechanew        DATE;
     dfecha           DATE;
     cperiodo         varchar2(10);
     iexiste          INTEGER;
     idtomad          INTEGER;
     idia             INTEGER;
     ws_pva_stapas    varchar2(30);
     wd_vac_salper    DECIMAL(10,2);
     iRegLei          INTEGER;
     iRegIns          INTEGER;
     iRegUpd          INTEGER;
     iRegFijP         INTEGER;
     iRegFijN         INTEGER;
     idiasvac         INTEGER;
     idias_xano       DECIMAL(10,2);
     ws_pva_plapre    DECIMAL(10,2);
 iagnohoy INTEGER;
 iagnosig INTEGER;
 ws_vac_status varchar2(02);
 ws_tab_keytab varchar2(03);
 wn_confianza  SMALLINT;
 p_future_date DATE;
 p_adj_days    SMALLINT;
 dfecini       DATE;
 dfecnow       DATE;
 wd_fecaux1    DATE;
 wd_fecnow1    DATE;
 ws_dia	     varchar2(02);
 ws_mes	     varchar2(02);
 ws_ano	     varchar2(04);
 ndagnostrab   DECIMAL(12,6);
 iconsec INTEGER;
 basura  varchar2(40);
 conta   INTEGER;
BEGIN
iconsec := 1;
conta := 1;
-- Limpio Variables
iRegLei:= 0;
iRegIns:= 0;
iRegUpd:= 0;
iRegFijP:= 0;
iRegFijN:= 0;
idias_xano:= '365.25';
-- CARSI
--delete from nmcorvac;
--delete from nmcocvac;
delete from borra;
--delete from borra2;
-- **** Cursor ****
nkeyemp:=0;
nkeypro:=0;
   SELECT emp_keyemp,
          emp_keypro,
          emp_keydep,
          emp_keypue
     INTO nkeyemp,
          nkeypro,
          ckeydep,
          ckeypue
     FROM nmcoempl
    WHERE emp_status=1
     AND emp_keyemp=vb_keyemp;
    wd_vac_salper:= '0.0';
    -- Actualizo la Tabla de Datos Fijos
     BEGIN
        SELECT dat_valpar  into ws_pva_stapas
        FROM   nmlodata
        WHERE  dat_keyemp = nkeyemp
               and dat_keypar='28';
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
             ws_pva_stapas:='N';
     END;
    IF ws_pva_stapas = 'S' THEN
       SELECT SUM(vac_salper) INTO wd_vac_salper
       FROM   nmcocvac
       WHERE  vac_status IN ('V','A','P')
       AND    vac_keyemp = nkeyemp;
       iRegFijP:= iRegFijP + 1;
    ELSE
       SELECT SUM(vac_salper) INTO wd_vac_salper
       FROM   nmcocvac
       WHERE  vac_status IN ('V','A')
       AND    vac_keyemp = nkeyemp;
       iRegFijN:= iRegFijN + 1;
    END IF;
     iexistecon :=0;
            SELECT pva_connom
              INTO ckeycon
              FROM nmcopvac
             WHERE pva_keypro=nkeypro;
     SELECT pro_pereje
       INTO cpereje
       FROM nmloproc
      WHERE pro_keypro=nkeypro;
     SELECT dfi_keyemp
       INTO iexistecon
       FROM nmlodfij
      WHERE dfi_keycon=ckeycon
        AND dfi_keyemp=nkeyemp
        AND dfi_keypro=nkeypro;
  IF ckeycon IS NOT NULL THEN
    IF iexistecon IS NULL THEN
        INSERT INTO nmlodfij
        VALUES(nkeyemp,ckeycon,nkeypro,cpereje,2020999,ckeydep,
               ckeypue,sysdate,wd_vac_salper,0.0,'','');
    ELSE
          UPDATE nmlodfij
             SET    dfi_cantid = wd_vac_salper
           WHERE  dfi_keyemp = nkeyemp
             AND    dfi_keycon =ckeycon
             AND    dfi_keypro = nkeypro ;
    END IF;
  END IF;
END;
/
