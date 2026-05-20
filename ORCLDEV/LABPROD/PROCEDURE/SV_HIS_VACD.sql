create or replace procedure labprod."sv_his_vacd"  ( num integer, his_vacd inout refcursor) as $body$
--fec_ini out date,
--fec_fin out date,
--dia_tom out decimal,
--per_tom out char)
declare
-- pgv moved types start
-- pgv moved types end
begin
open his_vacd for select rva_fecini, rva_fecfin, rva_diadis, rva_period from nmcorvac where rva_keyemp = num;end;
$body$
language plpgsql
;
