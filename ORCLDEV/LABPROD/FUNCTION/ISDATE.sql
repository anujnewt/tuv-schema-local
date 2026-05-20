create or replace  function  labprod."isdate"  ( p_date_str varchar , p_date_fmt varchar ) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
return_value varchar(5);
l_date timestamp(0);
begin
begin
l_date := to_date(p_date_str, p_date_fmt);
return_value := 'TRUE';
exception
when others then
return_value := 'FALSE';
end;
return return_value;end;
--dmap converted function completed
$body$
language plpgsql
stable;
