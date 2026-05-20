create or replace  function  usrsiho."sp_diftiempo2"  (li_minent numeric, li_minsal numeric) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
--returning decimal(10,2);
-- -----------------------------------------------------------------
-- sp_diftiempo: este stored procedure es el que utiliza en el
-- reporte de trabajo del modulo de llamado de actores de honorarios
-- para obtener las la diferencia en horas y minutos entre la
-- hora de entrada y salida que se captura en el llamado.
-- devuelve un decimal con el numero de horas y minutos
-- realizado el 29 de septiembre de 2005
-- emilio pulido rangel
-- -----------------------------------------------------------------
li_mindif numeric(10);
li_resmin numeric(10);
ls_mindif varchar(2);
ls_resmin varchar(2);
li_diftie decimal(10,2);
begin
li_mindif := 0;
li_resmin := 0;
ls_mindif:= null;
ls_resmin:= null;
if nullif(li_minent::text, '') is null or nullif(li_minsal::text, '') is null then
return '0.0';
end if;
if li_minent = 0 then
return '0.0';
end if;
-- ---------------------------------------------------------
-- obtenemos la diferencia entre minutos de entrada y salida
-- ---------------------------------------------------------
if li_minsal >= li_minent then
li_mindif := li_minsal - li_minent;
else -- salio al dia siguiente de que entro
li_mindif := 1440 + li_minsal - li_minent;
end if;
li_resmin := mod(li_mindif,60);
li_mindif := li_mindif / 60;
ls_mindif := li_mindif;
ls_resmin := li_resmin;/* dmap converted statement start */
return  concat(ls_mindif, '.' , ls_resmin) ;/* dmap converted statement end */
-- regresamos en un decimal las horas y minutos
--let li_diftie = li_mindif/60;
--return li_diftie;
end;
--dmap converted function completed
$body$
language plpgsql
stable;
