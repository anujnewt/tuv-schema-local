create or replace procedure labprod."sp_ora_data"  () as $body$
declare
-- pgv moved types start
-- pgv moved types end
ln_ctvo integer;
namedcursor cursor for
select ora_noctvo from com_orac_sips_data where nullif(ora_status::text, '') is null order by ora_noctvo;
begin
open namedcursor;
loop
fetch namedcursor into ln_ctvo;
exit when not found; /* apply on namedcursor */
call sp_com_paso_data (ln_ctvo);
update com_orac_sips_data set ora_status ='SI' where ora_noctvo = ln_ctvo;
end loop;
close namedcursor;end;
$body$
language plpgsql
;
