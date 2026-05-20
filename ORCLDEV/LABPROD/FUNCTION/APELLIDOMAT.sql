create or replace  function  labprod."apellidomat"  ( nombre varchar ) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
resultado varchar(60);
pos1 integer;
pos2 integer;
begin
pos1 := position('/' in nombre);
pos2 := instr(nombre,'/',1,2);
if pos1 = 0 or pos2 = 0 then
resultado:= null;
else
resultado := oracle.substr(nombre,pos1 + 1,pos2 - pos1 -1);
end if;
return resultado;end;
--dmap converted function completed
$body$
language plpgsql
stable;
