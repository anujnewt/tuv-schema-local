CREATE OR REPLACE FUNCTION trigger_fct_holocont_sdwi() RETURNS trigger AS $body$
DECLARE
BEGIN
BEGIN
USRSIHO.call sp_trig_holocont_i(NEW.con_keyplz
,NEW.con_keyfol ,NEW.con_keytco ,NEW.con_keydep ,NEW.con_keypue
,NEW.con_ctvplz ,NEW.con_keyemp ,NEW.con_regrfc ,NEW.con_preano
,NEW.con_numcap ,NEW.con_fecoto ,NEW.con_fecini ,NEW.con_fecven
,NEW.con_keytab ,NEW.con_pertra ,NEW.con_idioma ,NEW.con_keynac
,NEW.con_cosuni ,NEW.con_despev ,NEW.con_keytva ,NEW.con_keytic
,NEW.con_diapag ,NEW.con_tmpsal ,NEW.con_araesp ,NEW.con_stsfir
,NEW.con_stsplz ,NEW.con_stspag ,NEW.con_fecfir ,NEW.con_feccan
,NEW.con_numcdi ,NEW.con_recfis ,NEW.con_descap ,NEW.con_keyusg
,NEW.con_contra ,NEW.con_hrsjor );
EXCEPTION
WHEN OTHERS THEN
-- Consider logging the error and then re-raise
RAISE;END;
RETURN NEW;
END
$body$
LANGUAGE 'plpgsql';
