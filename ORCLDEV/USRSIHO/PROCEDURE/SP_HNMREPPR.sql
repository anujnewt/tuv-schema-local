CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_HNMREPPR" (vs_nom_rep VARCHAR2,vs_ide_pcc VARCHAR2,
                             vn_key_usu NUMBER) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
   --SIPROS, S. A. DE C. V.
   --Sistema  : RH-2000  C/S
   --Modulo     --Programa : sp_hnmreppr
   --           Reporte concentrado de cifras de control
   --Autor    : Jesus Nu??Arciga
   --Fecha    : 8 de Noviembre de 1999
   --MODIFICO : AEDO 23/Nov/05 se agrego el tipo de moneda, el importe y el tipo de cambio
   lnKeyRph NUMBER(10);
   lnTotCos NUMBER(18,2);
BEGIN
-- Ajusta la informaci??e incidencias
   FOR rec IN (Select frp_keyrph,Sum(gdp_cosuni*gdp_numcap) suma
           From USRSIHO.holofrph,USRSIHO.hologdpr
           Where frp_keyrph = gdp_keyrph
           Group by frp_keyrph,frp_totcos
           Having ABS(Sum(gdp_cosuni*gdp_numcap) - frp_totcos) >= 1
           ORDER BY frp_keyrph) LOOP
      lnKeyRph := rec.frp_keyrph;
      lnTotCos := rec.suma;
      Update USRSIHO.holofrph
      Set frp_totcos = lnTotCos
      Where frp_keyrph = lnKeyRph;
   END LOOP;
INSERT INTO USRSIHO.glwkcrys(cry_nomrep,cry_idepcc,cry_keyusu,cry_dec006,
                     cry_dec007,cry_dec008,cry_chr020,cry_dec001,
                     cry_dec009,cry_chr001,cry_chr002,cry_chr021,
                     cry_chr004,cry_dec010,cry_chr005,cry_dec011,
                     cry_chr019,cry_dec014,cry_dec003)    -- el ultimo era cry_dec015
SELECT ran_nomrep, ran_idepcc, ran_keyusu, ran_keyemp,
       ran_keycen, gdp_numcap, gdp_keycon, gdp_cosuni,
       nom_keynom, nom_destip, con_descon, con_codimp,
       pam_nompar, cia_keycia, substr(cia_descia,1,40), gdp_keyemp,
       decode(frp_tipcam,1.0000,'Pesos','Dolares'),
       (gdp_cosuni/frp_tipcam), frp_tipcam
FROM USRSIHO.glwkrang, USRSIHO.nmlonomi, USRSIHO.holofrph, USRSIHO.hologdpr, USRSIHO.nmloconc,
     USRSIHO.nmcodeps, USRSIHO.glcopams, USRSIHO.nmlocias, USRSIHO.nmloproc
WHERE ran_keyemp = frp_keyrph AND
      frp_keyrph = gdp_keyrph AND
      frp_keynom = nom_keynom AND
      frp_keydep = dep_keydep AND
      gdp_keycon = con_keycon AND
      pro_keycia = cia_keycia AND
      pam_keypar ='H2' AND
      pam_cvesec = ran_keycen AND
      pro_keypro = ran_keypro AND
      ran_nomrep = vs_nom_rep AND
      ran_idepcc = vs_ide_pcc AND
      ran_keyusu = vn_key_usu;
END;
/
