create or replace procedure labprod.apilabora_security_cambia_password (p_usuario varchar, p_old_password varchar, p_new_password varchar, p_resp inout numeric, p_mensaje inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_rowid  numeric;
v_code numeric;
v_errm varchar(64);
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
p_resp := 1;
p_mensaje := 'Se actualizo con exito.';
select id
into strict   v_rowid
from   usuarioapi
where  usuario = upper(p_usuario)
and    password = apilabora_security_get_hashapi(p_usuario, p_old_password)
for update;
update usuarioapi
set    password = apilabora_security_get_hashapi(p_usuario, p_new_password)
where  id    = v_rowid;
/* commit; */
exception
when no_data_found then
p_resp := 0;
p_mensaje := 'El usuario no existe.';
when others then
v_code := sqlstate;
v_errm := oracle.substr(sqlerrm, 1 , 64);
p_resp := 0;/* dmap converted statement start */
p_mensaje :=  concat(v_code, ' ' , v_errm) ;/* dmap converted statement end */end;
$body$
language plpgsql
;
