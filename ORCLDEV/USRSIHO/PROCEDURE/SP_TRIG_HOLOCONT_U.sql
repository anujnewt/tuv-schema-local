CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_TRIG_HOLOCONT_U" (
    new_con_keyplz  NUMBER,
    new_con_keyfol  NUMBER,
    new_con_keytco  NUMBER,
    new_con_keydep  VARCHAR2,
    new_con_keypue  VARCHAR2,
    new_con_ctvplz  NUMBER,
    new_con_keyemp  NUMBER,
    new_con_regrfc  VARCHAR2,
    new_con_preano  NUMBER,
    new_con_numcap  NUMBER,
    new_con_fecoto  DATE,
    new_con_fecini  DATE,
    new_con_fecven  DATE,
    new_con_keytab  VARCHAR2,
    new_con_pertra  VARCHAR2,
    new_con_idioma  VARCHAR2,
    new_con_keynac  VARCHAR2,
    new_con_cosuni  NUMBER,
    new_con_despev  VARCHAR2,
    new_con_keytva  NUMBER,
    new_con_keytic  VARCHAR2,
    new_con_diapag  VARCHAR2,
    new_con_tmpsal  VARCHAR2,
    new_con_araesp  VARCHAR2,
    new_con_stsfir  VARCHAR2,
    new_con_stsplz  VARCHAR2,
    new_con_stspag  VARCHAR2,
    new_con_fecfir  DATE,
    new_con_feccan  DATE,
    new_con_numcdi  NUMBER,
    new_con_recfis  VARCHAR2,
    new_con_descap  VARCHAR2,
    new_con_keyusg  NUMBER,
    new_con_contra  VARCHAR2,
    new_con_hrsjor  VARCHAR2,
    old_con_keyplz  NUMBER,
    old_con_keyfol  NUMBER,
    old_con_keytco  NUMBER,
    old_con_keydep  VARCHAR2,
    old_con_keypue  VARCHAR2,
    old_con_ctvplz  NUMBER,
    old_con_keyemp  NUMBER,
    old_con_regrfc  VARCHAR2,
    old_con_preano  NUMBER,
    old_con_numcap  NUMBER,
    old_con_fecoto  DATE,
    old_con_fecini  DATE,
    old_con_fecven  DATE,
    old_con_keytab  VARCHAR2,
    old_con_pertra  VARCHAR2,
    old_con_idioma  VARCHAR2,
    old_con_keynac  VARCHAR2,
    old_con_cosuni  NUMBER,
    old_con_despev  VARCHAR2,
    old_con_keytva  NUMBER,
    old_con_keytic  VARCHAR2,
    old_con_diapag  VARCHAR2,
    old_con_tmpsal  VARCHAR2,
    old_con_araesp  VARCHAR2,
    old_con_stsfir  VARCHAR2,
    old_con_stsplz  VARCHAR2,
    old_con_stspag  VARCHAR2,
    old_con_fecfir  DATE,
    old_con_feccan  DATE,
    old_con_numcdi  NUMBER,
    old_con_recfis  VARCHAR2,
    old_con_descap  VARCHAR2,
    old_con_keyusg  NUMBER,
    old_con_contra  VARCHAR2,
    old_con_hrsjor  VARCHAR2 ) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
 vs_teaname VARCHAR2(150);
 vs_keydep VARCHAR2(70);
 vs_keypue VARCHAR2(70);
 vs_keytit VARCHAR2(60);
 vs_compan VARCHAR2(4); --att2
 vn_keypro NUMBER; --att9
 vn_secsin VARCHAR2(16);
 vn_tipemp VARCHAR2(1);
 vn_subcta VARCHAR2(3);
 vm_keyemp NUMBER;
 vm_keydep VARCHAR2(16);
 vm_keypue VARCHAR2(16);
 vs_regrfc VARCHAR2(13);
 vn_cvezon VARCHAR2(1);
 vs_fecing VARCHAR2(30);
 vs_nombre VARCHAR2(30);
 vs_apellido VARCHAR2(30);
 vn_keysup NUMBER;
 vs_supnam VARCHAR2(60);
 vs_suplas VARCHAR2(80);
 vs_suprfc VARCHAR2(16);
BEGIN
    IF
--      new_con_keyplz != old_con_keyplz OR
      new_con_keyfol != old_con_keyfol OR
      new_con_keytco != old_con_keytco OR
      new_con_keydep != old_con_keydep OR
      new_con_keypue != old_con_keypue OR
      new_con_ctvplz != old_con_ctvplz OR
      new_con_keyemp != old_con_keyemp OR
--      new_con_regrfc != old_con_regrfc OR
      new_con_preano != old_con_preano OR
      new_con_numcap != old_con_numcap OR
      new_con_fecoto != old_con_fecoto OR
      new_con_fecini != old_con_fecini OR
      new_con_fecven != old_con_fecven OR
      new_con_keytab != old_con_keytab OR
      new_con_pertra != old_con_pertra OR
      new_con_idioma != old_con_idioma OR
      new_con_keynac != old_con_keynac OR
      new_con_cosuni != old_con_cosuni OR
      new_con_despev != old_con_despev OR
      new_con_keytva != old_con_keytva OR
      new_con_keytic != old_con_keytic OR
--      new_con_diapag != old_con_diapag OR
      new_con_tmpsal != old_con_tmpsal OR
--      new_con_araesp != old_con_araesp OR
      new_con_stsfir != old_con_stsfir OR
--      new_con_stsplz != old_con_stsplz OR
      new_con_stspag != old_con_stspag OR
      new_con_fecfir != old_con_fecfir OR
      new_con_feccan != old_con_feccan OR
      new_con_numcdi != old_con_numcdi OR
--      new_con_recfis != old_con_recfis OR
      new_con_descap != old_con_descap OR
      new_con_keyusg != old_con_keyusg OR
      new_con_contra != old_con_contra
--      new_con_hrsjor != old_con_hrsjor
    THEN
      INSERT INTO USRSIHO.holocont_sdw2 VALUES
      (      NULL,0,TODAY,
             new_con_keyplz, new_con_keyfol, new_con_keytco, new_con_keydep,
             new_con_keypue, new_con_ctvplz, new_con_keyemp, new_con_regrfc,
             new_con_preano, new_con_numcap, new_con_fecoto, new_con_fecini,
             new_con_fecven, new_con_keytab, new_con_pertra  , new_con_idioma,
             new_con_keynac, new_con_cosuni, new_con_despev, new_con_keytva,
             new_con_keytic, new_con_diapag, new_con_tmpsal, new_con_araesp,
             new_con_stsfir, new_con_stsplz, new_con_stspag, new_con_fecfir,
             new_con_feccan, new_con_numcdi, new_con_recfis, new_con_descap,
             new_con_keyusg, new_con_contra, new_con_hrsjor
            );
    END IF;
END;
/
