create or replace  function  usrsiho."sp_hpgenlay"  (ws_keynom numeric, wn_keypro numeric,wn_keyapr numeric) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
ws_keycmc varchar(40);
begin
select distinct apc_keycmc into strict ws_keycmc from usrsiho.holoapco
where apc_keynom = ws_keynom
and apc_keytfo in ('N', null)
and apc_keycon not in ('H20','H32','H33','HP8','HP9')
and apc_keypro = wn_keypro
and apc_keyapr=wn_keyapr;
return ws_keycmc;end;
--dmap converted function completed
$body$
language plpgsql
stable;
