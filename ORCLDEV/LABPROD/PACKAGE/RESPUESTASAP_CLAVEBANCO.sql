create or replace procedure labprod.respuestasap_clavebanco ( emp_forpag numeric, emp_cveban inout varchar ) as $body$
declare
-- pgv moved types start
-- pgv moved types end
emp_cveban2 varchar(7);
begin 

-- package does not have global variables
--dmap conversion comment: gtt declaration added
select pam_folini into strict emp_cveban from labprod.glcopams where pam_keypar = 'FP' and pam_cvesec =clavebanco.emp_forpag;
exception when no_data_found then
emp_cveban := null;end;
$body$
language plpgsql
;
