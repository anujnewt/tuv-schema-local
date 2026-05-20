create or replace procedure feci."feci_modifica_rol_pr"  ( p_id_rol numeric, p_cod_rol varchar, p_des_rol varchar, p_usuario_creacion numeric, p_operaciones varchar, p_respuesta inout numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
contador        numeric;
respuesta    numeric;
begin
-- verificar si el usuario ya existe
select count(id_rol) into strict contador from feci_rol_tab where id_rol = p_id_rol;
if contador = 0 then
respuesta := -3;
else
-- realizar insert de usuario
update feci_rol_operacion_tab set
ind_estado = 0 ,
fec_ult_modificacion = clock_timestamp(),
id_usuario_ult_modif = p_usuario_creacion
where id_rol = p_id_rol;
update feci_rol_tab
set
cod_rol = p_cod_rol,
nom_rol = p_des_rol,
fec_ult_modificacion = clock_timestamp(),
id_usuario_ult_modif = p_usuario_creacion
where id_rol = p_id_rol;
-- procesar el array
for i in 1..regexp_count(p_operaciones, ',') + 1 loop
begin
-- intentar insertar en feci_emp_usu_tab
insert into feci_rol_operacion_tab(
id_rol, id_operacion, fec_creacion, fec_ult_modificacion, id_usuario_creacion, id_usuario_ult_modif, ind_estado
)
values (
p_id_rol, regexp_substr(p_operaciones, '[^,]+', 1, i), clock_timestamp(), clock_timestamp(), p_usuario_creacion, 0, 1
);
end;
respuesta := p_id_rol;
end loop;
end if;
p_respuesta := respuesta;end;
$body$
language plpgsql
;
