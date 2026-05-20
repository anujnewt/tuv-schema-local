create or replace  function  labprod."sp_tovarchar2"  (importe nmlohism.his_import%type) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
wd_valor varchar(9);
wd_decimales varchar(2);
begin
wd_valor := floor(importe);
wd_decimales := floor(importe * 100) mod 100;/* dmap converted statement start */
if length(wd_decimales) = 1 then
return  concat(wd_valor, '.' , '0' , wd_decimales) ;/* dmap converted statement end *//* dmap converted statement start */
else
return  concat(wd_valor, '.' , wd_decimales) ;/* dmap converted statement end */
end if;
--wd_valor := to_char(importe, '999999.99');
--select to_char(importe, '999999.99') into wd_valor from dual;
exception
when others then
return '0';end;
--dmap converted function completed
$body$
language plpgsql
stable;
