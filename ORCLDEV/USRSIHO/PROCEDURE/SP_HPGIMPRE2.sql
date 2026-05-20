create or replace procedure usrsiho."sp_hpgimpre2"  (ws_nomrep varchar,ws_idepcc varchar,wn_keyusu numeric,wn_keynom numeric, in_keyapr varchar,wn_numemi numeric,wn_maxmin numeric,wn_keypro numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
ws_desapr varchar(40);
ws_desnom varchar(40);
wd_fecpag timestamp(0);
wn_recibo numeric(10);
wn_import decimal(16,2);
wn_corte  numeric(5);
wn_keyemp numeric(10);
ws_nomemp varchar(60);
ws_keyapr varchar(20);
rec record;
begin
/* dmap converted statement start */
--lectura de registros
for rec in (select pam_cvesec,pam_nompar,nom_destip,rec_keyrec,rec_fecpag,rec_import,emp_keyemp,emp_nomemp
from usrsiho.glcopams,usrsiho.nmlonomi,usrsiho.holoreci,usrsiho.nmcoempl
where pam_keypar='H2'
and rtrim(rec_keyapr::text)=rtrim(pam_cvesec::text)
and rec_keynom=nom_keynom
and rec_keyemp=emp_keyemp
and rec_keynom=wn_keynom
and rec_numemi=wn_numemi
and rec_keypro=wn_keypro) loop
--definicion del corte
ws_keyapr := rec.pam_cvesec;/* dmap converted statement end */
ws_desapr := rec.pam_nompar;
ws_desnom := rec.nom_destip;
wn_recibo := rec.rec_keyrec;
wd_fecpag := rec.rec_fecpag;
wn_import := rec.rec_import;
wn_keyemp := rec.emp_keyemp;
ws_nomemp := rec.emp_nomemp;
if wn_import>wn_maxmin then
wn_corte:=1;
else
wn_corte:=2;
end if;
--inserccion de registros de paso
insert into usrsiho.glwkcrys(cry_nomrep,cry_idepcc,cry_keyusu,cry_dec006,cry_chr004,cry_chr018,
cry_chr003,cry_dat001,cry_dec008,cry_dec007,cry_dec001,cry_dec009,
cry_dec010,cry_chr001)
values (ws_nomrep ,ws_idepcc ,wn_keyusu ,wn_keynom ,ws_desnom,ws_keyapr ,
ws_desapr ,wd_fecpag ,wn_numemi ,wn_recibo ,wn_import ,wn_corte ,
wn_keyemp ,ws_nomemp);
end loop;end;
$body$
language plpgsql
;
