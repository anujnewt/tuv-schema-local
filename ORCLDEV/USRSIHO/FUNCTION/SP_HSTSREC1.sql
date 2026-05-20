create or replace  function  usrsiho."sp_hstsrec1"  (vn_key_pro numeric, vs_key_apr varchar, vn_key_nom numeric, vs_num_emi varchar, vn_key_emp numeric) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
vs_mar_con   usrsiho.hologdpr.gdp_marcon %type;
vn_key_fol   usrsiho.hologdpr.gdp_keyfol %type;
vn_key_tco   usrsiho.hologdpr.gdp_keytco %type;
vs_sts_fir   usrsiho.holocont.con_stsfir %type;
vn_sta_pro   numeric(5);
rec record;
begin
vn_sta_pro := 1;
for rec
in (select hgd_marcon,hgd_keytco,
hgd_keyfol,con_stsfir
from usrsiho.nmloperi
join usrsiho.holofrph on nmloperi.per_keypro = holofrph.frp_keypro and nmloperi.per_keyper = holofrph.frp_keyper
join usrsiho.holohgdp on frp_keyrph = hgd_keyrph and hgd_keyemp = vn_key_emp and hgd_marcon != 'X'
join usrsiho.nmloalde on frp_keydep = ald_keydep and ald_marcco != 'E'
left join usrsiho.holocont on  hgd_keytco = con_keytco and hgd_keyfol = con_keyfol
where per_keypro = vn_key_pro
and per_nu3aux = vs_key_apr
and per_keynom = vn_key_nom
and per_nu4aux = vs_num_emi
) loop
vs_mar_con := rec.hgd_marcon;
vn_key_tco := rec.hgd_keytco;
vn_key_fol := rec.hgd_keyfol;
vs_sts_fir := rec.con_stsfir;
if vs_mar_con = 'N' then
vn_sta_pro := 3;
exit;
end if;
if vs_mar_con = 'S' then
if vs_sts_fir = 'N' then
vn_sta_pro := 2;
end if;
end if;
end loop;
return vn_sta_pro;end;
--dmap converted function completed
$body$
language plpgsql
stable;
