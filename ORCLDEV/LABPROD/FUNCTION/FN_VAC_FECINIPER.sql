create or replace  function  labprod."fn_vac_feciniper"  ( keyemp numeric , fecsol timestamp(0) , fecing timestamp(0) ) returns timestamp(0) as $body$
declare
-- pgv moved types start
-- pgv moved types end
numani integer;
fecini timestamp(0);
anio_per integer;
str_fecini varchar(10);
begin
--a partir del n?mero de empleado y la fecha de solicitud
--busca cual ser?a la fecha de inicio del siguiente periodo vacacional
anio_per := year(fecsol);/* dmap converted statement start */
str_fecini := concat( day(fecing), '/', month(fecing), '/', anio_per) ;/* dmap converted statement end */
fecini := to_timestamp(str_fecini,'dd/mm/yyyy');
if fecini < fecsol then
anio_per := anio_per + 1;/* dmap converted statement start */
str_fecini := concat( day(fecing), '/', month(fecing), '/', anio_per) ;/* dmap converted statement end */
fecini := to_timestamp(str_fecini,'dd/mm/yyyy');
end if;
return fecini;end;
--dmap converted function completed
$body$
language plpgsql
stable;
