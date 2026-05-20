create or replace procedure usrdrc.ss_change_password_pkg_check_if_password_is_valid_pr ( pinuserid numeric, pinrolid numeric, pstnewpasswd1 varchar, pstoutprocessresult inout varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
ginisvalid      numeric;
liminnumcarpas  numeric;
begin
-- package does not have global variables
--dmap conversion comment: gtt declaration added
begin
select  coalesce(val_config,0)
into strict    liminnumcarpas
from    app_config_tab
where   1=1
and     id_config = 19
;
exception
when no_data_found then
liminnumcarpas:=0;
when data_exception then
perform dbms_output.put_line('Conversion of string to number failed');
liminnumcarpas:=0;
when others then
liminnumcarpas:=0;
end;
if pinrolid = 3 then
select  count(*)
into strict    ginisvalid
from (
select 1
where regexp_like(pstnewpasswd1, '*\d', 'c')  -- al menos un numero
and regexp_like(pstnewpasswd1, '*[a-z]', 'c') -- al menos una letra minuscula
and regexp_like(pstnewpasswd1, '*[A-Z]', 'c') -- al menos una letra mayuscula
and regexp_like(pstnewpasswd1, '*[__#$%&()_]','c')-- al menos uno de los siguientes: __#$%
--and (length(pstnewpasswd1)>=10 ) -- igual o mayor a 10 caracteres
and (length(pstnewpasswd1)>=liminnumcarpas ) -- igual o mayor a 10 caracteres
) alias7;
else
select  count(*)
into strict    ginisvalid
from (
select 1
where regexp_like(pstnewpasswd1, '*\d', 'c')  -- al menos un numero
and regexp_like(pstnewpasswd1, '*[a-z]', 'c') -- al menos una letra minuscula
and regexp_like(pstnewpasswd1, '*[A-Z]', 'c') -- al menos una letra mayuscula
and regexp_like(pstnewpasswd1, '*[__#$%&()_]','c')-- al menos uno de los siguientes: __#$%
--and (length(pstnewpasswd1)>=8 ) -- igual o mayor a 8 caracteres
and (length(pstnewpasswd1)>=liminnumcarpas ) -- igual o mayor a 8 caracteres
) alias7;
end if;
if ginisvalid = 0
then
pstoutprocessresult := '0';
end if;end;
$body$
language plpgsql
;
