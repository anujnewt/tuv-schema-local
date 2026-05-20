create or replace procedure labprod.apilabora_security_agrega_usuario (p_usuario varchar, p_password varchar, p_nombre varchar, p_rol varchar, p_resp inout numeric, p_mensaje inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_code numeric;
v_errm varchar(64);
fila numeric;
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
p_resp := 1;/* dmap converted statement start */
p_mensaje :=  concat('El usuario ', p_usuario , ' se inserto con exito.') ;/* dmap converted statement end */
begin
select id
into strict fila
from usuarioapi
where  usuario = upper(p_usuario);
exception
when no_data_found then
fila := 0;
end;
if ( fila = 0) then
insert into usuarioapi(
id,
usuario,
password,
nombre,
estatus,
rol
)
values (
nextval('req_usuarioapi_seq'),
upper(p_usuario),
apilabora_security_get_hashapi(p_usuario, p_password),
p_nombre,
'A',
p_rol
);
else
begin
p_resp := 0;
p_mensaje := 'El usuario ya existe.';
end;
end if;
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
