create or replace procedure usrsiho."sp_trig_holocont_i"  ( new_con_keyplz integer, new_con_keyfol integer, new_con_keytco integer, new_con_keydep varchar, new_con_keypue varchar, new_con_ctvplz integer, new_con_keyemp integer, new_con_regrfc varchar, new_con_preano integer, new_con_numcap integer, new_con_fecoto timestamp(0), new_con_fecini timestamp(0), new_con_fecven timestamp(0), new_con_keytab varchar, new_con_pertra varchar, new_con_idioma varchar, new_con_keynac varchar, new_con_cosuni numeric, new_con_despev varchar, new_con_keytva integer, new_con_keytic varchar, new_con_diapag varchar, new_con_tmpsal varchar, new_con_araesp varchar, new_con_stsfir varchar, new_con_stsplz varchar, new_con_stspag varchar, new_con_fecfir timestamp(0), new_con_feccan timestamp(0), new_con_numcdi integer, new_con_recfis varchar, new_con_descap varchar, new_con_keyusg integer, new_con_contra varchar, new_con_hrsjor varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
insert into usrsiho.holocont_sdw2 values (      null, 0, today,
new_con_keyplz, new_con_keyfol, new_con_keytco, new_con_keydep,
new_con_keypue, new_con_ctvplz, new_con_keyemp, new_con_regrfc,
new_con_preano, new_con_numcap, new_con_fecoto, new_con_fecini,
new_con_fecven, new_con_keytab, new_con_pertra, new_con_idioma,
new_con_keynac, new_con_cosuni, new_con_despev, new_con_keytva,
new_con_keytic, new_con_diapag, new_con_tmpsal, new_con_araesp,
new_con_stsfir, new_con_stsplz, new_con_stspag, new_con_fecfir,
new_con_feccan, new_con_numcdi, new_con_recfis, new_con_descap,
new_con_keyusg, new_con_contra, new_con_hrsjor
);end;
$body$
language plpgsql
;
