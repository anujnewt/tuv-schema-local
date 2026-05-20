create or replace procedure labconf.calculoisn_sp_exentos (ws_nom_rep varchar,ws_key_per varchar, wn_anio integer, wn_mes integer, wn_key_nom smallint) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
call calculoisn_sp_exentos_01(ws_nom_rep,ws_key_per, wn_anio, wn_mes, wn_key_nom);
call calculoisn_sp_exentos_03(ws_nom_rep,ws_key_per, wn_anio, wn_mes, wn_key_nom);
call calculoisn_sp_exentos_08(ws_nom_rep,ws_key_per, wn_anio, wn_mes, wn_key_nom);
call calculoisn_sp_exentos_11(ws_nom_rep,ws_key_per, wn_anio, wn_mes, wn_key_nom);
call calculoisn_sp_exentos_13(ws_nom_rep,ws_key_per, wn_anio, wn_mes, wn_key_nom);
call calculoisn_sp_exentos_16(ws_nom_rep,ws_key_per, wn_anio, wn_mes, wn_key_nom);
call calculoisn_sp_exentos_17(ws_nom_rep,ws_key_per, wn_anio, wn_mes, wn_key_nom);
call calculoisn_sp_exentos_21(ws_nom_rep,ws_key_per, wn_anio, wn_mes, wn_key_nom);
call calculoisn_sp_exentos_22(ws_nom_rep,ws_key_per, wn_anio, wn_mes, wn_key_nom);
call calculoisn_sp_exentos_25(ws_nom_rep,ws_key_per, wn_anio, wn_mes, wn_key_nom);
call calculoisn_sp_exentos_26(ws_nom_rep,ws_key_per, wn_anio, wn_mes, wn_key_nom);
call calculoisn_sp_exentos_28(ws_nom_rep,ws_key_per, wn_anio, wn_mes, wn_key_nom);end;
$body$
language plpgsql
;
