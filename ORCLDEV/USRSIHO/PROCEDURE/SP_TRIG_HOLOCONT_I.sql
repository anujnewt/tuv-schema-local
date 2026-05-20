CREATE OR REPLACE EDITIONABLE PROCEDURE "USRSIHO"."SP_TRIG_HOLOCONT_I" (
       new_con_keyplz  integer,
       new_con_keyfol  integer,
       new_con_keytco  integer,
       new_con_keydep  VARCHAR2,
       new_con_keypue  VARCHAR2,
       new_con_ctvplz  integer,
       new_con_keyemp  integer,
       new_con_regrfc  VARCHAR2,
       new_con_preano  integer,
       new_con_numcap  integer,
       new_con_fecoto  date,
       new_con_fecini  date,
       new_con_fecven  date,
       new_con_keytab  VARCHAR2,
       new_con_pertra  VARCHAR2,
       new_con_idioma  VARCHAR2,
       new_con_keynac  VARCHAR2,
       new_con_cosuni  NUMBER,
       new_con_despev  VARCHAR2,
       new_con_keytva  integer,
       new_con_keytic  VARCHAR2,
       new_con_diapag  VARCHAR2,
       new_con_tmpsal  VARCHAR2,
       new_con_araesp  VARCHAR2,
       new_con_stsfir  VARCHAR2,
       new_con_stsplz  VARCHAR2,
       new_con_stspag  VARCHAR2,
       new_con_fecfir  date,
       new_con_feccan  date,
       new_con_numcdi  integer,
       new_con_recfis  VARCHAR2,
       new_con_descap  VARCHAR2,
       new_con_keyusg  integer,
       new_con_contra  VARCHAR2,
       new_con_hrsjor  VARCHAR2 ) IS
-- PGV moved types start

-- PGV moved types end

-- PGV moved types start
-- PGV moved types end
BEGIN
       INSERT INTO USRSIHO.holocont_sdw2 VALUES
       (      NULL, 0, TODAY,
              new_con_keyplz, new_con_keyfol, new_con_keytco, new_con_keydep,
              new_con_keypue, new_con_ctvplz, new_con_keyemp, new_con_regrfc,
              new_con_preano, new_con_numcap, new_con_fecoto, new_con_fecini,
              new_con_fecven, new_con_keytab, new_con_pertra, new_con_idioma,
              new_con_keynac, new_con_cosuni, new_con_despev, new_con_keytva,
              new_con_keytic, new_con_diapag, new_con_tmpsal, new_con_araesp,
              new_con_stsfir, new_con_stsplz, new_con_stspag, new_con_fecfir,
              new_con_feccan, new_con_numcdi, new_con_recfis, new_con_descap,
              new_con_keyusg, new_con_contra, new_con_hrsjor
              );
END;
/
