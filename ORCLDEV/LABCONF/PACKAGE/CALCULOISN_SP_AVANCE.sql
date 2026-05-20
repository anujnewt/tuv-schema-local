create or replace procedure labconf.calculoisn_sp_avance (ws_nom_rep varchar, ws_sta_tus varchar, wn_num_reg integer, wn_tot_reg integer, ws_men_saj varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
update labconf.glcoresu set res_status = ws_sta_tus,res_numreg = wn_num_reg,res_totreg = wn_tot_reg, res_deserr=ws_men_saj
where res_idepro = ws_nom_rep;
/* commit; */
perform dbms_output.put_line(ws_men_saj);end;
$body$
language plpgsql
;
