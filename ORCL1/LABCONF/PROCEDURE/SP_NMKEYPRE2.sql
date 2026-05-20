create or replace procedure labconf."sp_nmkeypre2"  (ws_ide_pcc varchar,wn_tot_mov inout numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
wn_fec_mov numeric(10);
wn_hor_mov numeric(10);
wn_min_mov numeric(10);
wn_seg_mov numeric(10);
wd_fec_dia timestamp(0);
ws_hor_dia varchar(8);
begin
--sp_glfechor(wd_fec_dia, ws_hor_dia);
wd_fec_dia := clock_timestamp();
ws_hor_dia := to_char(clock_timestamp(), 'HH24:MI:SS');
wn_fec_mov := (to_char(wd_fec_dia,'J'))::numeric;
wn_hor_mov:= oracle.substr(ws_hor_dia,1,2);
wn_min_mov:= oracle.substr(ws_hor_dia,4,2);
wn_seg_mov:= oracle.substr(ws_hor_dia,7,2);
wn_tot_mov:=(( wn_hor_mov*3600)+(wn_min_mov*60)* interval '1 day' );
wn_tot_mov:=(wn_tot_mov+wn_seg_mov);
wn_tot_mov:=(wn_tot_mov/100000.0);
wn_tot_mov:=(wn_tot_mov+wn_fec_mov);end;
$body$
language plpgsql
;
