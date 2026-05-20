create or replace procedure usrsiho."sp_fecha"  () as $body$
declare
-- pgv moved types start
-- pgv moved types end
wd_fec_mov timestamp(0);
ws_ide_fec varchar(10);
ws_ide_hor varchar(8);
begin
ws_ide_fec := '_FECHADIA_';
--sp_glfechor(wd_fec_mov, ws_ide_hor);
wd_fec_mov := trunc(clock_timestamp());
ws_ide_hor  := to_char(clock_timestamp(), 'HH24:MI:SS');
delete from glwkcrys
where cry_nomrep = ws_ide_fec;
insert into glwkcrys(cry_nomrep, cry_dat001, cry_chr012, cry_chr017)
values (ws_ide_fec, wd_fec_mov, user, ws_ide_hor);end;
$body$
language plpgsql
;
