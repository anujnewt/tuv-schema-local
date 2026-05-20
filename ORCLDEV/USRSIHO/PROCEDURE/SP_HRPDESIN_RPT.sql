create or replace procedure usrsiho."sp_hrpdesin_rpt"  (vs_nom_rep varchar, vs_ide_pcc varchar, vn_key_usu numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
--sipros, s. a. de c. v.
--sistema  : rh-2000  c/s
--modulo     --programa : sp_hrpdesin_rpt copia de sp_hnmreppr
--           reporte concentrado de cifras de control
--autor    : jesus nu??arciga
--fecha    : 8 de noviembre de 1999
--modifico : aedo 23/nov/05 se agrego el tipo de moneda, el importe y el tipo de cambio
--           aedo 01/nov/06 se renombro, viene de hrpdesin
lnkeyrph numeric(10);
lntotcos decimal(18,2);
rec record;
begin
-- ajusta la informaci??e incidencias
for rec in (select frp_keyrph, sum(gdp_cosuni * gdp_numcap) suma
from usrsiho.holofrph, usrsiho.hologdpr
where frp_keyrph = gdp_keyrph
group by frp_keyrph, frp_totcos
having abs(sum(gdp_cosuni * gdp_numcap) - frp_totcos) >= 1) loop
lnkeyrph := rec.frp_keyrph;
lntotcos := rec.suma;
update usrsiho.holofrph
set frp_totcos = lntotcos
where frp_keyrph = lnkeyrph;
end loop;
--aedo 06/abril/06  se modifico la logica del tipo de moneda
---       decode(frp_tipcam,1.0000,"pesos","dolares"),
insert into usrsiho.glwkcrys(cry_nomrep,cry_idepcc,cry_keyusu,cry_dec006,
cry_dec007,cry_dec008,cry_chr020,cry_dec001,
cry_dec009,cry_chr001,cry_chr002,cry_chr021,
cry_chr004,cry_dec010,cry_chr005,cry_dec011,
cry_chr019,cry_dec014,cry_dec003)    -- el ultimo era cry_dec015
select ran_nomrep, ran_idepcc, ran_keyusu, ran_keyemp,
ran_keycen, gdp_numcap, gdp_keycon, gdp_cosuni,
nom_keynom, nom_destip, con_descon, con_codimp,
ma.pam_nompar, cia_keycia, oracle.substr(cia_descia,1,40), gdp_keyemp,
oracle.substr(tm.pam_folini,1,8), (gdp_cosuni::numeric/frp_tipcam::numeric), frp_tipcam
from usrsiho.glwkrang, usrsiho.nmlonomi, usrsiho.holofrph, usrsiho.hologdpr, usrsiho.nmloconc,
usrsiho.nmcodeps, usrsiho.glcopams ma, usrsiho.glcopams tm, usrsiho.nmlocias, usrsiho.nmloproc
where ran_keyemp = frp_keyrph
and frp_keyrph = gdp_keyrph
and frp_keynom = nom_keynom
and frp_keydep = dep_keydep
and gdp_keycon = con_keycon
and pro_keycia = cia_keycia
and tm.pam_keypar='H10'
and tm.pam_cvesec = frp_forpag
and ma.pam_keypar ='H2'
and ma.pam_cvesec = ran_keycen
and pro_keypro = ran_keypro
and ran_nomrep = vs_nom_rep
and ran_idepcc = vs_ide_pcc
and ran_keyusu = vn_key_usu;end;
$body$
language plpgsql
;
