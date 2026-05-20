create or replace procedure labprod.utils_identity_reset ( v_identityid varchar) as $body$
begin 

current_setting('utils.identitymap')::identity_type(v_identityid) := 0;end;
$body$
language plpgsql
;
