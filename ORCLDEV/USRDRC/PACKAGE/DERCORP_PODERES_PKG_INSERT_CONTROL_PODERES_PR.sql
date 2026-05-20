create or replace procedure usrdrc.dercorp_poderes_pkg_insert_control_poderes_pr (pinidpoder numeric ,pinidempresa numeric ,iduser numeric ,pstouterror inout varchar) as $body$
declare
-- pgv moved types start
-- pgv moved types end
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
insert into dercorp_control_poderes_row(id_user,
id_empresa,
id_poder)
values (iduser,
pinidempresa,
pinidpoder);end;
$body$
language plpgsql
;
