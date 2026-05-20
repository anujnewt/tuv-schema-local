create or replace procedure usrdrc.pendium_ss_log_stat_conect_pkg_insertar_log_stat_conect_pr (piiduser integer) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
insert into pendium_ss_log_stat_conect_tab(id_user
,fec_log)values (piiduser
,clock_timestamp()
);
exception
when others then
null;end;
$body$
language plpgsql
;
