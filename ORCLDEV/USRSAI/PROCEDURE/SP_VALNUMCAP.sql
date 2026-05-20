create or replace procedure usrsai."sp_valnumcap"  ( cadena varchar, conta inout numeric) as $body$
declare
-- pgv moved types start
-- pgv moved types end
longitud numeric;
i numeric;
x char(1);
begin
longitud := length(cadena);
conta := 0;
for i in 1..longitud loop
x := oracle.substr(cadena, i, i);
if x = ',' then
conta := conta + 1;
end if;
if i=longitud then
conta := conta + 1;
end if;
end loop;end;
$body$
language plpgsql
;
