create or replace  function  fecxc."time_diff"  ( metrica varchar default ('S'), fecha_1 timestamp(0) default null, fecha_2 timestamp(0)  default null) returns numeric as $body$
declare
-- pgv moved types start
-- pgv moved types end
nfecha_1 numeric;
nfecha_2 numeric;
nsegundos_1 numeric(5);
nsegundos_2 numeric(5);
tiempo numeric;
begin
-- toma el # de la fecha juliana de la primera fecha
nfecha_1 := (to_char(fecha_1, 'J'))::numeric;
-- toma el # de la fecha juliana de la segunda fecha
nfecha_2 := (to_char(fecha_2, 'J'))::numeric;
-- toma segundos desde la medianoche de la primera fecha
nsegundos_1 := (to_char(fecha_1, 'SSSSS'))::numeric;
-- toma segundos desde la medianoche de la segunda fecha
nsegundos_2 := (to_char(fecha_2, 'SSSSS'))::numeric;
tiempo:= ((nfecha_2 - nfecha_1)  * 86400)+(nsegundos_2 - nsegundos_1)* interval '1 day' ;
-- define la respuesta en funcion de la metrica
tiempo:= floor(tiempo / case upper(metrica)
when 'Y' then (12 * 30.4167 * 60 * 60 * 24)
when 'M' then (30.4167 * 60 * 60 * 24)
when 'D' then (60 * 60 * 24)
when 'H' then (60 * 60)
when 'MI' then 60
else 1 end);
return(tiempo);end;
--dmap converted function completed
$body$
language plpgsql
stable;
