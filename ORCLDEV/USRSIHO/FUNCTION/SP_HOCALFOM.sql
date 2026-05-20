create or replace  function  usrsiho."sp_hocalfom"  (wn_codigo numeric, wn_folio numeric, wn_costot numeric, wn_numcap numeric) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
ws_puesto usrsiho.holocont.con_keypue %type;
ws_pertra usrsiho.holocont.con_pertra %type;
ws_idioma usrsiho.holocont.con_idioma %type;
ws_nacion usrsiho.holocont.con_keynac %type;
ln_suma   decimal(15,2);
begin
-- calculo de fomentos a la cultura y eficiencia
-- duracisn     tabu  factor fomento activ idi - nac
-- 30 minutos   514   0.0312 16.0368 1000  em
-- 15 minutos   178   0.0312  5.5536 1004  em
-- 30 minutos   1441  0.0306 44.0946 1009  ee
-- 30 minutos   1103  0.0312 34.4136 1006  om-oe
-- 150 minutos  3082  0.0302 93.0764 1003  om-oe
begin
select con_keypue,con_pertra,con_idioma,con_keynac
into strict ws_puesto, ws_pertra, ws_idioma, ws_nacion
from usrsiho.holocont
where con_keyemp = wn_codigo
and con_keyfol = wn_folio;
exception
when no_data_found then
ws_puesto:= null;
ws_pertra:= null;
ws_idioma:= null;
ws_nacion:= null;
end;
ln_suma := 0;
if trim(both ws_puesto) = '1000' and
trim(both ws_pertra) = '30'   and
trim(both ws_idioma) = 'E'    and
trim(both ws_nacion) = 'M'    then
ln_suma := round(wn_costot * 0.0300) * wn_numcap;
elsif trim(both ws_puesto) = '1004'   and
trim(both ws_pertra) = '15'   and
trim(both ws_idioma) = 'E'    and
trim(both ws_nacion) = 'M'    then
ln_suma := round(wn_costot * 0.0300) * wn_numcap;
elsif trim(both ws_puesto) = '1009' and
trim(both ws_pertra) = '30'   and
trim(both ws_idioma) = 'E'    and
trim(both ws_nacion) = 'E'    then
ln_suma := round(wn_costot * 0.0300) * wn_numcap;
elsif trim(both ws_puesto) = '1006' and
trim(both ws_pertra) = '30'   and
((trim(both ws_idioma) = 'O' and trim(both ws_nacion) = 'M') or (trim(both ws_idioma) = 'O' and trim(both ws_nacion) = 'E')) then
ln_suma := round(wn_costot * 0.0300) * wn_numcap;
elsif trim(both ws_puesto) = '1003' and
trim(both ws_pertra) = '150'  and
((trim(both ws_idioma) = 'O' and trim(both ws_nacion) = 'M') or (trim(both ws_idioma) = 'O' and trim(both ws_nacion) = 'E')) then
ln_suma := round(wn_costot * 0.0300) * wn_numcap;
else
ln_suma := round(wn_costot * 0.0300) * wn_numcap;
end if;
if ln_suma >= 1 then
return ln_suma;
else
return 0;
end if;
-- ------------------------------------------------------------------------------------------------
end;
--dmap converted function completed
$body$
language plpgsql
stable;
