create or replace procedure usrsiho."sp_hrpcmcap"  (wn_keyfol numeric,wn_gdpsec numeric, wn_keytco numeric,wn_keyplz numeric, ws_stspag char,wn_capini numeric, wn_capfin numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
wn_iter numeric(10);wn_numsec numeric(10);wn_keyrph numeric(10);
begin
for wn_iter in wn_capini .. wn_capfin loop
-- lectura del secuencial
select max(coc_numsec)
into strict wn_numsec
from usrsiho.holococa,usrsiho.holocont
where coc_keyplz = con_keyplz
and con_keyfol = wn_keyfol
and con_keytco = wn_keytco
and coc_keycap = wn_iter;
if nullif(wn_numsec::text, '') is null then
wn_numsec := 0;
end if;
wn_numsec := wn_numsec + 1;
begin
select gdp_keyrph
into strict wn_keyrph
from usrsiho.hologdpr
where gdp_keysec = wn_gdpsec;
exception when no_data_found then wn_keyrph := 0;
end;
-- inserccion de capitulos
insert into usrsiho.holococa(coc_keyplz,coc_keycap,coc_numsec,coc_stspag,coc_keyrph,coc_keygdp)
values (wn_keyplz,wn_iter,wn_numsec,ws_stspag,wn_keyrph,wn_gdpsec);
end loop;end;
$body$
language plpgsql
;
