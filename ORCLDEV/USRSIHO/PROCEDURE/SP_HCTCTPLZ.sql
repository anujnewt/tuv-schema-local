create or replace procedure usrsiho."sp_hctctplz"  (wn_key_plz numeric, wn_key_emp numeric, wn_key_tco numeric, ws_key_tic varchar, ws_dia_pag varchar, ws_tmp_sal varchar, ws_des_pev varchar, ws_ara_esp varchar, ws_des_cap varchar, wd_fec_ven timestamp(0), ws_sts_pag varchar, wd_fec_can timestamp(0), ws_sts_fir varchar, wd_fec_fir timestamp(0), wn_key_usg numeric, wn_key_fol inout numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
select coalesce(max(con_keyfol), 0) + 1
into strict wn_key_fol
from usrsiho.holocont
where con_keytco = wn_key_tco;
update usrsiho.holocont set
con_keyfol = wn_key_fol,con_keyemp = wn_key_emp,con_keytco = wn_key_tco,
con_keytic = ws_key_tic,con_diapag = ws_dia_pag,
con_tmpsal = ws_tmp_sal,con_despev = ws_des_pev,
con_araesp = ws_ara_esp,con_descap = ws_des_cap,
con_fecven = wd_fec_ven,con_stspag = ws_sts_pag,
con_feccan = wd_fec_can,con_stsfir = ws_sts_fir,
con_fecfir = wd_fec_fir,con_keyusg = wn_key_usg,
con_stsplz = 2,con_fecoto = trunc(clock_timestamp())
where con_keyplz = wn_key_plz;
-- return wn_key_fol;
end;
$body$
language plpgsql
;
