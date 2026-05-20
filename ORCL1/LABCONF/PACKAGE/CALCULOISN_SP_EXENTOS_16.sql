create or replace procedure labconf.calculoisn_sp_exentos_16 (ws_nom_rep varchar,ws_key_per varchar, wn_anio integer, wn_mes integer, wn_key_nom smallint) as $body$
declare
-- pgv moved types start
-- pgv moved types end
wn_tope decimal(12,2);
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
--exentos para el estado de michoacan
--exentos vales de despensa s02
--hasta el 40% del uma elevada al mes  (86.88*30=2606.40*40%=1042.56)son exentos (281+284+334); si rebasa grava todo
wn_tope := wn_uma * 30 * 0.4;
call calculoisn_sp_exentos_vales(ws_nom_rep,ws_key_per, '16',wn_tope, 0);end;
$body$
language plpgsql
;
