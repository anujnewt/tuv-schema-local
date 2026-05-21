create or replace procedure fecxc."feci_obtener_empresa_usuario_pr"  ( email varchar,
INOUT feci_cursor refcursor ) as $body$
declare
-- pgv moved types start
-- pgv moved types end

usuario numeric;
begin 

select id_usuario into strict usuario 
from fecxc.feci_usuario_tab 
where des_email = email;

open feci_cursor for
select  id_empresa
from fecxc.feci_emp_usu_tab
where id_usuario =  usuario;
end;
$body$
language plpgsql
;
