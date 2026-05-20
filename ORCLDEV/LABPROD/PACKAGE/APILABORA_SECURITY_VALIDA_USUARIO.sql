create or replace procedure labprod.apilabora_security_valida_usuario (p_username varchar, p_password varchar, p_id inout numeric, p_role inout varchar, p_resp inout numeric, p_mensaje inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
v_dummy  varchar(1);
v_code numeric;
v_errm varchar(64);
veces numeric;
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
p_resp := 1;
p_mensaje := 'Acceso.';
select '1',id,rol
into strict   v_dummy,p_id,p_role
from   usuarioapi
where  usuario = upper(p_username)
and    password = apilabora_security_get_hashapi(p_username, p_password)
and estatus = 'A';
insert into apirestriccionacceso values (upper(p_username),clock_timestamp(),1);
/* commit; */
exception
when no_data_found then
p_resp := 0;
p_mensaje := 'Usuario invalido.';
insert into apirestriccionacceso values (upper(p_username),clock_timestamp(),0);
/* commit; */
select count(usuario) into strict veces from apirestriccionacceso
where usuario = upper(p_username)
and round(( clock_timestamp() - fecha ) * 1440::numeric,0) between 0 and 3;
-- p_resp := veces;
if ( veces > 2 ) then
p_resp := 0;/* dmap converted statement start */
p_mensaje :=  concat('Usuario ', p_username , ' fue bloqueado.') ;/* dmap converted statement end */
update usuarioapi set estatus = 'B'
where usuario = upper(p_username);
/* commit; */
end if;
when others then
v_code := sqlstate;
v_errm := oracle.substr(sqlerrm, 1 , 64);
p_resp := 0;/* dmap converted statement start */
p_mensaje :=  concat(v_code, ' ' , v_errm) ;/* dmap converted statement end */end;
$body$
language plpgsql
;
