create or replace procedure usrsiho."sp_hplmantonew"  (s_idepro varchar, s_idepcc varchar, i_keyusu numeric, i_accion numeric, numplaza inout numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
-- ---------------------------------------------------------------------------------------------------------
-- variables de trabajo
wn_max_arr numeric(10);
wn_j numeric(10);
wi_numplz numeric(10);
wn_inicio numeric(10);
wn_max_plz numeric(10);
wn_ult_plz numeric(10);
wi_primer numeric(10);
wn_i numeric(10);
gn_totcap  numeric(10);
i_totcap   numeric(10);
wn_valsta  numeric(10);
gs_keyact  varchar(16);
gs_key_act varchar(16);
gs_des_act varchar(40);
gn_cos_tot numeric(10);
wn_num_plz numeric(10);
gs_keypro  varchar(16);
gs_keyprot varchar(16);
gs_key_pro varchar(16);
wn_valida  numeric(10);
tx_fec_ini varchar(10);
ws_plazaprimaria varchar(02);
ws_excepcion varchar(02);
i_movpla20 numeric(10);
i_movpla18 numeric(10);
gn_presup  numeric(10);
ws_valaux  varchar(16);
i_busca    numeric(10);
w_status   numeric(10);
wn_montomax numeric(10);
begin
-- ---------------------------------------------------------------------------------------------------------
-- limpia variables de trabajo
numplaza := 0;
if i_accion = 1 then -- inserta
begin
select arg_keycam
into strict gs_key_act
from usrsiho.glcoargu
where arg_idepro = s_idepro
and arg_idepcc = s_idepcc
and arg_keyusu = i_keyusu
and arg_pvalor = 'ALTA'
and arg_descam = 'gs_key_act';
exception when no_data_found then gs_key_act:= null;
end;
begin
select arg_keycam
into strict gs_des_act
from usrsiho.glcoargu
where arg_idepro = s_idepro
and arg_idepcc = s_idepcc
and arg_keyusu = i_keyusu
and arg_pvalor = 'ALTA'
and arg_keycam = 'gs_des_act';
exception when no_data_found then gs_des_act:= null;
end;
--       select arg_keycam
--       into gn_cos_tot
--       from usrsiho.glcoargu
--       where arg_idepro = s_idepro
--       and arg_idepcc = s_idepcc
--       and arg_keyusu = i_keyusu
--       and arg_pvalor = 'ALTA'
--       and arg_descam = 'gn_cos_tot';
begin
select arg_keycam
into strict ws_plazaprimaria
from usrsiho.glcoargu
where arg_idepro = s_idepro
and arg_idepcc = s_idepcc
and arg_keyusu = i_keyusu
and arg_pvalor = 'ALTA'
and arg_descam = 'ws_plazaprimaria';
exception when no_data_found then ws_plazaprimaria:= null;
end;
begin
select arg_keycam
into strict ws_excepcion
from usrsiho.glcoargu
where arg_idepro = s_idepro
and arg_idepcc = s_idepcc
and arg_keyusu = i_keyusu
and arg_pvalor = 'ALTA'
and arg_descam = 'ws_excepcion';
exception when no_data_found then ws_excepcion:= null;
end;
begin
select arg_keycam
into strict wn_num_plz
from usrsiho.glcoargu
where arg_idepro = s_idepro
and arg_idepcc = s_idepcc
and arg_keyusu = i_keyusu
and arg_pvalor = 'ALTA'
and arg_descam = 'wn_num_plz';
exception when no_data_found then wn_num_plz := 0;
end;
--       select arg_keycam
--       into wn_valida
--       from usrsiho.glcoargu
--       where arg_idepro = s_idepro
--       and arg_idepcc = s_idepcc
--       and arg_keyusu = i_keyusu
--       and arg_pvalor = 'ALTA'
--       and arg_descam = 'wn_valida';
begin
select arg_keycam
into strict tx_fec_ini
from usrsiho.glcoargu
where arg_idepro = s_idepro
and arg_idepcc = s_idepcc
and arg_keyusu = i_keyusu
and arg_pvalor = 'ALTA'
and arg_descam = 'tx_fec_ini';
exception when no_data_found then tx_fec_ini:= null;
end;
begin
select arg_keycam
into strict gs_key_pro
from usrsiho.glcoargu
where arg_idepro = s_idepro
and arg_idepcc = s_idepcc
and arg_keyusu = i_keyusu
and arg_pvalor = 'ALTA'
and arg_descam = 'gs_key_pro';
exception when no_data_found then gs_key_pro:= null;
end;
if wn_valida = 1 then
begin
select arg_keycam, arg_descam
into strict wi_primer, wn_j
from usrsiho.glcoargu
where arg_idepro = s_idepro
and arg_idepcc = s_idepcc
and arg_keyusu = i_keyusu
and arg_pvalor = 'ARREGLO';
exception when no_data_found then wi_primer := 0; wn_j := 0;
end;
else
wi_primer := 0;
wn_j := 0;
end if;
--       select arg_keycam
--       into gn_totcap
--       from usrsiho.glcoargu
--       where arg_idepro = s_idepro
--       and arg_idepcc = s_idepcc
--       and arg_keyusu = i_keyusu
--       and arg_pvalor = 'ALTA'
--       and arg_descam = 'gn_totcap';
begin
select arg_keycam
into strict wn_montomax
from usrsiho.glcoargu
where arg_idepro = s_idepro
and arg_idepcc = s_idepcc
and arg_keyusu = i_keyusu
and arg_pvalor = 'ALTA'
and arg_descam = 'wn_montomax';
exception when no_data_found then wn_montomax := 0;
end;
for wn_inicio in 1 .. wn_num_plz loop
wn_max_plz := 1; ---ctvo.plz. disponible
---inserta la plaza, indicando el usuario que la genera
insert into usrsiho.holoplza(plz_keyfol, plz_keytco, plz_keydep,
plz_keypue, plz_keyemp, plz_numcap, plz_capini,
plz_capfin, plz_keytab, plz_cosuni, plz_keytva,
plz_status, plz_fecini, plz_fecalt, plz_keyusg,
plz_hrsmod, plz_mtomax,plz_mtoeje,plz_primaria,plz_excep,plz_asig)
values (null, null, gs_key_pro,
gs_key_act, null, null, wi_primer,
wn_j, null, 0, 0,
0, tx_fec_ini, trunc(clock_timestamp()), i_keyusu,
null,wn_montomax,null,ws_plazaprimaria,ws_excepcion,0);
--wn_ult_plz :=  sp_lee_serial();
select max(plz_ctvplz)
into strict   wn_ult_plz
from   usrsiho.holoplza;
--select max(plz_ctvplz)
--into wn_ult_plz
---from holoplza;
--if wn_ult_plz = 0 then
--   let wn_ult_plz = 1;
--end if;
end loop;
--return wn_ult_plz;
end if;
if i_accion = 2  then -- borra
begin
select arg_keycam
into strict gs_keyact
from usrsiho.glcoargu
where arg_idepro = s_idepro
and arg_idepcc = s_idepcc
and arg_keyusu = i_keyusu
and arg_pvalor = 'BAJA'
and arg_descam = 'gs_keyact';
exception when no_data_found then gs_keyact:= null;
end;
begin
select oracle.substr(arg_keycam,1,6),arg_keycam
into strict gs_keypro, gs_keyprot
from usrsiho.glcoargu
where arg_idepro = s_idepro
and arg_idepcc = s_idepcc
and arg_keyusu = i_keyusu
and arg_pvalor = 'BAJA'
and arg_descam = 'gs_keypro';
exception when no_data_found then gs_keypro:= null; gs_keyprot:= null;
end;
begin
select arg_keycam
into strict ws_valaux
from usrsiho.glcoargu
where arg_idepro = s_idepro
and arg_idepcc = s_idepcc
and arg_keyusu = i_keyusu
and arg_pvalor = 'BAJA'
and arg_descam = 'ws_valaux';
exception when no_data_found then ws_valaux:= null;
end;
begin
select arg_keycam
into strict wi_numplz
from usrsiho.glcoargu
where arg_idepro = s_idepro
and arg_idepcc = s_idepcc
and arg_keyusu = i_keyusu
and arg_pvalor = 'BAJA'
and arg_descam = 'wi_numplz';
exception when no_data_found then wi_numplz := 0;
end;
begin
select plz_status
into strict w_status
from usrsiho.holoplza
where plz_ctvplz = wi_numplz
and plz_asig = ws_valaux;
exception when no_data_found then w_status := 0;
end;
if w_status = 1 then
-- codigo que actualiza el presupuesto ejercido = presupuesto ejercido - costo de la plaza
--         update hologlpr set glp_ejerci = glp_ejerci - gn_presup
--         where glp_keydep = gs_keypro
--         and glp_keypue = gs_keyact;
update usrsiho.holoplza set plz_status =0
where plz_ctvplz = wi_numplz
and plz_keydep = gs_keyprot and plz_asig = ws_valaux;
else
if w_status = 0 then
insert into usrsiho.glwkcrys(cry_nomrep,cry_numsec,cry_chr001 ) values ('claudia',1,ws_valaux);
insert into usrsiho.glwkcrys(cry_nomrep,cry_numsec,cry_chr001 ) values ('claudia',2,gs_keyact);
insert into usrsiho.glwkcrys(cry_nomrep,cry_numsec,cry_chr001 ) values ('claudia',3,gs_keyprot);
insert into usrsiho.glwkcrys(cry_nomrep,cry_numsec,cry_chr001 ) values ('claudia',4,wi_numplz);
delete from usrsiho.holoplza where plz_keydep =gs_keyprot and plz_keypue = gs_keyact and plz_ctvplz = wi_numplz and plz_asig =ws_valaux;
end if;
end if;
end if;
if i_accion = 3 then -- autoriza de 0 -> 1 ?? 1 -> 0
begin
select arg_keycam
into strict gs_keypro
from usrsiho.glcoargu
where arg_idepro = s_idepro
and arg_idepcc = s_idepcc
and arg_keyusu = i_keyusu
and arg_pvalor = 'MODI'
and arg_descam = 'gs_keypro';
exception when no_data_found then gs_keypro:= null;
end;
begin
select arg_keycam
into strict gs_keyact
from usrsiho.glcoargu
where arg_idepro = s_idepro
and arg_idepcc = s_idepcc
and arg_keyusu = i_keyusu
and arg_pvalor = 'MODI'
and arg_descam = 'gs_keyact';
exception when no_data_found then gs_keyact:= null;
end;
begin
select arg_keycam
into strict gn_presup
from usrsiho.glcoargu
where arg_idepro = s_idepro
and arg_idepcc = s_idepcc
and arg_keyusu = i_keyusu
and arg_pvalor = 'MODI'
and arg_descam = 'gn_presup';
exception when no_data_found then gn_presup := 0;
end;
begin
select arg_keycam
into strict ws_valaux
from usrsiho.glcoargu
where arg_idepro = s_idepro
and arg_idepcc = s_idepcc
and arg_keyusu = i_keyusu
and arg_pvalor = 'MODI'
and arg_descam = 'ws_valaux';
exception when no_data_found then ws_valaux:= null;
end;
begin
select arg_keycam
into strict wn_valsta
from usrsiho.glcoargu
where arg_idepro = s_idepro
and arg_idepcc = s_idepcc
and arg_keyusu = i_keyusu
and arg_pvalor = 'MODI'
and arg_descam = 'wn_valsta';
exception when no_data_found then wn_valsta := 0;
end;
begin
select arg_keycam
into strict wi_numplz
from usrsiho.glcoargu
where arg_idepro = s_idepro
and arg_idepcc = s_idepcc
and arg_keyusu = i_keyusu
and arg_pvalor = 'MODI'
and arg_descam = 'wi_numplz';
exception when no_data_found then wi_numplz := 0;
end;
---pasa de pendiente a autorizada  (0--->1)
if wn_valsta = 0 then
update usrsiho.holoplza set plz_status = 1, plz_keyusg = i_keyusu
where plz_ctvplz = wi_numplz and plz_asig = ws_valaux;
end if;
---pasa de autorizada a pendiente  (1--->0)
if wn_valsta = 1 then
update usrsiho.holoplza set plz_status = 0, plz_keyusg = i_keyusu
where plz_ctvplz = wi_numplz and plz_asig = ws_valaux;
end if;
wn_ult_plz := wi_numplz;
--return wn_ult_plz;
end if;
numplaza := wn_ult_plz;end;
$body$
language plpgsql
;
