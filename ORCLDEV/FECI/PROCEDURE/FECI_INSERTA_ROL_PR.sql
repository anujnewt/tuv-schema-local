create or replace procedure feci."feci_inserta_rol_pr"  ( p_cod_rol varchar, p_des_rol varchar, p_usuario_creacion numeric, p_operaciones varchar, p_respuesta inout numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
contador        numeric;
rol_id       numeric;
respuesta    numeric;
begin
-- verificar si el usuario ya existe
select count(id_rol) into strict contador from feci_rol_tab where cod_rol = p_cod_rol and nom_rol = p_des_rol;
if contador = 0 then
-- realizar insert de usuario
insert into feci_rol_tab(
cod_rol, nom_rol, fec_creacion, fec_ult_modificacion, id_usuario_creacion, id_usuario_ult_modif, ind_estado
)
values (
p_cod_rol, p_des_rol,clock_timestamp(), clock_timestamp(), p_usuario_creacion, 0, 1
)
returning id_rol into rol_id;
-- procesar el array
for i in 1..regexp_count(p_operaciones, ',') + 1 loop
begin
-- intentar insertar en feci_emp_usu_tab
insert into feci_rol_operacion_tab(
id_rol, id_operacion, fec_creacion, fec_ult_modificacion, id_usuario_creacion, id_usuario_ult_modif, ind_estado
)
values (
rol_id, regexp_substr(p_operaciones, '[^,]+', 1, i), clock_timestamp(), clock_timestamp(), p_usuario_creacion, 0, 1
);
end;
respuesta := rol_id;
end loop;
else
respuesta := -3;
end if;
p_respuesta := respuesta;end;
$body$
language plpgsql
;
