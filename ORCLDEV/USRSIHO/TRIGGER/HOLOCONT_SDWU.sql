CREATE OR REPLACE EDITIONABLE TRIGGER "USRSIHO"."HOLOCONT_SDWU" 
AFTER UPDATE
ON USRSIHO.HOLOCONT
REFERENCING NEW AS pos OLD AS pre
FOR EACH ROW
DECLARE

BEGIN

    USRSIHO.sp_trig_holocont_u(:pos.con_keyplz
    ,:pos.con_keyfol ,:pos.con_keytco ,:pos.con_keydep ,:pos.con_keypue ,
    :pos.con_ctvplz ,:pos.con_keyemp ,:pos.con_regrfc ,:pos.con_preano ,:pos.con_numcap
    ,:pos.con_fecoto ,:pos.con_fecini ,:pos.con_fecven ,:pos.con_keytab ,
    :pos.con_pertra ,:pos.con_idioma ,:pos.con_keynac ,:pos.con_cosuni ,:pos.con_despev
    ,:pos.con_keytva ,:pos.con_keytic ,:pos.con_diapag ,:pos.con_tmpsal ,
    :pos.con_araesp ,:pos.con_stsfir ,:pos.con_stsplz ,:pos.con_stspag ,:pos.con_fecfir
    ,:pos.con_feccan ,:pos.con_numcdi ,:pos.con_recfis ,:pos.con_descap ,
    :pos.con_keyusg ,:pos.con_contra ,:pos.con_hrsjor ,:pre.con_keyplz ,:pre.con_keyfol
    ,:pre.con_keytco ,:pre.con_keydep ,:pre.con_keypue ,:pre.con_ctvplz ,
    :pre.con_keyemp ,:pre.con_regrfc ,:pre.con_preano ,:pre.con_numcap ,:pre.con_fecoto
    ,:pre.con_fecini ,:pre.con_fecven ,:pre.con_keytab ,:pre.con_pertra ,
    :pre.con_idioma ,:pre.con_keynac ,:pre.con_cosuni ,:pre.con_despev ,:pre.con_keytva
    ,:pre.con_keytic ,:pre.con_diapag ,:pre.con_tmpsal ,:pre.con_araesp ,
    :pre.con_stsfir ,:pre.con_stsplz ,:pre.con_stspag ,:pre.con_fecfir ,:pre.con_feccan
    ,:pre.con_numcdi ,:pre.con_recfis ,:pre.con_descap ,:pre.con_keyusg ,
    :pre.con_contra ,:pre.con_hrsjor );
   EXCEPTION
     WHEN OTHERS THEN
       RAISE;
END holocont_sdwu;


/
ALTER TRIGGER "USRSIHO"."HOLOCONT_SDWU" ENABLE;
