create or replace  function  labprod."apellidopat"  ( nombre varchar ) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
resultado varchar(60);
pos integer;
begin
pos := position('/' in nombre);
if pos = 0 then
resultado:= null;
else
resultado := oracle.substr(nombre,1,pos - 1);
end if;
return resultado;end;
--dmap converted function completed
$body$
language plpgsql
stable;
