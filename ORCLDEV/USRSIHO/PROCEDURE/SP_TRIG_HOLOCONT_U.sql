create or replace procedure usrsiho."sp_trig_holocont_u"  ( new_con_keyplz numeric, new_con_keyfol numeric, new_con_keytco numeric, new_con_keydep varchar, new_con_keypue varchar, new_con_ctvplz numeric, new_con_keyemp numeric, new_con_regrfc varchar, new_con_preano numeric, new_con_numcap numeric, new_con_fecoto timestamp(0), new_con_fecini timestamp(0), new_con_fecven timestamp(0), new_con_keytab varchar, new_con_pertra varchar, new_con_idioma varchar, new_con_keynac varchar, new_con_cosuni numeric, new_con_despev varchar, new_con_keytva numeric, new_con_keytic varchar, new_con_diapag varchar, new_con_tmpsal varchar, new_con_araesp varchar, new_con_stsfir varchar, new_con_stsplz varchar, new_con_stspag varchar, new_con_fecfir timestamp(0), new_con_feccan timestamp(0), new_con_numcdi numeric, new_con_recfis varchar, new_con_descap varchar, new_con_keyusg numeric, new_con_contra varchar, new_con_hrsjor varchar, old_con_keyplz numeric, old_con_keyfol numeric, old_con_keytco numeric, old_con_keydep varchar, old_con_keypue varchar, old_con_ctvplz numeric, old_con_keyemp numeric, old_con_regrfc varchar, old_con_preano numeric, old_con_numcap numeric, old_con_fecoto timestamp(0), old_con_fecini timestamp(0), old_con_fecven timestamp(0), old_con_keytab varchar, old_con_pertra varchar, old_con_idioma varchar, old_con_keynac varchar, old_con_cosuni numeric, old_con_despev varchar, old_con_keytva numeric, old_con_keytic varchar, old_con_diapag varchar, old_con_tmpsal varchar, old_con_araesp varchar, old_con_stsfir varchar, old_con_stsplz varchar, old_con_stspag varchar, old_con_fecfir timestamp(0), old_con_feccan timestamp(0), old_con_numcdi numeric, old_con_recfis varchar, old_con_descap varchar, old_con_keyusg numeric, old_con_contra varchar, old_con_hrsjor varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
vs_teaname varchar(150);
vs_keydep varchar(70);
vs_keypue varchar(70);
vs_keytit varchar(60);
vs_compan varchar(4); --att2
vn_keypro numeric; --att9
vn_secsin varchar(16);
vn_tipemp varchar(1);
vn_subcta varchar(3);
vm_keyemp numeric;
vm_keydep varchar(16);
vm_keypue varchar(16);
vs_regrfc varchar(13);
vn_cvezon varchar(1);
vs_fecing varchar(30);
vs_nombre varchar(30);
vs_apellido varchar(30);
vn_keysup numeric;
vs_supnam varchar(60);
vs_suplas varchar(80);
vs_suprfc varchar(16);
begin
if
--      new_con_keyplz != old_con_keyplz or
new_con_keyfol != old_con_keyfol or
new_con_keytco != old_con_keytco or
new_con_keydep != old_con_keydep or
new_con_keypue != old_con_keypue or
new_con_ctvplz != old_con_ctvplz or
new_con_keyemp != old_con_keyemp or
--      new_con_regrfc != old_con_regrfc or
new_con_preano != old_con_preano or
new_con_numcap != old_con_numcap or
new_con_fecoto != old_con_fecoto or
new_con_fecini != old_con_fecini or
new_con_fecven != old_con_fecven or
new_con_keytab != old_con_keytab or
new_con_pertra != old_con_pertra or
new_con_idioma != old_con_idioma or
new_con_keynac != old_con_keynac or
new_con_cosuni != old_con_cosuni or
new_con_despev != old_con_despev or
new_con_keytva != old_con_keytva or
new_con_keytic != old_con_keytic or
--      new_con_diapag != old_con_diapag or
new_con_tmpsal != old_con_tmpsal or
--      new_con_araesp != old_con_araesp or
new_con_stsfir != old_con_stsfir or
--      new_con_stsplz != old_con_stsplz or
new_con_stspag != old_con_stspag or
new_con_fecfir != old_con_fecfir or
new_con_feccan != old_con_feccan or
new_con_numcdi != old_con_numcdi or
--      new_con_recfis != old_con_recfis or
new_con_descap != old_con_descap or
new_con_keyusg != old_con_keyusg or
new_con_contra != old_con_contra
--      new_con_hrsjor != old_con_hrsjor
then
insert into usrsiho.holocont_sdw2 values (      null,0,today,
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
end if;end;
$body$
language plpgsql
;
