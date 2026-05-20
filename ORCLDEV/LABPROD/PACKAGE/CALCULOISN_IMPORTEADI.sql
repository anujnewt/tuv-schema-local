create or replace  function  labprod.calculoisn_importeadi (ws_key_ent varchar,wn_base numeric, wn_por_cen numeric,wn_por_adi numeric, ws_key_tab varchar, wn_imp_isn numeric) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
wn_imp_adi decimal(12,2);
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
wn_imp_adi := wn_base * wn_por_cen / 100;
wn_imp_adi := wn_imp_adi * wn_por_adi / 100;
return wn_imp_adi;end;
$body$
language plpgsql
stable;
