create or replace procedure xxmor.xxmor_funcional_pkg_xxmor_revisa_error_archivo_pr ( piinidarchivosol numeric ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
lin_id_archivo  numeric := null;
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');
--dmap conversion comment: gtt declaration added
select count(arch.id_archivo_sol)
into strict   lin_id_archivo
from   xxmor.xxmor_solicitudes_arch_tab arch
where  arch.archivo_procesado = 3
and    arch.id_archivo_sol    = piinidarchivosol;
if  lin_id_archivo > 0 then
update xxmor.xxmor_solicitudes_arch_tab arch
set    archivo_procesado = 4
where  arch.id_archivo_sol    = lin_id_archivo;/* dmap converted statement start */
perform dbms_output.put_line( concat('lin_id_archivo:', lin_id_archivo, ' Actualizado en XXMOR_SOLICITUDES_ARCH_TAB! ')) ;/* dmap converted statement end */
end if;/* dmap converted statement start */
exception
when others then
insert into xxmor_log_errores_tab(id_error, desc_error, archivo_error, metodo_error)
values (nextval('xxmor_log_error_sq'),
concat('Error al validar si el id_archivo:', piinidarchivosol, ' tiene error para corregir') ,
null,
'Procedimiento XXMOR_REVISA_ERROR_ARCHIVO_PR'
);/* dmap converted statement end */end;
$body$
language plpgsql
;
