CREATE OR REPLACE NONEDITIONABLE PROCEDURE "LABPROD"."SP_NMACTACUM" (ws_nom_rep IN VARCHAR2,ws_ide_pcc IN VARCHAR2,wn_key_usu IN NUMBER,wn_key_pro IN NUMBER,wn_num_mes IN NUMBER,ws_cod_acu IN VARCHAR2,wn_ani_oac IN NUMBER ) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
  --Insertar en la tabla de acumulados los registros faltantes
  INSERT INTO nmloacum
  SELECT DISTINCT his_keyemp,his_keycon,his_keypro,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,wn_ani_oac
      FROM nmlohism,nmloperi
      WHERE his_keypro = per_keypro and his_keyper = per_keyper
      AND per_keypro = wn_key_pro
      AND per_anioa1 = wn_ani_oac
      AND per_nummes = wn_num_mes
      AND his_codacu = ws_cod_acu
      AND his_keycon IN (SELECT ran_keycon FROM glwkrang
	                                               WHERE ran_nomrep=ws_nom_rep
	                                                 AND ran_idepcc=ws_ide_pcc
	                                                 AND ran_keyusu=wn_key_usu
	                                                 AND ran_keycon IS NOT NULL)
	    AND his_keyemp IN (SELECT ran_keyemp FROM glwkrang
	                                               WHERE ran_nomrep=ws_nom_rep
	                                                 AND ran_idepcc=ws_ide_pcc
	                                                 AND ran_keyusu=wn_key_usu
	                                                 AND ran_keyemp IS NOT NULL)
      AND NOT EXISTS (
                       SELECT acu_keyemp FROM nmloacum
                          WHERE acu_keypro =wn_key_pro
	                          AND acu_keyemp = his_keyemp
	                          AND acu_keycon = his_keycon
                            AND acu_anioac = per_anioa1);
  COMMIT;
  IF wn_num_mes = 1 THEN
	  UPDATE nmloacum SET acu_uniuno =
	      (
	      SELECT NVL(SUM(his_cantid),0)
	        FROM nmlohism,nmloperi
	        WHERE his_keypro = per_keypro and his_keyper = per_keyper
            AND per_keypro = wn_key_pro
            AND per_anioa1 = wn_ani_oac
            AND his_codacu = ws_cod_acu
            AND his_keycon = acu_keycon
            AND his_keypro = acu_keypro
            AND his_keyemp = acu_keyemp
            AND per_nummes = 1
        ),
        acu_impuno =
	      (
	      SELECT NVL(SUM(his_import),0)
	        FROM nmlohism,nmloperi
	        WHERE his_keypro = per_keypro and his_keyper = per_keyper
            AND per_keypro = wn_key_pro
            AND per_anioa1 = wn_ani_oac
            AND his_codacu = ws_cod_acu
            AND his_keycon = acu_keycon
            AND his_keypro = acu_keypro
            AND his_keyemp = acu_keyemp
            AND per_nummes = 1
        )
      WHERE acu_keypro =wn_key_pro
        AND acu_keycon IN (SELECT ran_keycon FROM glwkrang
                             WHERE ran_nomrep=ws_nom_rep
                               AND ran_idepcc=ws_ide_pcc
                               AND ran_keyusu=wn_key_usu
                               AND ran_keycon IS NOT NULL)
        AND acu_keyemp IN (SELECT ran_keyemp FROM glwkrang
                             WHERE ran_nomrep=ws_nom_rep
                               AND ran_idepcc=ws_ide_pcc
                               AND ran_keyusu=wn_key_usu
                               AND ran_keyemp IS NOT NULL )
       AND acu_anioac = wn_ani_oac;
  END IF;
  IF wn_num_mes = 2 THEN
    UPDATE nmloacum SET acu_unidos =
        (
        SELECT NVL(SUM(his_cantid),0)
          FROM nmlohism,nmloperi
          WHERE his_keypro = per_keypro and his_keyper = per_keyper
            AND per_keypro = wn_key_pro
            AND per_anioa1 = wn_ani_oac
            AND his_codacu = ws_cod_acu
            AND his_keycon = acu_keycon
            AND his_keypro = acu_keypro
            AND his_keyemp = acu_keyemp
            AND per_nummes = 2
        ),
        acu_impdos =
        (
        SELECT NVL(SUM(his_import),0)
          FROM nmlohism,nmloperi
          WHERE his_keypro = per_keypro and his_keyper = per_keyper
            AND per_keypro = wn_key_pro
            AND per_anioa1 = wn_ani_oac
            AND his_codacu = ws_cod_acu
            AND his_keycon = acu_keycon
            AND his_keypro = acu_keypro
            AND his_keyemp = acu_keyemp
            AND per_nummes = 2
        )
      WHERE acu_keypro =wn_key_pro
        AND acu_keycon IN (SELECT ran_keycon FROM glwkrang
                             WHERE ran_nomrep=ws_nom_rep
                               AND ran_idepcc=ws_ide_pcc
                               AND ran_keyusu=wn_key_usu
                               AND ran_keycon IS NOT NULL)
        AND acu_keyemp IN (SELECT ran_keyemp FROM glwkrang
                             WHERE ran_nomrep=ws_nom_rep
                               AND ran_idepcc=ws_ide_pcc
                               AND ran_keyusu=wn_key_usu
                               AND ran_keyemp IS NOT NULL )
        AND acu_anioac = wn_ani_oac;
  END IF;
  IF wn_num_mes = 3  THEN
    UPDATE nmloacum SET acu_unitre =
        (
        SELECT NVL(SUM(his_cantid),0)
          FROM nmlohism,nmloperi
          WHERE his_keypro = per_keypro and his_keyper = per_keyper
            AND per_keypro = wn_key_pro
            AND per_anioa1 = wn_ani_oac
            AND his_codacu = ws_cod_acu
            AND his_keycon = acu_keycon
            AND his_keypro = acu_keypro
            AND his_keyemp = acu_keyemp
            AND per_nummes = 3
        ),
        acu_imptre =
        (
        SELECT NVL(SUM(his_import),0)
          FROM nmlohism,nmloperi
          WHERE his_keypro = per_keypro and his_keyper = per_keyper
            AND per_keypro = wn_key_pro
            AND per_anioa1 = wn_ani_oac
            AND his_codacu = ws_cod_acu
            AND his_keycon = acu_keycon
            AND his_keypro = acu_keypro
            AND his_keyemp = acu_keyemp
            AND per_nummes = 3
        )
      WHERE acu_keypro =wn_key_pro
        AND acu_keycon IN (SELECT ran_keycon FROM glwkrang
                             WHERE ran_nomrep=ws_nom_rep
                               AND ran_idepcc=ws_ide_pcc
                               AND ran_keyusu=wn_key_usu
                               AND ran_keycon IS NOT NULL)
        AND acu_keyemp IN (SELECT ran_keyemp FROM glwkrang
                             WHERE ran_nomrep=ws_nom_rep
                               AND ran_idepcc=ws_ide_pcc
                               AND ran_keyusu=wn_key_usu
                               AND ran_keyemp IS NOT NULL )
        AND acu_anioac = wn_ani_oac;
  END IF;
  IF wn_num_mes = 4  THEN
    UPDATE nmloacum SET acu_unicua =
        (
        SELECT NVL(SUM(his_cantid),0)
          FROM nmlohism,nmloperi
          WHERE his_keypro = per_keypro and his_keyper = per_keyper
            AND per_keypro = wn_key_pro
            AND per_anioa1 = wn_ani_oac
            AND his_codacu = ws_cod_acu
            AND his_keycon = acu_keycon
            AND his_keypro = acu_keypro
            AND his_keyemp = acu_keyemp
            AND per_nummes = 4
        ),
        acu_impcua =
        (
        SELECT NVL(SUM(his_import),0)
          FROM nmlohism,nmloperi
          WHERE his_keypro = per_keypro and his_keyper = per_keyper
            AND per_keypro = wn_key_pro
            AND per_anioa1 = wn_ani_oac
            AND his_codacu = ws_cod_acu
            AND his_keycon = acu_keycon
            AND his_keypro = acu_keypro
            AND his_keyemp = acu_keyemp
            AND per_nummes = 4
        )
      WHERE acu_keypro =wn_key_pro
        AND acu_keycon IN (SELECT ran_keycon FROM glwkrang
                             WHERE ran_nomrep=ws_nom_rep
                               AND ran_idepcc=ws_ide_pcc
                               AND ran_keyusu=wn_key_usu
                               AND ran_keycon IS NOT NULL)
        AND acu_keyemp IN (SELECT ran_keyemp FROM glwkrang
                             WHERE ran_nomrep=ws_nom_rep
                               AND ran_idepcc=ws_ide_pcc
                               AND ran_keyusu=wn_key_usu
                               AND ran_keyemp IS NOT NULL )
        AND acu_anioac = wn_ani_oac;
  END IF;
  IF wn_num_mes = 5  THEN
    UPDATE nmloacum SET acu_unicin =
        (
        SELECT NVL(SUM(his_cantid),0)
          FROM nmlohism,nmloperi
          WHERE his_keypro = per_keypro and his_keyper = per_keyper
            AND per_keypro = wn_key_pro
            AND per_anioa1 = wn_ani_oac
            AND his_codacu = ws_cod_acu
            AND his_keycon = acu_keycon
            AND his_keypro = acu_keypro
            AND his_keyemp = acu_keyemp
            AND per_nummes = 5
        ),
        acu_impcin =
        (
        SELECT NVL(SUM(his_import),0)
          FROM nmlohism,nmloperi
          WHERE his_keypro = per_keypro and his_keyper = per_keyper
            AND per_keypro = wn_key_pro
            AND per_anioa1 = wn_ani_oac
            AND his_codacu = ws_cod_acu
            AND his_keycon = acu_keycon
            AND his_keypro = acu_keypro
            AND his_keyemp = acu_keyemp
            AND per_nummes = 5
        )
      WHERE acu_keypro =wn_key_pro
        AND acu_keycon IN (SELECT ran_keycon FROM glwkrang
                             WHERE ran_nomrep=ws_nom_rep
                               AND ran_idepcc=ws_ide_pcc
                               AND ran_keyusu=wn_key_usu
                               AND ran_keycon IS NOT NULL)
        AND acu_keyemp IN (SELECT ran_keyemp FROM glwkrang
                             WHERE ran_nomrep=ws_nom_rep
                               AND ran_idepcc=ws_ide_pcc
                               AND ran_keyusu=wn_key_usu
                               AND ran_keyemp IS NOT NULL )
        AND acu_anioac = wn_ani_oac;
  END IF;
  IF wn_num_mes = 6  THEN
    UPDATE nmloacum SET acu_unisei =
        (
        SELECT NVL(SUM(his_cantid),0)
          FROM nmlohism,nmloperi
          WHERE his_keypro = per_keypro and his_keyper = per_keyper
            AND per_keypro = wn_key_pro
            AND per_anioa1 = wn_ani_oac
            AND his_codacu = ws_cod_acu
            AND his_keycon = acu_keycon
            AND his_keypro = acu_keypro
            AND his_keyemp = acu_keyemp
            AND per_nummes = 6
        ),
        acu_impsei =
        (
        SELECT NVL(SUM(his_import),0)
          FROM nmlohism,nmloperi
          WHERE his_keypro = per_keypro and his_keyper = per_keyper
            AND per_keypro = wn_key_pro
            AND per_anioa1 = wn_ani_oac
            AND his_codacu = ws_cod_acu
            AND his_keycon = acu_keycon
            AND his_keypro = acu_keypro
            AND his_keyemp = acu_keyemp
            AND per_nummes = 6
        )
      WHERE acu_keypro =wn_key_pro
        AND acu_keycon IN (SELECT ran_keycon FROM glwkrang
                             WHERE ran_nomrep=ws_nom_rep
                               AND ran_idepcc=ws_ide_pcc
                               AND ran_keyusu=wn_key_usu
                               AND ran_keycon IS NOT NULL)
        AND acu_keyemp IN (SELECT ran_keyemp FROM glwkrang
                             WHERE ran_nomrep=ws_nom_rep
                               AND ran_idepcc=ws_ide_pcc
                               AND ran_keyusu=wn_key_usu
                               AND ran_keyemp IS NOT NULL )
        AND acu_anioac = wn_ani_oac;
  END IF;
  IF wn_num_mes = 7  THEN
    UPDATE nmloacum SET acu_unisie =
        (
        SELECT NVL(SUM(his_cantid),0)
          FROM nmlohism,nmloperi
          WHERE his_keypro = per_keypro and his_keyper = per_keyper
            AND per_keypro = wn_key_pro
            AND per_anioa1 = wn_ani_oac
            AND his_codacu = ws_cod_acu
            AND his_keycon = acu_keycon
            AND his_keypro = acu_keypro
            AND his_keyemp = acu_keyemp
            AND per_nummes = 7
        ),
        acu_impsie =
        (
        SELECT NVL(SUM(his_import),0)
          FROM nmlohism,nmloperi
          WHERE his_keypro = per_keypro and his_keyper = per_keyper
            AND per_keypro = wn_key_pro
            AND per_anioa1 = wn_ani_oac
            AND his_codacu = ws_cod_acu
            AND his_keycon = acu_keycon
            AND his_keypro = acu_keypro
            AND his_keyemp = acu_keyemp
            AND per_nummes = 7
        )
      WHERE acu_keypro =wn_key_pro
        AND acu_keycon IN (SELECT ran_keycon FROM glwkrang
                             WHERE ran_nomrep=ws_nom_rep
                               AND ran_idepcc=ws_ide_pcc
                               AND ran_keyusu=wn_key_usu
                               AND ran_keycon IS NOT NULL)
        AND acu_keyemp IN (SELECT ran_keyemp FROM glwkrang
                             WHERE ran_nomrep=ws_nom_rep
                               AND ran_idepcc=ws_ide_pcc
                               AND ran_keyusu=wn_key_usu
                               AND ran_keyemp IS NOT NULL )
        AND acu_anioac = wn_ani_oac;
  END IF;
  IF wn_num_mes = 8  THEN
    UPDATE nmloacum SET acu_unioch =
        (
        SELECT NVL(SUM(his_cantid),0)
          FROM nmlohism,nmloperi
          WHERE his_keypro = per_keypro and his_keyper = per_keyper
            AND per_keypro = wn_key_pro
            AND per_anioa1 = wn_ani_oac
            AND his_codacu = ws_cod_acu
            AND his_keycon = acu_keycon
            AND his_keypro = acu_keypro
            AND his_keyemp = acu_keyemp
            AND per_nummes = 8
        ),
        acu_impoch =
        (
        SELECT NVL(SUM(his_import),0)
          FROM nmlohism,nmloperi
          WHERE his_keypro = per_keypro and his_keyper = per_keyper
            AND per_keypro = wn_key_pro
            AND per_anioa1 = wn_ani_oac
            AND his_codacu = ws_cod_acu
            AND his_keycon = acu_keycon
            AND his_keypro = acu_keypro
            AND his_keyemp = acu_keyemp
            AND per_nummes = 8
        )
      WHERE acu_keypro =wn_key_pro
        AND acu_keycon IN (SELECT ran_keycon FROM glwkrang
                             WHERE ran_nomrep=ws_nom_rep
                               AND ran_idepcc=ws_ide_pcc
                               AND ran_keyusu=wn_key_usu
                               AND ran_keycon IS NOT NULL)
        AND acu_keyemp IN (SELECT ran_keyemp FROM glwkrang
                             WHERE ran_nomrep=ws_nom_rep
                               AND ran_idepcc=ws_ide_pcc
                               AND ran_keyusu=wn_key_usu
                               AND ran_keyemp IS NOT NULL )
        AND acu_anioac = wn_ani_oac;
  END IF;
  IF wn_num_mes = 9  THEN
    UPDATE nmloacum SET acu_uninue =
        (
        SELECT NVL(SUM(his_cantid),0)
          FROM nmlohism,nmloperi
          WHERE his_keypro = per_keypro and his_keyper = per_keyper
            AND per_keypro = wn_key_pro
            AND per_anioa1 = wn_ani_oac
            AND his_codacu = ws_cod_acu
            AND his_keycon = acu_keycon
            AND his_keypro = acu_keypro
            AND his_keyemp = acu_keyemp
            AND per_nummes = 9
        ),
        acu_impnue =
        (
        SELECT NVL(SUM(his_import),0)
          FROM nmlohism,nmloperi
          WHERE his_keypro = per_keypro and his_keyper = per_keyper
            AND per_keypro = wn_key_pro
            AND per_anioa1 = wn_ani_oac
            AND his_codacu = ws_cod_acu
            AND his_keycon = acu_keycon
            AND his_keypro = acu_keypro
            AND his_keyemp = acu_keyemp
            AND per_nummes = 9
        )
      WHERE acu_keypro =wn_key_pro
        AND acu_keycon IN (SELECT ran_keycon FROM glwkrang
                             WHERE ran_nomrep=ws_nom_rep
                               AND ran_idepcc=ws_ide_pcc
                               AND ran_keyusu=wn_key_usu
                               AND ran_keycon IS NOT NULL)
        AND acu_keyemp IN (SELECT ran_keyemp FROM glwkrang
                             WHERE ran_nomrep=ws_nom_rep
                               AND ran_idepcc=ws_ide_pcc
                               AND ran_keyusu=wn_key_usu
                               AND ran_keyemp IS NOT NULL )
        AND acu_anioac = wn_ani_oac;
  END IF;
  IF wn_num_mes = 10 THEN
    UPDATE nmloacum SET acu_unidie =
        (
        SELECT NVL(SUM(his_cantid),0)
          FROM nmlohism,nmloperi
          WHERE his_keypro = per_keypro and his_keyper = per_keyper
            AND per_keypro = wn_key_pro
            AND per_anioa1 = wn_ani_oac
            AND his_codacu = ws_cod_acu
            AND his_keycon = acu_keycon
            AND his_keypro = acu_keypro
            AND his_keyemp = acu_keyemp
            AND per_nummes = 10
        ),
        acu_impdie =
        (
        SELECT NVL(SUM(his_import),0)
          FROM nmlohism,nmloperi
          WHERE his_keypro = per_keypro and his_keyper = per_keyper
            AND per_keypro = wn_key_pro
            AND per_anioa1 = wn_ani_oac
            AND his_codacu = ws_cod_acu
            AND his_keycon = acu_keycon
            AND his_keypro = acu_keypro
            AND his_keyemp = acu_keyemp
            AND per_nummes = 10
        )
      WHERE acu_keypro =wn_key_pro
        AND acu_keycon IN (SELECT ran_keycon FROM glwkrang
                             WHERE ran_nomrep=ws_nom_rep
                               AND ran_idepcc=ws_ide_pcc
                               AND ran_keyusu=wn_key_usu
                               AND ran_keycon IS NOT NULL)
        AND acu_keyemp IN (SELECT ran_keyemp FROM glwkrang
                             WHERE ran_nomrep=ws_nom_rep
                               AND ran_idepcc=ws_ide_pcc
                               AND ran_keyusu=wn_key_usu
                               AND ran_keyemp IS NOT NULL )
        AND acu_anioac = wn_ani_oac;
  END IF;
  IF wn_num_mes = 11 THEN
    UPDATE nmloacum SET acu_unionc =
        (
        SELECT NVL(SUM(his_cantid),0)
          FROM nmlohism,nmloperi
          WHERE his_keypro = per_keypro and his_keyper = per_keyper
            AND per_keypro = wn_key_pro
            AND per_anioa1 = wn_ani_oac
            AND his_codacu = ws_cod_acu
            AND his_keycon = acu_keycon
            AND his_keypro = acu_keypro
            AND his_keyemp = acu_keyemp
            AND per_nummes = 11
        ),
        acu_imponc =
        (
        SELECT NVL(SUM(his_import),0)
          FROM nmlohism,nmloperi
          WHERE his_keypro = per_keypro and his_keyper = per_keyper
            AND per_keypro = wn_key_pro
            AND per_anioa1 = wn_ani_oac
            AND his_codacu = ws_cod_acu
            AND his_keycon = acu_keycon
            AND his_keypro = acu_keypro
            AND his_keyemp = acu_keyemp
            AND per_nummes = 11
        )
      WHERE acu_keypro =wn_key_pro
        AND acu_keycon IN (SELECT ran_keycon FROM glwkrang
                             WHERE ran_nomrep=ws_nom_rep
                               AND ran_idepcc=ws_ide_pcc
                               AND ran_keyusu=wn_key_usu
                               AND ran_keycon IS NOT NULL)
        AND acu_keyemp IN (SELECT ran_keyemp FROM glwkrang
                             WHERE ran_nomrep=ws_nom_rep
                               AND ran_idepcc=ws_ide_pcc
                               AND ran_keyusu=wn_key_usu
                               AND ran_keyemp IS NOT NULL )
        AND acu_anioac = wn_ani_oac;
  END IF;
  IF wn_num_mes = 12 THEN
    UPDATE nmloacum SET acu_unidoc =
        (
        SELECT NVL(SUM(his_cantid),0)
          FROM nmlohism,nmloperi
          WHERE his_keypro = per_keypro and his_keyper = per_keyper
            AND per_keypro = wn_key_pro
            AND per_anioa1 = wn_ani_oac
            AND his_codacu = ws_cod_acu
            AND his_keycon = acu_keycon
            AND his_keypro = acu_keypro
            AND his_keyemp = acu_keyemp
            AND per_nummes = 12
        ),
        acu_impdoc =
        (
        SELECT NVL(SUM(his_import),0)
          FROM nmlohism,nmloperi
          WHERE his_keypro = per_keypro and his_keyper = per_keyper
            AND per_keypro = wn_key_pro
            AND per_anioa1 = wn_ani_oac
            AND his_codacu = ws_cod_acu
            AND his_keycon = acu_keycon
            AND his_keypro = acu_keypro
            AND his_keyemp = acu_keyemp
            AND per_nummes = 12
        )
      WHERE acu_keypro =wn_key_pro
        AND acu_keycon IN (SELECT ran_keycon FROM glwkrang
                             WHERE ran_nomrep=ws_nom_rep
                               AND ran_idepcc=ws_ide_pcc
                               AND ran_keyusu=wn_key_usu
                               AND ran_keycon IS NOT NULL)
        AND acu_keyemp IN (SELECT ran_keyemp FROM glwkrang
                             WHERE ran_nomrep=ws_nom_rep
                               AND ran_idepcc=ws_ide_pcc
                               AND ran_keyusu=wn_key_usu
                               AND ran_keyemp IS NOT NULL )
        AND acu_anioac = wn_ani_oac;
  END IF;
  IF wn_num_mes = 13 THEN
    UPDATE nmloacum SET acu_unitrc =
        (
        SELECT NVL(SUM(his_cantid),0)
          FROM nmlohism,nmloperi
          WHERE his_keypro = per_keypro and his_keyper = per_keyper
            AND per_keypro = wn_key_pro
            AND per_anioa1 = wn_ani_oac
            AND his_codacu = ws_cod_acu
            AND his_keycon = acu_keycon
            AND his_keypro = acu_keypro
            AND his_keyemp = acu_keyemp
            AND per_nummes = 13
        ),
        acu_imptrc =
        (
        SELECT NVL(SUM(his_import),0)
          FROM nmlohism,nmloperi
          WHERE his_keypro = per_keypro and his_keyper = per_keyper
            AND per_keypro = wn_key_pro
            AND per_anioa1 = wn_ani_oac
            AND his_codacu = ws_cod_acu
            AND his_keycon = acu_keycon
            AND his_keypro = acu_keypro
            AND his_keyemp = acu_keyemp
            AND per_nummes = 13
        )
      WHERE acu_keypro =wn_key_pro
        AND acu_keycon IN (SELECT ran_keycon FROM glwkrang
                             WHERE ran_nomrep=ws_nom_rep
                               AND ran_idepcc=ws_ide_pcc
                               AND ran_keyusu=wn_key_usu
                               AND ran_keycon IS NOT NULL)
        AND acu_keyemp IN (SELECT ran_keyemp FROM glwkrang
                             WHERE ran_nomrep=ws_nom_rep
                               AND ran_idepcc=ws_ide_pcc
                               AND ran_keyusu=wn_key_usu
                               AND ran_keyemp IS NOT NULL )
        AND acu_anioac = wn_ani_oac;
  END IF;
  COMMIT;
END;
/
