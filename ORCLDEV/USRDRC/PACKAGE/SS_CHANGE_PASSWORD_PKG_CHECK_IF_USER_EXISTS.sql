create or replace procedure usrdrc.ss_change_password_pkg_check_if_user_exists ( pstusername varchar, pstoutprocessresult inout varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
lincountuser numeric;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
begin
select  count(*)  into strict lincountuser
from    ss_user_tab
where   upper(nom_username) = upper(pstusername);
exception
when others then
lincountuser := 0;
end;
if lincountuser > 0 then
pstoutprocessresult := '0';
end if;end;
$body$
language plpgsql
;
