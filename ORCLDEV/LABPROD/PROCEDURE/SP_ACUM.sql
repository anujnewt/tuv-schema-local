create or replace procedure labprod."sp_acum"  (empleado integer, acumulado inout numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
wd_impsal         decimal(14,2);
ws_num_mes    integer;
begin
-----------------------------------------------
if month(clock_timestamp()) > 1 then
ws_num_mes := month(clock_timestamp()) - 1;
else
ws_num_mes := 12;
end if;
if ws_num_mes = 1 then
select coalesce(sum(acu_impuno), 0) into strict wd_impsal from (
select acu_impuno from nmloacum,nmloconc
where acu_keyemp = empleado
and acu_keycon in (select pam_cvesec
from glcopams
where pam_keypar = 'DFI')
and acu_keycon = con_keycon
and acu_impuno > 0
and acu_anioac = year(clock_timestamp())
) alias5;
end if;
if ws_num_mes = 2 then
select coalesce(sum(acu_impdos), 0) into strict wd_impsal from (
select acu_impdos from nmloacum,nmloconc
where acu_keyemp = empleado
and acu_keycon in (select pam_cvesec
from glcopams
where pam_keypar = 'DFI')
and acu_keycon = con_keycon
and acu_impdos > 0
and acu_anioac = year(clock_timestamp())
) alias5;
end if;
if ws_num_mes = 3 then
select coalesce(sum(acu_imptre), 0) into strict wd_impsal from (
select acu_imptre from nmloacum,nmloconc
where acu_keyemp = empleado
and acu_keycon in (select pam_cvesec
from glcopams
where pam_keypar = 'DFI')
and acu_keycon = con_keycon
and acu_imptre > 0
and acu_anioac = year(clock_timestamp())
) alias5;
end if;
if ws_num_mes = 4 then
select coalesce(sum(acu_impcua), 0) into strict wd_impsal from (
select acu_impcua from nmloacum,nmloconc
where acu_keyemp = empleado
and acu_keycon in (select pam_cvesec
from glcopams
where pam_keypar = 'DFI')
and acu_keycon = con_keycon
and acu_impcua > 0
and acu_anioac = year(clock_timestamp())
) alias5;
end if;
if ws_num_mes = 5 then
select coalesce(sum(acu_impcin), 0) into strict wd_impsal from (
select acu_impcin from nmloacum,nmloconc
where acu_keyemp = empleado
and acu_keycon in (select pam_cvesec
from glcopams
where pam_keypar = 'DFI')
and acu_keycon = con_keycon
and acu_impcin > 0
and acu_anioac = year(clock_timestamp())
) alias5;
end if;
if ws_num_mes = 6 then
select coalesce(sum(acu_impsei), 0) into strict wd_impsal from (
select acu_impsei from nmloacum,nmloconc
where acu_keyemp = empleado
and acu_keycon in (select pam_cvesec
from glcopams
where pam_keypar = 'DFI')
and acu_keycon = con_keycon
and acu_impsei > 0
and acu_anioac = year(clock_timestamp())
) alias5;
end if;
if ws_num_mes = 7 then
select coalesce(sum(acu_impsie), 0) into strict wd_impsal from (
select acu_impsie from nmloacum,nmloconc
where acu_keyemp = empleado
and acu_keycon in (select pam_cvesec
from glcopams
where pam_keypar = 'DFI')
and acu_keycon = con_keycon
and acu_impsie > 0
and acu_anioac = year(clock_timestamp())
) alias5;
end if;
if ws_num_mes = 8 then
select coalesce(sum(acu_impoch), 0) into strict wd_impsal from (
select acu_impoch from nmloacum,nmloconc
where acu_keyemp = empleado
and acu_keycon in (select pam_cvesec
from glcopams
where pam_keypar = 'DFI')
and acu_keycon = con_keycon
and acu_impoch > 0
and acu_anioac = year(clock_timestamp())
) alias5;
end if;
if ws_num_mes = 9 then
select coalesce(sum(acu_impnue), 0) into strict wd_impsal from (
select acu_impnue from nmloacum,nmloconc
where acu_keyemp = empleado
and acu_keycon in (select pam_cvesec
from glcopams
where pam_keypar = 'DFI')
and acu_keycon = con_keycon
and acu_impnue > 0
and acu_anioac = year(clock_timestamp())
) alias5;
end if;
if ws_num_mes = 10 then
select coalesce(sum(acu_impdie), 0) into strict wd_impsal from (
select acu_impdie from nmloacum,nmloconc
where acu_keyemp = empleado
and acu_keycon in (select pam_cvesec
from glcopams
where pam_keypar = 'DFI')
and acu_keycon = con_keycon
and acu_impdie > 0
and acu_anioac = year(clock_timestamp())
) alias5;
end if;
if ws_num_mes = 11 then
select coalesce(sum(acu_imponc), 0) into strict wd_impsal from (
select acu_imponc from nmloacum,nmloconc
where acu_keyemp = empleado
and acu_keycon in (select pam_cvesec
from glcopams
where pam_keypar = 'DFI')
and acu_keycon = con_keycon
and acu_imponc > 0
and acu_anioac = year(clock_timestamp())
) alias5;
end if;
if ws_num_mes = 12 then
select coalesce(sum(acu_impdoc), 0) into strict wd_impsal from (
select acu_impdoc from nmloacum,nmloconc
where acu_keyemp = empleado
and acu_keycon in (select pam_cvesec
from glcopams
where pam_keypar = 'DFI')
and acu_keycon = con_keycon
and acu_impdoc > 0
and acu_anioac = year(clock_timestamp())-1
) alias5;
end if;
acumulado := wd_impsal;end;
$body$
language plpgsql
;
