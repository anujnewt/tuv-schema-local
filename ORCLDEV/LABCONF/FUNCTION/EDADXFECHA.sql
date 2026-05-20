create or replace  function  labconf."edadxfecha"  (ws_reg varchar,wd_fec timestamp(0)) returns integer as $body$
declare
-- pgv moved types start
-- pgv moved types end
-- variables para la carga de la tabla de conceptos por proceso.
wn_edad integer;
ws_ani varchar(4);
wd_fec_nac timestamp(0);
begin
if ((length(ws_reg)<10) or (length(ws_reg)>13)) or nullif(ws_reg::text, '') is null then
wn_edad:=0;
else
ws_ani:=oracle.substr(ws_reg,5,2);/* dmap converted statement start */
if (cast(ws_ani as integer) > 20) then
ws_ani:= concat('19', ws_ani) ;/* dmap converted statement end *//* dmap converted statement start */
else
ws_ani:= concat('20', ws_ani) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
wd_fec_nac := to_date(oracle. concat(substr(ws_reg,7,2), '/', oracle.substr(ws_reg,9,2) , '/', ws_ani) ,'MM/DD/YYYY');/* dmap converted statement end */
wn_edad := trunc(months_between( wd_fec, wd_fec_nac ) /12);
end if;
return wn_edad;
exception when others then
return 0;end;
--dmap converted function completed
$body$
language plpgsql
stable;
