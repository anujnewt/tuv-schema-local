create or replace procedure labprod.apilabora_security_actualiza_usuario (p_usuario varchar, p_new_password varchar, p_nombre varchar, p_estatus varchar, p_rol varchar, p_resp inout numeric, p_mensaje inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_rowid  numeric;
v_code numeric;
v_errm varchar(64);
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
p_resp := 1;/* dmap converted statement start */
p_mensaje :=  concat('El usuario ', p_usuario , ' se actualizo con exito.') ;/* dmap converted statement end */
select id
into strict   v_rowid
from   usuarioapi
where  usuario = upper(p_usuario)
for update;
update usuarioapi
set    password = apilabora_security_get_hashapi(p_usuario, p_new_password),
nombre = p_nombre,
rol = p_rol,
estatus = p_estatus
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
