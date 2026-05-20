create or replace  function  labprod."edad"  (ws_reg varchar) returns integer as $body$
declare
-- pgv moved types start
-- pgv moved types end
-- variables para la carga de la tabla de conceptos por proceso.
wn_edad integer;
ws_ani varchar(4);
begin
if ((length(ws_reg)<10) or (length(ws_reg)>13)) then
wn_edad:=0;
else
ws_ani:=oracle.substr(ws_reg,5,2);/* dmap converted statement start */
if (cast(ws_ani as integer) > 20) then
ws_ani:= concat('19', ws_ani) ;/* dmap converted statement end *//* dmap converted statement start */
else
ws_ani:= concat('20', ws_ani) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
select cast(((clock_timestamp())-cast(oracle. concat(substr(ws_reg,7,2), '/', oracle.substr(ws_reg,9,2) , '/', ws_ani)  as timestamp(0)))/365 as integer) into strict wn_edad
;/* dmap converted statement end */
end if;
return wn_edad;end;
--dmap converted function completed
$body$
language plpgsql
stable;
