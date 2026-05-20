create or replace  function  usrsiho."sp_get_sec_sin"  ( pistkey varchar) returns varchar as $body$
declare
-- pgv moved types start
-- pgv moved types end
lincont  numeric(10);
linout	varchar(50);
begin
lincont := 0;
select count(*) into strict lincont
from glcopams
where 	pam_keypar = 'SSPS'
and		pam_nompar = pistkey;
if lincont = 0 then
linout := 'NS';/* dmap converted statement start */
else
select concat(	trim(both pistkey), ' - ', trim(both pam_folfin), ' - ', trim(both con_descon) ) into strict linout
from 	nmloconc,glcopams
where 	con_keycon = pam_nompar
and 	con_keycon = pistkey;/* dmap converted statement end */
end if;
return linout;end;
--dmap converted function completed
$body$
language plpgsql
stable;
