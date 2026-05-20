create or replace  function  labprod."fn_decode"  (cadena varchar) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
valor varchar(255);
r bytea;
begin
if (nullif(cadena::text, '') is null or nullif(cadena::text, '') is null) then
valor := null;
else
r := encode(cadena::bytea, 'hex')::bytea;
r := utl_encode.base64_decode(r);
valor := utl_raw.cast_to_varchar2(r);
valor := convert(valor,'WE8MSWIN1252','AL32UTF8');
end if;
return valor;end;
--dmap converted function completed
$body$
language plpgsql
stable;
