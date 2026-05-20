create or replace procedure labprod."sp_vac_insertarperiodoant"  ( keyemp numeric, fecini timestamp(0), fecing timestamp(0), keypro integer, keyloc varchar, numani inout numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
antiguedad decimal(10,2);
diader decimal(10,2);
keytab varchar(6);
feccad timestamp(0);
begin
--buscar si el periodo anticipado ya fue creado
begin
select dia_numani into strict numani
from labprod.molodiad
where dia_keyemp = keyemp
and dia_fecini = fecini;
exception
when no_data_found then
numani := 0;
end;/* dmap converted statement start */
if numani > 0 then
perform dbms_output.put_line( concat('PERIODO YA EXISTE NUMANI = ', numani)) ;/* dmap converted statement end */
return;
end if;
keytab := labprod.fn_vac_tabladias(keypro,keyloc);/* dmap converted statement start */
perform dbms_output.put_line( concat('KEYTAB = ', keytab)) ;/* dmap converted statement end */
diader := labprod.fn_vac_diasderecho(keyemp,fecing,fecini,keypro,keytab);/* dmap converted statement start */
perform dbms_output.put_line( concat('DIADER = ', diader)) ;/* dmap converted statement end */
feccad := add_months(fecini,18) - '1 days'::interval;
begin
insert into labprod.molodiad(dia_keyemp,dia_keycon,dia_diader,dia_fecini,dia_feccad,dia_diaant,dia_keyusu,dia_fecact,dia_diasal,dia_numani)
values (keyemp,'VA',diader,fecini,feccad,0,keyemp,clock_timestamp(),diader,year(fecini));
numani := year(fecini);
exception
when others then
numani := 0;
end;end;
$body$
language plpgsql
;
