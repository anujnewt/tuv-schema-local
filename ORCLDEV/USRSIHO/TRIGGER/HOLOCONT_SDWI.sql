CREATE OR REPLACE EDITIONABLE TRIGGER "USRSIHO"."HOLOCONT_SDWI" 
AFTER INSERT
ON USRSIHO.HOLOCONT
REFERENCING NEW AS New
FOR EACH ROW
DECLARE

BEGIN

   USRSIHO.sp_trig_holocont_i(:New.con_keyplz
    ,:New.con_keyfol ,:New.con_keytco ,:New.con_keydep ,:New.con_keypue
    ,:New.con_ctvplz ,:New.con_keyemp ,:New.con_regrfc ,:New.con_preano
    ,:New.con_numcap ,:New.con_fecoto ,:New.con_fecini ,:New.con_fecven
    ,:New.con_keytab ,:New.con_pertra ,:New.con_idioma ,:New.con_keynac
    ,:New.con_cosuni ,:New.con_despev ,:New.con_keytva ,:New.con_keytic
    ,:New.con_diapag ,:New.con_tmpsal ,:New.con_araesp ,:New.con_stsfir
    ,:New.con_stsplz ,:New.con_stspag ,:New.con_fecfir ,:New.con_feccan
    ,:New.con_numcdi ,:New.con_recfis ,:New.con_descap ,:New.con_keyusg
    ,:New.con_contra ,:New.con_hrsjor );
   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END holocont_sdwi;


/
ALTER TRIGGER "USRSIHO"."HOLOCONT_SDWI" ENABLE;
