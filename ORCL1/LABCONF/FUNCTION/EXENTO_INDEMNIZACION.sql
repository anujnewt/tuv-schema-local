create or replace  function  labconf."exento_indemnizacion"  (wd_fec_ing timestamp(0),wd_fec_baj timestamp(0), wn_imp_ort numeric, wn_uma numeric) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
wn_tope decimal(12,2);
wn_ani_ser numeric(6);
wn_exento decimal(12,2);
begin
wn_ani_ser := months_between( wd_fec_baj, wd_fec_ing ) /12;
wn_tope := 90 * wn_uma * wn_ani_ser;
if wn_tope >= wn_imp_ort then
wn_exento := wn_tope;
else
wn_exento := wn_imp_ort;
end if;
return wn_exento;end;
--dmap converted function completed
$body$
language plpgsql
stable;
