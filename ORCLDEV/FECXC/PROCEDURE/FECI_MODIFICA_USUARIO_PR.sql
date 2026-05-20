create or replace procedure fecxc."feci_modifica_usuario_pr"  ( p_id_usuario numeric, p_id_rol numeric, p_email varchar, p_nombres varchar, p_apellidos varchar, p_estatus numeric, p_usuario_alta numeric, p_array varchar, p_respuesta inout numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
contador            numeric;
contador_existente  numeric;
begin 

-- verificar si el usuario existe por el id
select count(id_usuario) into strict contador from feci_usuario_tab where id_usuario = p_id_usuario;
if contador > 0 then
-- verificar si el correo electr?o ya est?sociado a otro usuario
select count(id_usuario) into strict contador_existente from feci_usuario_tab
where id_usuario <> p_id_usuario and des_email = p_email;
if contador_existente > 0 then
-- error: usuario asociado a otro registro
p_respuesta := -4;
else
-- actualizar el usuario en feci_usuario_tab
update feci_usuario_tab
set
id_rol = p_id_rol,
des_email = p_email,
des_nombres = p_nombres,
des_apellidos = p_apellidos,
fec_ult_modificacion = clock_timestamp(),
id_usuario_ult_modif = p_usuario_alta,
ind_estado = p_estatus
where
id_usuario = p_id_usuario;
-- desactivar registros existentes en feci_emp_usu_tab
update feci_emp_usu_tab
set ind_estado = 0,
id_usuario_ult_modif = p_usuario_alta,
fec_ult_modificacion = clock_timestamp()
where id_usuario = p_id_usuario;
-- insertar nuevos registros en feci_emp_usu_tab
for i in 1..regexp_count(p_array, ',') + 1 loop
insert into feci_emp_usu_tab(
id_usuario, id_empresa, fec_creacion, fec_ult_modificacion, id_usuario_creacion, id_usuario_ult_modif, ind_estado
)
values (
p_id_usuario, regexp_substr(p_array, '[^,]+', 1, i), clock_timestamp(), clock_timestamp(), p_usuario_alta, 0, 1
);
end loop;
p_respuesta := p_id_usuario;
end if;
else
-- error: usuario inexistente por id
p_respuesta := -3;
end if;/* dmap converted statement start */
exception
when others then
-- manejar otras excepciones
perform dbms_output.put_line( concat('Error: ', sqlerrm)) ;/* dmap converted statement end */
p_respuesta := -1; -- c?o de error personalizado, ajusta seg?n sea necesario
end;
$body$
language plpgsql
;
