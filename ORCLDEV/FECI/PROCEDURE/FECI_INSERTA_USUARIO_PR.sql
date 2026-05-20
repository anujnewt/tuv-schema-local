create or replace procedure feci."feci_inserta_usuario_pr"  ( p_id_rol numeric, p_email varchar, p_nombres varchar, p_apellidos varchar, p_estatus numeric, p_usuario_alta numeric, p_array varchar, p_id_usuario inout numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
contador        numeric;
id_usuario      numeric;
-- definir una excepci?ersonalizada para el caso de usuario existente
-- definir una excepci?ara controlar el rollback
-- c?o de error de rollback
begin
-- verificar si el usuario ya existe
select count(id_usuario) into strict contador from feci_usuario_tab where des_email = p_email;
if contador = 0 then
-- realizar insert de usuario
begin
insert into feci_usuario_tab(
id_rol, des_email, des_nombres, des_apellidos, fec_creacion, fec_ult_modificacion, id_usuario_creacion, id_usuario_ult_modif, ind_estado
)
values (
p_id_rol, p_email, p_nombres, p_apellidos, clock_timestamp(), clock_timestamp(), p_usuario_alta, 0, p_estatus
)
returning id_usuario into id_usuario;
perform dbms_output.put_line('SE REGISTRA EL USUARIO.');
-- procesar el array
for i in 1..regexp_count(p_array, ',') + 1 loop
begin
-- intentar insertar en feci_emp_usu_tab
insert into feci_emp_usu_tab(
id_usuario, id_empresa, fec_creacion, fec_ult_modificacion, id_usuario_creacion, id_usuario_ult_modif, ind_estado
)
values (
id_usuario, regexp_substr(p_array, '[^,]+', 1, i), clock_timestamp(), clock_timestamp(), p_usuario_alta, 0, 1
);
exception
when others then
p_id_usuario := -5;/* dmap converted statement start */
-- manejar la excepci?e inserci?n feci_emp_usu_tab
perform dbms_output.put_line( concat('Error al insertar en FECI_EMP_USU_TAB: ', sqlerrm)) ;/* dmap converted statement end */
-- hacer rollback
raise exception 'rollback_exception' using errcode = '50002';
end;
end loop;
exception
when sqlstate '50002' then
-- hacer rollback si se levanta la excepci?e rollback
perform dbms_output.put_line('Rollback ejecutado debido a un error.');
rollback;
raise; -- re-levantar la excepci?ara propagarla
end;
else
-- regresar un error controlado de que el usuario ya existe
-- aqu?eber? manejar el error, lanzar una excepci?etc.
perform dbms_output.put_line('Error: El usuario ya existe.');
p_id_usuario := -3;
raise exception 'existe_usuario' using errcode = '50001';
end if;
-- asignar el id_usuario al par?tro de salida
p_id_usuario := id_usuario;
exception
when sqlstate '50001' then
-- puedes manejar la excepci?spec?ca aqu?i es necesario
perform dbms_output.put_line('Manejo de excepci?Usuario ya existe.');
when sqlstate '50002' then
-- puedes manejar la excepci?e rollback aqu?i es necesario
perform dbms_output.put_line('Manejo de excepci?Rollback ejecutado.');/* dmap converted statement start */
when others then
-- manejar otras excepciones fuera del bloque begin
perform dbms_output.put_line( concat('Error general: ', sqlerrm)) ;/* dmap converted statement end */
-- puedes decidir hacer un rollback o realizar otras acciones seg?n tus necesidades
raise;end;
$body$
language plpgsql
;
