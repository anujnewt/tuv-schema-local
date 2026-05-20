create or replace procedure labconf.calculoisn_sp_calculoisn (ws_nom_rep varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
ws_key_per varchar(7);
wn_anio integer;
wn_mes integer;
wn_key_nom smallint;
wn_tot_reg integer;
wn_num_reg integer;
err_num numeric;
err_msg varchar(2000);
begin 

/* dmap converted statement start */
-- package does not have global variables
--dmap conversion comment: gtt declaration added
perform dbms_output.put_line( concat('ws_nom_rep = ', ws_nom_rep)) ;/* dmap converted statement end */
wn_tot_reg := 9;
call calculoisn_sp_avance(ws_nom_rep, 'P', 0, wn_tot_reg,'Iniciando C¿¿lculo ISN');
call calculoisn_sp_parametros(ws_nom_rep,ws_key_per,wn_anio,wn_mes,wn_key_nom);/* dmap converted statement start */
perform dbms_output.put_line( concat('ws_key_per = ', ws_key_per)) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('wn_anio = ', wn_anio)) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('wn_mes = ', wn_mes)) ;/* dmap converted statement end *//* dmap converted statement start */
perform dbms_output.put_line( concat('wn_key_nom = ', wn_key_nom)) ;/* dmap converted statement end */
wn_uma := calculoisn_valoruma;/* dmap converted statement start */
perform dbms_output.put_line( concat('wn_uma = ', wn_uma)) ;/* dmap converted statement end */
wn_num_reg := 1;
call calculoisn_sp_avance(ws_nom_rep, 'P', wn_num_reg, wn_tot_reg,'Generando hist¿¿rico de empleados');
call calculoisn_sp_historicoemp(ws_nom_rep,ws_key_per, wn_anio, wn_mes);
wn_num_reg := 2;
call calculoisn_sp_avance(ws_nom_rep, 'P', wn_num_reg, wn_tot_reg,'Limpiando movimientos de n¿¿mina');
call calculoisn_sp_limpiarmov(ws_nom_rep,ws_key_per);
wn_num_reg := 3;
call calculoisn_sp_avance(ws_nom_rep, 'P', wn_num_reg, wn_tot_reg,'Generando acumulados');
call calculoisn_sp_acumulados(ws_nom_rep,ws_key_per, wn_anio, wn_mes, wn_key_nom);
--se calculan las bases antes de exentos porque hay conceptos que se proratean en funci¿¿n de la base.
call calculoisn_sp_bases(ws_nom_rep,ws_key_per, wn_anio, wn_mes, wn_key_nom);
wn_num_reg := 4;
call calculoisn_sp_avance(ws_nom_rep, 'P', wn_num_reg, wn_tot_reg,'Cargando Incidencias');
call calculoisn_sp_incidencias(ws_nom_rep,ws_key_per, wn_anio, wn_mes, wn_key_nom);
wn_num_reg := 5;
call calculoisn_sp_avance(ws_nom_rep, 'P', wn_num_reg, wn_tot_reg,'Calculando Exentos');
call calculoisn_sp_exentos(ws_nom_rep,ws_key_per, wn_anio, wn_mes, wn_key_nom);
wn_num_reg := 6;
call calculoisn_sp_avance(ws_nom_rep, 'P', wn_num_reg, wn_tot_reg,'Generando bases de c¿¿lculo');
call calculoisn_sp_bases(ws_nom_rep,ws_key_per, wn_anio, wn_mes, wn_key_nom);
wn_num_reg := 7;
call calculoisn_sp_avance(ws_nom_rep, 'P', wn_num_reg, wn_tot_reg,'Ejecutando el c¿¿lculo de ISN');
call calculoisn_sp_cargarisn(ws_nom_rep,ws_key_per, wn_anio, wn_mes, wn_key_nom);
wn_num_reg := 8;
call calculoisn_sp_avance(ws_nom_rep, 'P', wn_num_reg, wn_tot_reg,'Calculando prorrateo');
call calculoisn_sp_prorrateo(ws_nom_rep,ws_key_per, wn_anio, wn_mes, wn_key_nom);
call calculoisn_sp_avance(ws_nom_rep, 'T', wn_tot_reg, wn_tot_reg,'C¿¿lculo Terminado');
exception when others then
begin
err_num := sqlstate;/* dmap converted statement start */
err_msg :=  concat(err_num, oracle.substr(sqlerrm, 1, 1500), dbms_utility.format_error_backtrace) ;/* dmap converted statement end */
call calculoisn_sp_avance(ws_nom_rep, 'E', wn_num_reg, wn_tot_reg,err_msg);
end;end;
$body$
language plpgsql
;
