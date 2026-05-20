create or replace  function  labconf.utils_reverse_ (p_expr varchar) returns varchar as $body$
declare
v_result varchar(2000) := null;
begin 

/* dmap converted statement start */
for i in 1..length(p_expr) loop
v_result :=  concat(v_result, oracle.substr(p_expr, -i, 1)) ;/* dmap converted statement end */
end loop;
return v_result;
exception
when others then
raise exception '%', dbms_utility.format_error_stack using errcode = '45000';end;
$body$
language plpgsql
stable;
