create or replace procedure usrdrc.dercorp_report_tencasc_pkg_print_message_pr (pistsalida varchar, pistmensaje varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
--dmap conversion comment: global temp variables moved as local temp variables
gincountarr_temp numeric;
--dmap conversion comment: declaration boundary ends
begin
call dmap_extension.pkg_var_dmap_tab_to_gtt_init('USRDRC', 'DERCORP_REPORT_TENCASC_PKG');
--dmap conversion comment: gtt declaration added
if pistsalida = 'LOG'
then
--fnd_file.put_line (fnd_file.log, pistmensaje);
null;
elsif pistsalida = 'OUTPUT'
then
--fnd_file.put_line (fnd_file.output, pistmensaje);
null;
elsif pistsalida = 'DBMS'
then
perform dbms_output.put_line(pistmensaje);
null;
end if;end;
$body$
language plpgsql
;
