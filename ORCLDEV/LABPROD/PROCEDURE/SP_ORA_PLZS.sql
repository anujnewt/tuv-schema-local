create or replace procedure labprod."sp_ora_plzs"  () as $body$
declare
-- pgv moved types start
-- pgv moved types end
ln_ctvo integer;
namedcursor cursor for
select ora_noctvo from com_orac_sips_plzs where nullif(ora_status::text, '') is null order by ora_noctvo;
begin
open namedcursor;
loop
fetch namedcursor into ln_ctvo;
exit when not found; /* apply on namedcursor */
call sp_orac_sips_plzs (ln_ctvo);
update com_orac_sips_plzs set ora_status ='SI' where ora_noctvo = ln_ctvo;
end loop;
close namedcursor;end;
$body$
language plpgsql
;
