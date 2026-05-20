CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_HRPDESIN_RPT" (vs_nom_rep VARCHAR2, vs_ide_pcc VARCHAR2,
                                 vn_key_usu NUMBER) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
   --SIPROS, S. A. DE C. V.
   --Sistema  : RH-2000  C/S
   --Modulo     --Programa : sp_hrpdesin_rpt copia de sp_hnmreppr
   --           Reporte concentrado de cifras de control
   --Autor    : Jesus Nu??Arciga
   --Fecha    : 8 de Noviembre de 1999
   --MODIFICO : AEDO 23/Nov/05 se agrego el tipo de moneda, el importe y el tipo de cambio
   --           AEDO 01/Nov/06 Se renombro, viene de hrpdesin
   lnKeyRph NUMBER(10);
   lnTotCos NUMBER(18,2);
BEGIN
-- Ajusta la informaci??e incidencias
   FOR rec IN (SELECT frp_keyrph, SUM(gdp_cosuni * gdp_numcap) SUMA
           FROM USRSIHO.holofrph, USRSIHO.hologdpr
           WHERE frp_keyrph = gdp_keyrph
           GROUP BY frp_keyrph, frp_totcos
           HAVING ABS(Sum(gdp_cosuni * gdp_numcap) - frp_totcos) >= 1) LOOP
      lnKeyRph := rec.frp_keyrph;
      lnTotCos := rec.SUMA;
      UPDATE USRSIHO.holofrph
      SET frp_totcos = lnTotCos
      WHERE frp_keyrph = lnKeyRph;
   END LOOP;
--AEDO 06/Abril/06  se modifico la logica del tipo de moneda
---       decode(frp_tipcam,1.0000,"Pesos","Dolares"),
   INSERT INTO USRSIHO.glwkcrys(cry_nomrep,cry_idepcc,cry_keyusu,cry_dec006,
                        cry_dec007,cry_dec008,cry_chr020,cry_dec001,
                        cry_dec009,cry_chr001,cry_chr002,cry_chr021,
                        cry_chr004,cry_dec010,cry_chr005,cry_dec011,
                        cry_chr019,cry_dec014,cry_dec003)    -- el ultimo era cry_dec015
   SELECT ran_nomrep, ran_idepcc, ran_keyusu, ran_keyemp,
          ran_keycen, gdp_numcap, gdp_keycon, gdp_cosuni,
          nom_keynom, nom_destip, con_descon, con_codimp,
          ma.pam_nompar, cia_keycia, SUBSTR(cia_descia,1,40), gdp_keyemp,
          substr(tm.pam_folini,1,8), (gdp_cosuni/frp_tipcam), frp_tipcam
   FROM USRSIHO.glwkrang, USRSIHO.nmlonomi, USRSIHO.holofrph, USRSIHO.hologdpr, USRSIHO.nmloconc,
        USRSIHO.nmcodeps, USRSIHO.glcopams ma, USRSIHO.glcopams tm, USRSIHO.nmlocias, USRSIHO.nmloproc
   WHERE ran_keyemp = frp_keyrph
     AND frp_keyrph = gdp_keyrph
     AND frp_keynom = nom_keynom
     AND frp_keydep = dep_keydep
     AND gdp_keycon = con_keycon
     AND pro_keycia = cia_keycia
     AND tm.pam_keypar='H10'
     AND tm.pam_cvesec = frp_forpag
     AND ma.pam_keypar ='H2'
     AND ma.pam_cvesec = ran_keycen
     AND pro_keypro = ran_keypro
     AND ran_nomrep = vs_nom_rep
     AND ran_idepcc = vs_ide_pcc
     AND ran_keyusu = vn_key_usu;
END;
/
