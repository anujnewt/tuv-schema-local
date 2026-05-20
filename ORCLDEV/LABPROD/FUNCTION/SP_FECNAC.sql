create or replace  function  labprod."sp_fecnac"  (vn_regrfc varchar) returns timestamp(0) as $body$
declare
-- pgv moved types start
-- pgv moved types end
anio varchar(2);
mes  varchar(2);
dia  varchar(2);
vs_fecnac varchar(10);
vd_fecnac timestamp(0);
begin
anio := oracle.substr(vn_regrfc,5,2);
mes  := oracle.substr(vn_regrfc,7,2);
dia  := oracle.substr(vn_regrfc,9,2);
if (mes)::numeric   =  0 or
(dia)::numeric   =  0 or
(anio)::numeric  =  0
then
mes := '01';
dia := '01';
anio := '51';
end if;/* dmap converted statement start */
if (anio > 01) and anio < 99 then
if mes > 0 and mes < 13 then
if dia > 0 and dia < 32 then
vs_fecnac :=  concat(dia, '/', mes, '/19', anio) ;/* dmap converted statement end */
vd_fecnac := to_timestamp(vs_fecnac,'dd/mm/yyyy');
else
vd_fecnac := '01/01/1951';
end if;
else
vd_fecnac := '01/01/1951';
end if;
else
vd_fecnac := '01/01/1951';
end if;
return vd_fecnac;end;
--dmap converted function completed
$body$
language plpgsql
stable;
