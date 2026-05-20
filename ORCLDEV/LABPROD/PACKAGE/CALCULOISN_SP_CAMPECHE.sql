create or replace procedure labprod.calculoisn_sp_campeche (wn_base numeric,ws_key_tab varchar,wn_por_adi numeric, wn_por_cen inout numeric,wn_imp_isn inout numeric, wn_imp_adi inout numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
wn_isn decimal(12,2);
wn_adi decimal(12,2);
wn_lim_inf decimal(18,6);
wn_cuo_fij decimal(18,6);
wn_por_est decimal(12,2);
wn_estimulo decimal(12,2);
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
select tab_eleuno,tab_eletre,tab_elecua into strict wn_lim_inf,wn_cuo_fij,wn_por_cen
from labprod.nmlotabn
where tab_keytab = ws_key_tab
and tab_eleuno <= wn_base
and tab_eledos >= wn_base;
wn_isn := ((wn_base - wn_lim_inf) * wn_por_cen / 100);
wn_isn := wn_isn + wn_cuo_fij;
wn_imp_adi := wn_isn * wn_por_adi / 100;
wn_imp_isn := wn_isn + wn_imp_adi;end;
$body$
language plpgsql
;
