create or replace procedure labconf.interfacerecibos_recibostv2016_list ( keypro numeric, keyper varchar, cv_emplist inout refcursor ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
/*keypro  proceso
keyper  periodo */
begin 

/* dmap converted statement start */
-- package does not have global variables
--dmap conversion comment: gtt declaration added
--obtener parametros
begin
open cv_emplist for
select hem_keyemp emp_keyemp ,
concat('RN_', utils_convert_to_varchar2(keypro,4000) , '_' , keyper , '_' , utils_convert_to_varchar2(hem_keyemp,4000) , '.PDF')  pdffilename
from labconf.nmloperi
join labconf.nmlohemp on ( hem_keypro = per_keypro and hem_keyper = per_keyper )
where per_keypro = keypro and per_keyper = keyper;/* dmap converted statement end */
end;
exception
when others then
--call utils_handleerror(sqlcode,sqlerrm);
return;end;
$body$
language plpgsql
;
