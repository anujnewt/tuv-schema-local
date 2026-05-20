create or replace procedure labconf."sp_nmkeypre"  (ws_ide_pcc varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
wn_fec_mov numeric(10);
wn_hor_mov numeric(10);
wn_min_mov numeric(10);
wn_seg_mov numeric(10);
wn_tot_mov decimal(16,6);
wd_fec_dia timestamp(0);
ws_hor_dia varchar(8);
begin
call sp_glfechor (wd_fec_dia, ws_hor_dia);
wn_fec_mov := (to_char(wd_fec_dia,'J'))::numeric;
wn_hor_mov:= oracle.substr(ws_hor_dia,1,2);
wn_min_mov:= oracle.substr(ws_hor_dia,4,2);
wn_seg_mov:= oracle.substr(ws_hor_dia,7,2);
wn_tot_mov:=(( wn_hor_mov*3600)+(wn_min_mov*60)* interval '1 day' );
wn_tot_mov:=(wn_tot_mov+wn_seg_mov);
wn_tot_mov:=(wn_tot_mov/100000.0);
wn_tot_mov:=(wn_tot_mov+wn_fec_mov);
delete from glwkcrys
where cry_idepcc=ws_ide_pcc
and cry_nomrep='KEYPRE'
and nullif(cry_nomrep::text, '') is not null;
insert into glwkcrys( cry_nomrep,cry_idepcc,cry_dec001)
values ('KEYPRE',ws_ide_pcc,wn_tot_mov);end;
$body$
language plpgsql
;
