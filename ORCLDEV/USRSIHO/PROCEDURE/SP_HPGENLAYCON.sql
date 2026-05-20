create or replace procedure usrsiho."sp_hpgenlaycon"  (ws_dgtos varchar, ws_tpago varchar,ws_area varchar, wn_remesa integer,ws_fec_ing timestamp(0), ws_nomarc inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
-- televisa, s.a. de c.v.
--
-- sistema  : rh-2000
-- modulo   : generaci?e layout de remesas (hpgenlay)
--
-- programa : sp_hpgenlaycon
--            obtiene el numero consecutivo de la tabla nmfolrem
--            y asigna y regresa el nombre del layout deacuerdo a
--            la forma de pago.
--
-- autor    : emilio pulido rangel.
-- fecha    : 30 de octubre de 2003.
--
wn_con_sec integer;
ws_con_sec varchar(2);
ws_cadena varchar(8);
begin
-- ----------------------------- bloqueo la tabla nfolrem
-- obtenemos el numero consecutivo deacuerdo a la forma de pago
wn_con_sec := 0;
begin
select lre_consec
into strict wn_con_sec
from usrsiho.nmfolrem
where oracle.substr(lre_nombre,1,2) = ws_dgtos;
exception when no_data_found then wn_con_sec := 0;
end;
-- ----------------------------- checo que el numero consecutivo no este vacio
if wn_con_sec > 0 then
wn_con_sec := wn_con_sec + 1;
if wn_con_sec = 99 then
wn_con_sec := 1;
end if;
-- concatemamos los parametros con el numero consecutivo para formar la cadena del nombre del archivo
ws_con_sec := lpad(wn_con_sec::text, 2, 0::text);/* dmap converted statement start */
ws_cadena := concat( trim(both ws_dgtos), trim(both ws_tpago) , lpad(trim(both ws_area::text), 2, 0::text) , trim(both ws_con_sec)) ;/* dmap converted statement end */
-- actualizamos el numero consecutivo y el nombre del archivo en la tabla nmfolrem <-----
update usrsiho.nmfolrem set lre_consec = wn_con_sec, lre_nombre = ws_cadena
where oracle.substr(lre_nombre,1,2) = ws_dgtos;
else
wn_con_sec := 1;
-- concatemamos los parametros con el numero consecutivo para formar la cadena del nombre del archivo
ws_con_sec := lpad(wn_con_sec::text, 2, 0::text);/* dmap converted statement start */
ws_cadena := concat( trim(both ws_dgtos), trim(both ws_tpago) , lpad(trim(both ws_area::text), 2, 0::text) , trim(both ws_con_sec)) ;/* dmap converted statement end */
-- insertamos el registro en la tabla nmfolrem <-----
insert into usrsiho.nmfolrem( lre_fecha,lre_numrem,lre_consec,lre_nombre )
values ( ws_fec_ing, wn_remesa, wn_con_sec, ws_cadena );
end if;
ws_nomarc := ws_cadena;end;
$body$
language plpgsql
;
