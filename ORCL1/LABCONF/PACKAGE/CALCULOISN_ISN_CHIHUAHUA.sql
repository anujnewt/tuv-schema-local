create or replace  function  labconf.calculoisn_isn_chihuahua (wn_base numeric,wn_por_cen numeric, wn_por_adi numeric, ws_key_tab varchar, wn_tot_emp numeric) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
wn_isn decimal(12,2);
wn_adi decimal(12,2);
wn_por_est decimal(12,2);
wn_estimulo decimal(12,2);
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
wn_isn := (wn_base * wn_por_cen / 100);
wn_adi := (wn_isn * wn_por_adi / 100);
case when wn_tot_emp <= 10 then wn_por_est := 0.2;
when wn_tot_emp > 10 and wn_tot_emp <= 30 then wn_por_est := 0.1;
when wn_tot_emp > 30 and wn_tot_emp <= 50 then wn_por_est := 0.05;
else wn_por_est := 0;
end case;
wn_estimulo := wn_isn * wn_por_est;
wn_isn := wn_isn + wn_adi - wn_estimulo;
return wn_isn;end;
$body$
language plpgsql
stable;
