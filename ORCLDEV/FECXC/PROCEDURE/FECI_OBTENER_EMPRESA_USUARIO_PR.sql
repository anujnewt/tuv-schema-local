create or replace procedure fecxc."feci_obtener_empresa_usuario_pr"  ( email varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
feci_cursor refcursor;
usuario numeric;
begin 

select id_usuario into strict usuario from fecxc.feci_usuario_tab where des_email = email;
open feci_cursor for
select  id_empresa
from fecxc.feci_emp_usu_tab
where id_usuario =  usuario;
dbms_sql_return_result(feci_cursor);end;
$body$
language plpgsql
;
