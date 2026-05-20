create or replace  function  usrdrc.dercorp_panel_control_pkg_es_empresa_fn ( pinidcat numeric, pstvalcatval varchar) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
lstcountemp numeric := 0;
lstresult   varchar(100):= null;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
if pinidcat in (40,1) then
select count(*) into strict lstcountemp
from dercorp_empresa_tab
where  nom_empresa = pstvalcatval;
if lstcountemp > 0 then
--lstresult := disabled;
lstresult := 'readonly';
end if;
elsif pinidcat = 45 then
lstresult := 'disabled';
else
lstresult:=' ';
end if;
return lstresult;end;
$body$
language plpgsql
stable;
