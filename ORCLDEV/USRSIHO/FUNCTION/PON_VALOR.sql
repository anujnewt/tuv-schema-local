create or replace  function  usrsiho."pon_valor"  (ws_cadena varchar, wi_posicion integer, ws_valor varchar) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
ws_resultado varchar(10):= null;
wi_contador integer := 0;
wi_longitud integer :=0;
begin
wi_longitud := length(ws_cadena);/* dmap converted statement start */
for wi_contador in 1 .. 10 loop
if wi_contador = wi_posicion then
ws_resultado :=  concat(ws_resultado, ws_valor) ;/* dmap converted statement end *//* dmap converted statement start */
else
if wi_contador > wi_longitud then
ws_resultado :=  concat(ws_resultado, ' ') ;/* dmap converted statement end *//* dmap converted statement start */
else
ws_resultado :=  concat(ws_resultado, oracle.substr(ws_cadena, wi_contador, 1)) ;/* dmap converted statement end */
end if;
end if;
end loop;
-- ws_resultado := ws_cadena || ' MUNDO';
return(ws_resultado);end;
--dmap converted function completed
$body$
language plpgsql
stable;
