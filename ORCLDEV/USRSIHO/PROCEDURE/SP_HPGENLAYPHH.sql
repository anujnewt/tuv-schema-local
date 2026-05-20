create or replace procedure usrsiho."sp_hpgenlayphh"  (ws_dgtos varchar, ws_tpago varchar,ws_area varchar, wn_remesa integer,ws_fec_ing timestamp(0), ws_consec varchar,wn_proceso integer, ws_fec_pag timestamp(0),ws_conpagext varchar, ws_remesa varchar, ws_nomarc inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
-- televisa, s.a. de c.v.
--
-- sistema  : rh-2000
-- modulo   : generaci??e layout de remesas (hpgenlay)
--
-- programa : sp_hpgenlayphh
--            asigna y regresa el nombre del layout utilizando la tabla
--            holocalen, deacuerdo a la forma de pago: banamex y host to host
--
-- autor    : emilio pulido rangel.
-- fecha    : 27 de noviembre de 2003.
-- modifico : emilio pulido rangel
-- comentario : 19-01-2005 emilio - se agrego la clave 'ST' que corresponde al archivo normal de layout santander
--              14-02-2005 emilio - se modifico para recibir el numero de remesa en string y poder preguntar por el
--              primer caracter y definir parte del nombre del archivo es decir si el primer digito del no. de remesa es:
--              1 entonces sera 'CH' (chapultepec), si es 2 entonces sera 'SA' (san angel) y por ultimo
--              si es 3 sera 'TE' (televisoras)
--  cig         si es 6 radiopolis 'RD'
--              tambien se modifico para preguntar ahora por ws_tpago ('16' ??t') para saber si se concatena o no
--              la otra parte del archivo (cuando es '16' no se concatena)
-- aedo         09/ene/06 se modifico bf por ba
wn_con_sec integer;
ws_con_sec varchar(3);
ws_cadena varchar(12);
ws_archi varchar(8);
ws_sa_ch_te varchar(2);
--select pam_nompar[1,4] || 'H' || lpad(ws_area::text, 2, 0::text)
--  into ws_archi
--  from glcopams
-- where pam_keypar = 'CCIA'
--   and pam_cvesec = (select pro_keycia
--                       from nmloproc
--                      where pro_keypro = wn_proceso::text);
begin
-- lineas nuevas 14-02-05 ----------
if oracle.substr(ws_remesa,1,1) = '1' then   ---> chapultepec
ws_sa_ch_te := 'CH';
else
if oracle.substr(ws_remesa,1,1) = '2' then   ---> san angel
ws_sa_ch_te := 'SA';
else
if oracle.substr(ws_remesa,1,1) = '3' then   ---> televisoras
ws_sa_ch_te := 'TE';
else
if oracle.substr(ws_remesa,1,1) ='6' then ----> radiopolis
ws_sa_ch_te := 'TL';
else
if  oracle.substr(ws_remesa,1,1) ='4' then
ws_sa_ch_te := 'CF';
else
ws_sa_ch_te := 'XX';
end if;
end if;
end if;
end if;
end if;/* dmap converted statement start */
if ws_dgtos = '16' then   -- -> quiere decir que es banamex
if oracle.substr(ws_tpago,1,2) = 'PR' then   -- -> quiere decir que biene de rechazo
begin
select oracle. concat(substr(pam_folini,1,3), oracle.substr(ws_sa_ch_te,1,1) , 'R' , lpad(wn_proceso::text, 3, 0::text)
) into strict ws_archi
from usrsiho.glcopams
where pam_keypar = 'CCIA'
and pam_cvesec = (select pro_keycia
from usrsiho.nmloproc
where pro_keypro = wn_proceso::text);/* dmap converted statement end */
exception when no_data_found then ws_archi:= null;
end;/* dmap converted statement start */
else
begin
select oracle. concat(substr(pam_folini,1,3), ws_sa_ch_te , lpad(wn_proceso::text, 3, 0::text)
) into strict ws_archi
from usrsiho.glcopams
where pam_keypar = 'CCIA'
and pam_cvesec = (select pro_keycia
from usrsiho.nmloproc
where pro_keypro = wn_proceso::text);/* dmap converted statement end */
exception when no_data_found then ws_archi:= null;
end;
end if;/* dmap converted statement start */
else   -- -> quiere decir que es bank boston host to host o santander
begin
select oracle. concat(substr(pam_nompar,1,4), 'H' , ws_sa_ch_te
) into strict ws_archi
from usrsiho.glcopams
where pam_keypar = 'CCIA'
and pam_cvesec = (select pro_keycia
from nmloproc
where pro_keypro = wn_proceso);/* dmap converted statement end */
exception when no_data_found then ws_archi:= null;
end;
end if;
-- ---------------------- terminan lineas nuevas
-- si no encontramos informacion en la glcopams no hacemos nada
if nullif(trim(both from ws_archi::text), '') is null then
ws_cadena:= null;
ws_nomarc := trim(both ws_cadena);
return;
end if;
-- 10/01/2005 se cambio 'BK' por 'BF' --cig
-- antes si el tipo de pago prevalece en 'PA' o 'BK' quiere decir que no es archivo de rechazo
-- entonces el concecutivo es asignado de la tabla del calendaria holocalen
-- 19-01-2005 emilio - se agrego la clave 'ST' que corresponde al archivo normal de layout santander
-- 09/ene/06 aedo  - se modifico bf por ba
if ws_tpago = 'PA' or ws_tpago = 'BA' or ws_tpago = 'ST' then
if ws_dgtos = '16' then   -- -> quiere decir que es banamex    linea nuevas 14/02/05
ws_cadena := trim(both ws_archi);                         --  linea nuevas 14/02/05
/* dmap converted statement start */
else   -- -> quiere decir que es host to host o santander      linea nuevas 14/02/05
if coalesce(ws_conpagext,0) = 0  then
ws_cadena := concat( trim(both ws_archi), trim(both ws_tpago) , trim(both ws_consec)) ;/* dmap converted statement end *//* dmap converted statement start */
else   -- fue pago extraordinario y concatenamos los 3 caracteres maximos tecleados por el usuario
ws_cadena := concat( trim(both ws_archi), trim(both ws_tpago) , trim(both ws_conpagext)) ;/* dmap converted statement end */
end if;
end if;
-- actualizamos el status a 'S' para decir que ya fue impreso
update usrsiho.holocalen
set ale_status = 'S'
where ale_fecpag = ws_fec_pag
and ale_forpag = ws_tpago;
ws_nomarc := trim(both ws_cadena);
return;
end if;
-- ----------------------------- bloqueo la tabla nfolrem
-- obtenemos el numero consecutivo deacuerdo a la forma de pago
wn_con_sec := 0;
begin
select lre_consec
into strict wn_con_sec
from usrsiho.nmfolrem
where oracle.substr(lre_nombre,1,2) = ws_tpago;
exception when no_data_found then wn_con_sec := 0;
end;
-- ----------------------------- checo que el numero consecutivo no este vacio
if wn_con_sec > 0 then   -- ---> realizamos update
wn_con_sec := wn_con_sec + 1;
if wn_con_sec = 999 then
wn_con_sec := 1;
end if;
-- concatemamos los parametros con el numero consecutivo para formar la cadena del nombre del archivo
ws_con_sec := lpad(wn_con_sec::text, 3, 0::text);
if ws_dgtos = '16' then   -- -> quiere decir que es banamex    linea nuevas 14/02/05
ws_cadena := trim(both ws_archi::text);                        --   linea nuevas 14/02/05
/* dmap converted statement start */
else                      -- -> quiere decir que es host to host o santander      linea nuevas 14/02/05
if coalesce(ws_conpagext,0) = 0 then
ws_cadena := concat( trim(both ws_archi), trim(both ws_tpago) , trim(both ws_con_sec)) ;/* dmap converted statement end *//* dmap converted statement start */
else   -- fue pago extraordinario y concatenamos los 3 caracteres maximos tecleados por el usuario
ws_cadena := concat( trim(both ws_archi), trim(both ws_tpago) , trim(both ws_conpagext)) ;/* dmap converted statement end */
wn_con_sec := wn_con_sec - 1;
end if;
end if;
-- actualizamos el numero consecutivo y el nombre del archivo en la tabla nmfolrem <-----
update usrsiho.nmfolrem set lre_consec =wn_con_sec, lre_nombre = ws_tpago
where oracle.substr(lre_nombre,1,2) = ws_tpago;
else   -- ---> realizamos insert
wn_con_sec := 1;
-- concatemamos los parametros con el numero consecutivo para formar la cadena del nombre del archivo
ws_con_sec := lpad(wn_con_sec::text, 3, 0::text);
if ws_dgtos = '16' then   -- -> quiere decir que es banamex    linea nuevas 14/02/05
ws_cadena := trim(both ws_archi::text);                        --   linea nuevas 14/02/05
/* dmap converted statement start */
else                      -- -> quiere decir que es host to host o santander      linea nuevas 14/02/05
if coalesce(ws_conpagext,0) = 0 then
ws_cadena := concat( trim(both ws_archi), trim(both ws_tpago) , trim(both ws_con_sec)) ;/* dmap converted statement end *//* dmap converted statement start */
else  -- fue pago extraordinario y concatenamos los 3 caracteres maximos tecleados por el usuario
ws_cadena := concat( trim(both ws_archi), trim(both ws_tpago) , trim(both ws_conpagext)) ;/* dmap converted statement end */
end if;
end if;
-- insertamos el registro en la tabla nmfolrem <-----
insert into usrsiho.nmfolrem( lre_fecha,lre_numrem,lre_consec,lre_nombre )
values ( ws_fec_ing, wn_remesa, wn_con_sec, ws_tpago );
end if;
ws_nomarc := trim(both ws_cadena);
return;end;
$body$
language plpgsql
;
