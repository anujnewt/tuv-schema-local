create or replace  function  labprod.utils_identity ( v_identityid varchar, v_seed integer default 1, v_increment integer default 1) returns numeric as $body$
declare
v_current numeric(20) := 0;
begin 

/* dmap converted statement start */
perform dbms_output.put_line( concat('v_current1:', v_current)) ;/* dmap converted statement end */
begin
v_current := current_setting('utils.identitymap')::identity_type(v_identityid);
exception when others then
v_current := 0;
end;/* dmap converted statement start */
perform dbms_output.put_line( concat('v_current2:', v_current)) ;/* dmap converted statement end */
if v_current = 0 then
current_setting('utils.identitymap')::identity_type(v_identityid):= 0;
end if;
v_current := current_setting('utils.identitymap')::identity_type(v_identityid);
v_current := v_current + 1;
current_setting('utils.identitymap')::identity_type(v_identityid) := v_current;
return v_current;end;
$body$
language plpgsql
stable;
