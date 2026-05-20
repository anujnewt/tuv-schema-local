create or replace  function  labconf."fn_metodopago"  ( keyemp numeric, keypro numeric, keyper varchar, forpag varchar, forval varchar ) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
neto numeric;
vale numeric;
resultado varchar(20);
begin
if forpag = 'NA' then
return 'NA';
end if;
select
sum(case when pam_folini = 'NETO' then his_import else 0 end) neto,
sum(case when pam_folini = 'VALE' then his_import else 0 end) vale
into strict neto,vale
from labconf.nmlohism
inner join labconf.glcopams on pam_keypar = 'METP' and pam_cvesec = his_keycon
where his_keypro = keypro
and his_keyper = keyper
and his_keyemp = keyemp;
if vale = 0 then
resultado := forpag;
elsif neto = 0 then
resultado := forval;/* dmap converted statement start */
elsif neto >= vale then
resultado :=  concat(forpag, ',', forval) ;/* dmap converted statement end *//* dmap converted statement start */
else
resultado :=  concat(forval, ',', forpag) ;/* dmap converted statement end */
end if;
return resultado;end;
--dmap converted function completed
$body$
language plpgsql
stable;
