create or replace procedure labprod.apilabora_security_activa_usuario (p_usuario varchar, p_resp inout numeric, p_mensaje inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_code numeric;
v_errm varchar(64);
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
p_resp := 1;
p_mensaje := 'Se actualizo con exito.';
update usuarioapi set estatus = 'A'
where usuario = upper(p_usuario);
/* commit; */
exception
when others then
v_code := sqlstate;
v_errm := oracle.substr(sqlerrm, 1 , 64);
p_resp := 0;/* dmap converted statement start */
p_mensaje :=  concat(v_code, ' ' , v_errm) ;/* dmap converted statement end */end;
$body$
language plpgsql
;
