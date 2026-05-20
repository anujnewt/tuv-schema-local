create or replace  function  usrsiho."fn_diftiempo"  (li_minent integer, li_minsal integer) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
li_mindif integer;
li_resmin integer;
ls_mindif varchar(2);
ls_resmin varchar(2);
li_diftie varchar(5);
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
li_mindif := trunc(li_mindif / 60);
ls_mindif := li_mindif;
ls_resmin := li_resmin;/* dmap converted statement start */
return  concat(ls_mindif, '.' , ls_resmin) ;/* dmap converted statement end */end;
--dmap converted function completed
$body$
language plpgsql
stable;
