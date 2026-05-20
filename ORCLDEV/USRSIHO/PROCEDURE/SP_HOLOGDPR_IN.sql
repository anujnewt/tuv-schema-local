create or replace procedure usrsiho."sp_hologdpr_in"  (ps_keydep varchar, pn_keyrph numeric, pd_fechag timestamp(0), pn_keyemp numeric, ps_keypue varchar, pn_capini numeric, pn_capfin numeric, pn_numcap numeric, ps_keycon varchar, ps_marcon varchar, ps_marcos varchar, pn_cosuni numeric, ps_keysue varchar, pn_keytco numeric, pn_keyfol numeric, pn_keyusu numeric, pn_minsal numeric, pn_minext numeric, pn_mincom numeric, ln_keysec inout numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
ln_keysec := 0;
insert into hologdpr(gdp_keydep, gdp_keyrph, gdp_fechag, gdp_keyemp, gdp_keypue,
gdp_capini, gdp_capfin, gdp_numcap, gdp_keycon, gdp_marcon,
gdp_marcos, gdp_cosuni, gdp_keysue, gdp_keytco, gdp_keyfol,
gdp_keyusu, gdp_minsal, gdp_minext, gdp_mincom)
--        values ('0',853092,'09/05/2017',490193654,1043,
--                13,13,1,'HIT','X',
--                'X',3145.00,'','','',
--                2049,540,1230,300,60)
values (ps_keydep, pn_keyrph, pd_fechag, pn_keyemp, ps_keypue,
pn_capini, pn_capfin, pn_numcap, ps_keycon, ps_marcon,
ps_marcos, pn_cosuni, ps_keysue, pn_keytco, pn_keyfol,
pn_keyusu, pn_minsal, pn_minext, pn_mincom)
returning gdp_keysec into ln_keysec;end;
$body$
language plpgsql
;
