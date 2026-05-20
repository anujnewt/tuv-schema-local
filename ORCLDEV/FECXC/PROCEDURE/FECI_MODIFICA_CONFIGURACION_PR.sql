create or replace procedure fecxc."feci_modifica_configuracion_pr"  ( pstdias varchar, psthora varchar, pstclasificacion varchar, pinusuario numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin 

update fecxc.feci_configuracion_cat
set des_configuracion = pstdias
,id_usuario_ult_modif = pinusuario
where cod_configuracion = 'DIASOP';
update fecxc.feci_configuracion_cat
set des_configuracion = psthora
,id_usuario_ult_modif = pinusuario
where cod_configuracion = 'HORAEXP';
update fecxc.feci_configuracion_cat
set des_configuracion = pstclasificacion
,id_usuario_ult_modif = pinusuario
where cod_configuracion = 'CLASCLI';
/* commit; */
end;
$body$
language plpgsql
;
