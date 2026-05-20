create or replace procedure labprod.calculoisn_sp_exentos_03 (ws_nom_rep varchar,ws_key_per varchar, wn_anio integer, wn_mes integer, wn_key_nom smallint) as $body$
declare
-- pgv moved types start
-- pgv moved types end
wn_tope decimal(12,2);
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
--exentos para el estado de baja california sur
--exentos vales de despensa s02
--hasta el 40% del uma elevada al mes  (86.88*30=2606.40*40%=1042.56)son exentos (281+284+334); el excendente grava
wn_tope := wn_uma * 30 * 0.4;
call calculoisn_sp_exentos_vales(ws_nom_rep,ws_key_per, '03',wn_tope, wn_tope);end;
$body$
language plpgsql
;
