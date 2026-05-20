create or replace  function  xxmor."xxmor_get_userspot_fn"  ( pist_string varchar, piin_element integer, pist_separator varchar ) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
lst_string     varchar(32767);
begin
/* dmap converted statement start */
lst_string :=  concat(pist_string, pist_separator) ;/* dmap converted statement end */
for i in 1 .. piin_element - 1 loop
lst_string := oracle.substr(lst_string,position(pist_separator in lst_string)+1);
end loop;
return oracle.substr(lst_string,1,position(pist_separator in lst_string)-1);end;
--dmap converted function completed
$body$
language plpgsql
stable;
