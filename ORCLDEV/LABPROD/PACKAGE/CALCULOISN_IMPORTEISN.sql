create or replace  function  labprod.calculoisn_importeisn (ws_key_ent varchar,wn_base numeric, wn_por_cen numeric,wn_por_adi numeric, ws_key_tab varchar,wn_cuo_fij numeric, wn_tot_emp numeric) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
wn_imp_isn decimal(12,2);
wn_imp_adi decimal(12,2);
wn_pct_loc decimal(12,2);  --porcentaje para los estados en que el porcentaje depende de la base
begin 

/* dmap converted statement start */
-- package does not have global variables
--dmap conversion comment: gtt declaration added
perform dbms_output.put_line( concat('IMPORTEISN ws_key_ent = ', ws_key_ent, ' wn_por_cen = ', wn_por_cen, ' wn_por_adi = ', wn_por_adi)) ;/* dmap converted statement end */
case ws_key_ent
when '04' then  --campeche
begin
call calculoisn_sp_campeche(wn_base,ws_key_tab,wn_por_adi, wn_pct_loc,wn_imp_isn, wn_imp_adi );
end;
/*when 08 then  --chihuahua
begin
wn_imp_isn := calculoisn_isn_chihuahua(wn_base,wn_por_cen, wn_por_adi, ws_key_tab, wn_tot_emp);
end;*/
when '25' then  --sinaloa
begin
call calculoisn_sp_sinaloa(wn_base,ws_key_tab,wn_por_adi, wn_pct_loc,wn_imp_isn, wn_imp_adi );
end;
else
begin
wn_imp_isn := wn_base * wn_por_cen / 100;
wn_imp_adi := labprod.calculoisn_importeadi(ws_key_ent,wn_base, wn_por_cen, wn_por_adi, ws_key_tab, wn_imp_isn);
wn_imp_isn := wn_imp_isn + wn_imp_adi;
end;
end case;
return wn_imp_isn;end;
--importeisn utiliza la funci??n importeadi
--no se debe utilizar la funci??n importeadi en la misma setencia que la funci??n importeisn.
$body$
language plpgsql
stable;
