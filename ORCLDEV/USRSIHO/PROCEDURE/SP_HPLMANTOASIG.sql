create or replace procedure usrsiho."sp_hplmantoasig"  (s_idepro varchar, s_idepcc varchar, i_keyusu numeric, i_accion numeric) as $body$
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
wi_primer numeric(10);
wn_i numeric(10);
gn_totcap  numeric(10);
lnkeyfol   numeric(10);
i_totcap   numeric(10);
wn_valsta  numeric(10);
gs_keyact  varchar(16);
gs_key_act varchar(16);
gs_mtomax numeric(10);
gn_cos_tot numeric(10);
wn_num_plz numeric(10);
gs_keypro  varchar(16);
gs_keyprot varchar(16);
gs_key_pro varchar(16);
wn_valida  numeric(10);
tx_fec_ini varchar(10);
tx_fec_ven varchar(10);
ws_plazaprimaria varchar(02);
i_movpla20 numeric(10);
i_movpla18 numeric(10);
gn_presup  numeric(10);
ws_valaux  varchar(16);
i_busca    numeric(10);
w_status   numeric(10);
wn_keyemp  numeric(10);
ws_excepcion varchar(02);
li_err_num numeric(10);
begin
-- ---------------------------------------------------------------------------------------------------------
-- limpia variables de trabajo
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
into strict gs_mtomax
from usrsiho.glcoargu
where arg_idepro = s_idepro
and arg_idepcc = s_idepcc
and arg_keyusu = i_keyusu
and arg_pvalor = 'ALTA'
and arg_descam = 'gs_des_act';
exception when no_data_found then gs_mtomax:= null;
end;
--      select arg_keycam
--        into gn_cos_tot
--        from usrsiho.glcoargu
--       where arg_idepro = s_idepro
--         and arg_idepcc = s_idepcc
--         and arg_keyusu = i_keyusu
--         and arg_pvalor = 'ALTA'
--         and arg_descam = 'gn_cos_tot';
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
into strict wn_num_plz
from usrsiho.glcoargu
where arg_idepro = s_idepro
and arg_idepcc = s_idepcc
and arg_keyusu = i_keyusu
and arg_pvalor = 'ALTA'
and arg_descam = 'wn_num_plz';
exception when no_data_found then ws_plazaprimaria := 0;
end;
--      select arg_keycam
--        into wn_valida
--        from usrsiho.glcoargu
--       where arg_idepro = s_idepro
--         and arg_idepcc = s_idepcc
--         and arg_keyusu = i_keyusu
--         and arg_pvalor = 'ALTA'
--         and arg_descam = 'wn_valida';
--      select arg_keycam
--        into tx_fec_ini
--        from usrsiho.glcoargu
--       where arg_idepro = s_idepro
--         and arg_idepcc = s_idepcc
--         and arg_keyusu = i_keyusu
--         and arg_pvalor = 'ALTA'
--         and arg_descam = 'tx_fec_ini';
--     select arg_keycam
--       into tx_fec_ven
--       from usrsiho.glcoargu
--      where arg_idepro = s_idepro
--        and arg_idepcc = s_idepcc
--        and arg_keyusu = i_keyusu
--        and arg_pvalor = 'ALTA'
--        and arg_descam = 'tx_fec_ven';
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
-- no inserta valor para wn_valida el programa
--     if wn_valida = 1 then
--        select arg_keycam, arg_descam
--          into wi_primer, wn_j
--          from usrsiho.glcoargu
--         where arg_idepro = s_idepro
--           and arg_idepcc = s_idepcc
--           and arg_keyusu = i_keyusu
--           and arg_pvalor = 'ARREGLO';
--     else
wi_primer := 0;
wn_j := 0;
--     end if;
--     select arg_keycam
--       into gn_totcap
--       from usrsiho.glcoargu
--      where arg_idepro = s_idepro
--        and arg_idepcc = s_idepcc
--        and arg_keyusu = i_keyusu
--        and arg_pvalor = 'ALTA'
--        and arg_descam = 'gn_totcap';
begin
select arg_keycam
into strict wn_keyemp
from usrsiho.glcoargu
where arg_idepro = s_idepro
and arg_idepcc = s_idepcc
and arg_keyusu = i_keyusu
and arg_pvalor = 'ALTA'
and arg_descam = 'wn_keyemp';
exception when no_data_found then wn_keyemp := 0;
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
--contorl de errores
-- set lock mode to wait;
--   lock table holoplza in exclusive mode;
begin
select max(plz_asig)
into strict lnkeyfol
from holoplza
where plz_ctvplz = wn_num_plz;
exception when no_data_found then lnkeyfol := 0;
end;
-- si es el primero se asigna uno
if nullif(lnkeyfol::text, '') is null then
lnkeyfol := 1;
else
lnkeyfol := lnkeyfol + 1;
end if;
---inserta la plaza, indicando el usuario que la genera
insert into holoplza(plz_ctvplz,plz_keyfol, plz_keytco, plz_keydep,
plz_keypue, plz_keyemp, plz_numcap, plz_capini,
plz_capfin, plz_keytab, plz_cosuni, plz_keytva,
plz_status, plz_fecini, plz_fecalt, plz_keyusg,
plz_hrsmod, plz_mtomax,plz_mtoeje,plz_primaria,
plz_fecven,plz_asig,plz_excep)
values (wn_num_plz,null, null, gs_key_pro,
gs_key_act, wn_keyemp, null, wi_primer,
wn_j, null, 0, 0,
0, null, trunc(clock_timestamp()), i_keyusu,
null,gs_mtomax,null,ws_plazaprimaria,
null,lnkeyfol,ws_excepcion);
-- unlock table holoplza;
-- end;
end if;end;
$body$
language plpgsql
;
