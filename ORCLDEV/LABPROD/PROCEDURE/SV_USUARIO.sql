create or replace procedure labprod."sv_usuario"  ( usuarios_object inout refcursor) as $body$
--  nombre out char,
--status out char,
--numero out number)
declare
-- pgv moved types start
-- pgv moved types end
begin
open usuarios_object for
select usuario, plz_fe1aux
from mail, eocoplza
where mail.emp_keyemp = eocoplza.plz_keyemp
and nullif(usuario::text, '') is not null
and nullif(emp_keyemp::text, '') is not null
and nullif(plz_fe1aux::text, '') is not null
and plz_fe1aux = not null;
-- return usuarios_object;
end;
$body$
language plpgsql
;
