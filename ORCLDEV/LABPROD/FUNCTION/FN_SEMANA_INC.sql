create or replace  function  labprod."fn_semana_inc"  ( inc_semana numeric ) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
str_semana varchar(3);
begin
str_semana := inc_semana;
str_semana := oracle.substr(str_semana, 1, 2);
return str_semana;end;
--dmap converted function completed
$body$
language plpgsql
stable;
