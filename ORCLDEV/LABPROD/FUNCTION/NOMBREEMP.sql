create or replace  function  labprod."nombreemp"  ( nombre varchar ) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
resultado varchar(60);
pos integer;
begin
pos := instr(nombre,'/',1,2);
if pos = 0 then
resultado:= null;
else
resultado := oracle.substr(nombre,pos + 1,60);
end if;
return resultado;end;
--dmap converted function completed
$body$
language plpgsql
stable;
