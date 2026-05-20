create or replace  function  labprod."cantidadconletra"  ( p_numero numeric ) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_impletra varchar(180);
v_lnentero numeric(10);
v_lcretorno varchar(512);
v_lnterna numeric(10);
v_lcmiles varchar(512);
v_lccadena varchar(512);
v_lnunidades numeric(10);
v_lndecenas numeric(10);
v_lncentenas numeric(10);
v_lnfraccion numeric(10);
v_sfraccion varchar(15);
begin
v_lnentero := trunc(p_numero);
v_lnfraccion := (p_numero - v_lnentero) * 100;
v_lcretorno:= null;
v_lnterna := 1;
while v_lnentero > 0
loop /* while */
v_lccadena:= null;
v_lnunidades := mod(v_lnentero,10);
v_lnentero := trunc(v_lnentero/10);
v_lndecenas := mod(v_lnentero,10);
v_lnentero := trunc(v_lnentero/10);
v_lncentenas := mod(v_lnentero,10);
v_lnentero := trunc(v_lnentero/10);/* dmap converted statement start */
select
case /* unidades */
when v_lnunidades = 1 then  concat('UN ', v_lccadena
) when v_lnunidades = 2 then  concat('DOS ', v_lccadena
) when v_lnunidades = 3 then  concat('TRES ', v_lccadena
) when v_lnunidades = 4 then  concat('CUATRO ', v_lccadena
) when v_lnunidades = 5 then  concat('CINCO ', v_lccadena
) when v_lnunidades = 6 then  concat('SEIS ', v_lccadena
) when v_lnunidades = 7 then  concat('SIETE ', v_lccadena
) when v_lnunidades = 8 then  concat('OCHO ', v_lccadena
) when v_lnunidades = 9 then  concat('NUEVE ', v_lccadena
) else v_lccadena
end  into strict v_lccadena; /* dmap converted statement end *//* dmap converted statement start *//* unidades */
-- analizo las decenas
-- sqlines license for evaluation use only
v_lccadena :=
case /* decenas */
when v_lndecenas = 1 then
case v_lnunidades
when 0 then 'DIEZ '
when 1 then 'ONCE '
when 2 then 'DOCE '
when 3 then 'TRECE '
when 4 then 'CATORCE '
when 5 then 'QUINCE '
when 6 then 'DIEZ Y SEIS '
when 7 then 'DIEZ Y SIETE '
when 8 then 'DIEZ Y OCHO '
when 9 then 'DIEZ Y NUEVE '
end
when v_lndecenas = 2 then
case v_lnunidades
when 0 then 'VEINTE '
else  concat('VEINTI', v_lccadena
) end
when v_lndecenas = 3 then
case v_lnunidades
when 0 then 'TREINTA '
else  concat('TREINTA Y ', v_lccadena
) end
when v_lndecenas = 4 then
case v_lnunidades
when 0 then 'CUARENTA'
else  concat('CUARENTA Y ', v_lccadena
) end
when v_lndecenas = 5 then
case v_lnunidades
when 0 then 'CINCUENTA '
else  concat('CINCUENTA Y ', v_lccadena
) end
when v_lndecenas = 6 then
case v_lnunidades
when 0 then 'SESENTA '
else  concat('SESENTA Y ', v_lccadena
) end
when v_lndecenas = 7 then
case v_lnunidades
when 0 then 'SETENTA '
else  concat('SETENTA Y ', v_lccadena
) end
when v_lndecenas = 8 then
case v_lnunidades
when 0 then 'OCHENTA '
else   concat('OCHENTA Y ', v_lccadena
) end
when v_lndecenas = 9 then
case v_lnunidades
when 0 then 'NOVENTA '
else  concat('NOVENTA Y ', v_lccadena
) end
else v_lccadena
end; /* dmap converted statement end *//* dmap converted statement start *//* decenas */
v_lccadena :=
case /* centenas */
when v_lncentenas = 1 then  concat('CIENTO ', v_lccadena
) when v_lncentenas = 2 then  concat('DOSCIENTOS ', v_lccadena
) when v_lncentenas = 3 then  concat('TRESCIENTOS ', v_lccadena
) when v_lncentenas = 4 then  concat('CUATROCIENTOS ', v_lccadena
) when v_lncentenas = 5 then  concat('QUINIENTOS ', v_lccadena
) when v_lncentenas = 6 then  concat('SEISCIENTOS ', v_lccadena
) when v_lncentenas = 7 then  concat('SETECIENTOS ', v_lccadena
) when v_lncentenas = 8 then  concat('OCHOCIENTOS ', v_lccadena
) when v_lncentenas = 9 then  concat('NOVECIENTOS ', v_lccadena
) else v_lccadena
end; /* dmap converted statement end *//* dmap converted statement start *//* centenas */
v_lccadena :=
case /* terna */
when v_lnterna = 1 then v_lccadena
when v_lnterna = 2 then  concat(v_lccadena, 'MIL '
) when v_lnterna = 3 then  concat(v_lccadena, 'MILLONES '
) when v_lnterna = 4 then  concat(v_lccadena, 'MIL '
) else ''
end; /* dmap converted statement end *//* dmap converted statement start *//* terna */
v_lcretorno :=  concat(v_lccadena, v_lcretorno) ;/* dmap converted statement end */
v_lnterna := v_lnterna + 1;
end loop; /* while */
if v_lnterna = 1 then
v_lcretorno := 'CERO';
end if;/* dmap converted statement start */
v_sfraccion :=  concat('00', ltrim(to_char(v_lnfraccion)::text)) ;/* dmap converted statement end *//* dmap converted statement start */
-- sqlines license for evaluation use only
v_impletra := concat( rtrim(v_lcretorno::text), ' PESOS ' , oracle.substr(v_sfraccion,length(rtrim(v_sfraccion::text))-1,2) , '/100 M.N.') ;/* dmap converted statement end */
return v_impletra;end;
--dmap converted function completed
$body$
language plpgsql
stable;
