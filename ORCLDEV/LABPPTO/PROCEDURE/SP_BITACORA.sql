create or replace procedure labppto."sp_bitacora"  (wn_key_usu numeric, ws_log_usu varchar, ws_ide_pcc varchar, ws_tip_mov varchar, ws_key_001 varchar, ws_key_002 varchar, ws_key_003 varchar, ws_val_001 varchar, ws_val_002 varchar, ws_val_003 varchar, ws_des_men varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
--ws_fec_mov date     := sp_glgetfec;
ws_fec_mov char(10) := to_char(clock_timestamp(), 'dd/mm/yyyy');
ws_hor_mov varchar(8)  := sp_glgethor;
ws_ide_bit varchar(10) := '_BITACORA_';
begin
delete from labppto.glwkcrys
where cry_nomrep = ws_ide_bit and
cry_idepcc = ws_ide_pcc and
cry_keyusu = wn_key_usu;
insert into labppto.glwkcrys(cry_nomrep, cry_idepcc, cry_keyusu, cry_dat001, cry_chr012)
values (ws_ide_bit, ws_ide_pcc, wn_key_usu, clock_timestamp(), ws_hor_mov);
insert into labppto.glcobita(bit_keyusu, bit_logusu, bit_idepcc, bit_fecmov, bit_hormov,
bit_tipmov, bit_key001, bit_key002, bit_key003, bit_val001,
bit_val002, bit_val003, bit_desmen)
values (wn_key_usu, ws_log_usu, ws_ide_pcc, clock_timestamp(), ws_hor_mov,
ws_tip_mov, ws_key_001, ws_key_002, ws_key_003, ws_val_001,
ws_val_002, ws_val_003, ws_des_men);
--/* commit; */
end;
$body$
language plpgsql
;
