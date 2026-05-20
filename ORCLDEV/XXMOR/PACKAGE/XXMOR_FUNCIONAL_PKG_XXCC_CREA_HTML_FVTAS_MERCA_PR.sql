create or replace procedure xxmor.xxmor_funcional_pkg_xxcc_crea_html_fvtas_merca_pr ( piinline varchar ) as $body$
declare
-- pgv moved types start
--dmap moved type current package xxmor_funcional_pkg;
g_conexion              utl_smtp.connection;
-- pgv moved types end
--dmap conversion comment: global temp variables moved as local temp variables
glo_document_temp text;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('XXMOR', 'XXMOR_FUNCIONAL_PKG');/* dmap converted statement start */
--dmap conversion comment: gtt declaration added
-- se va creando el cuerpo del mensaje
--
call dmap_extension.p_dmap_set_pkg_var('XXMOR' , 'XXMOR_FUNCIONAL_PKG', 'GLO_DOCUMENT', 'LONG',(dmap_extension.f_dmap_get_pkg_var('XXMOR' , 'XXMOR_FUNCIONAL_PKG', 'GLO_DOCUMENT', 'LONG', 'N'):: concat(long, piinline)::text) , 'N');/* dmap converted statement end */
utl_smtp.write_data(g_conexion, utl_tcp.crlf);/* dmap converted statement start */
utl_smtp.write_data(g_conexion,  concat(piinline, utl_tcp.crlf)) ;/* dmap converted statement end */
utl_smtp.write_data(g_conexion, utl_tcp.crlf);end;
$body$
language plpgsql
;
